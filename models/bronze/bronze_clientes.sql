SELECT
    id_clientes,
    {{ safe_trim('cliente') }} as cliente,
    {{ safe_trim('endereco') }} as endereco,
    id_concessionarias,
    data_inclusao,
    data_atualizacao,
    current_timestamp as _loaded_at
FROM pg_origem.public.clientes