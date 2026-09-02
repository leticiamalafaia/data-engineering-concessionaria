SELECT 
    id_cidades,
    {{ safe_trim('cidade') }} as cidade,
    id_estados,
    data_inclusao,
    data_atualizacao,
    current_timestamp as _loaded_at
FROM pg_origem.public.cidades