SELECT
    id_vendedores,
    {{ safe_trim('nome') }} as nome,
    id_concessionarias,
    data_inclusao,
    data_atualizacao,
    current_timestamp as _loaded_at
FROM pg_origem.public.vendedores