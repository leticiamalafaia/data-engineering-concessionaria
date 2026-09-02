SELECT 
    id_estados,
    {{ safe_trim('estado') }} as estado,
    {{ safe_trim('sigla') }} as sigla,
    data_inclusao,
    data_atualizacao,
    current_timestamp as _loaded_at

FROM
    pg_origem.public.estados