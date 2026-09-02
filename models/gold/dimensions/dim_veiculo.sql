select 
    {{ generate_surrogate_key(['id_veiculos']) }} as sk_veiculo,
    id_veiculos,
    nome,
    tipo,
    tipo_padronizado,
    categoria_veiculos,
    valor as valor_tabela,
    segmento_veiculo,
    ordem_segmento,
    {{ audit_columns() }}
from {{ ref('silver_veiculos') }} 