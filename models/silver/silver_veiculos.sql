{{ config(unique_key='id_veiculos') }}

with source as(

    select 
        id_veiculos,
        {{ normalize_text('nome') }} as nome,
        {{ standardize_vehicle_type('tipo') }} as tipo_normalizado,
        cast(valor as decimal(10, 2)) as valor,
        data_inclusao,
        data_atualizacao,
        {{ modification_timestamp_expr() }} as _source_modified_at
    from {{ ref('bronze_veiculos') }}
    where id_veiculos is not null 

    {{ get_incremental_watermark('_source_modified_at') }}

),

ranked as (
    select 
        source.*,
        row_number() over(
            partition by id_veiculos
            order by _source_modified_at desc
        ) as _rn 
    from source


),

deduplicated as (

    select 
        id_veiculos,
        nome,
        tipo_normalizado,
        valor,
        data_inclusao,
        data_atualizacao,
        _source_modified_at
    from ranked
    where _rn = 1


),

tipo_enriquecido as (

    select 
        d.id_veiculos,
        d.nome,
        d.tipo_normalizado as tipo,
        coalesce(t.tipo_padronizado, d.tipo_normalizado) as tipo_padronizado,
        coalesce(t.categoria, 'Outros') as categoria_veiculos,
        d.valor,
        d.data_inclusao,
        d.data_atualizacao,
        d._source_modified_at
    from deduplicated as d 
    left join {{ ref ('seed_tipos_veiculos') }} as t 
        on d.tipo_normalizado = t.tipo_origem

),

segmento_enriquecido as (

    select
        v.id_veiculos,
        v.nome,
        v.tipo,
        v.tipo_padronizado,
        v.categoria_veiculos,
        v.valor,
        s.segmento as segmento_veiculo,
        s.ordem_segmento,
        v.data_inclusao,
        v.data_atualizacao,
        v._source_modified_at
    from tipo_enriquecido as v 
    left join {{ ref('seed_segmentos_veiculos') }} as s 
        on 
            v.valor >= s.valor_minimo
            and (s.valor_maximo is null or v.valor <= s.valor_maximo)

)

select 
    id_veiculos,
    nome,
    tipo,
    tipo_padronizado,
    categoria_veiculos,
    valor,
    segmento_veiculo,
    ordem_segmento,
    data_inclusao,
    data_atualizacao,
    _source_modified_at,
    {{ audit_columns() }}
from segmento_enriquecido
