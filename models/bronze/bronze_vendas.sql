{{ config(
    pre_hook=[
        "create table if not exists main._model_run_log (model_name varchar, invocation_id varchar, started_at timestamp)",
        "insert into main._model_run_log values ('{{ this.identifier }}', '{{ invocation_id }}', current_timestamp)"
    ]
) }}


SELECT
    id_vendas,
    id_veiculos,
    id_concessionarias,
    id_vendedores,
    id_clientes,
    cast(valor_pago as decimal(10, 2)) as valor_pago,
    data_venda,
    data_inclusao,
    data_atualizacao,
    current_timestamp as _loaded_at   
FROM pg_origem.public.vendas