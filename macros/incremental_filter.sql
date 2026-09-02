{% macro modification_timestamp_expr(inclusion_col='data_inclusao', update_col='data_atualizacao') -%}
    greatest(
        coalesce( {{ inclusion_col }}, timestamp '1900-01-01 00:00:00'),
        coalesce( {{ update_col }}, timestamp '1900-01-01 00:00:00')
    )
{%- endmacro %}

{% macro get_incremental_watermark(modification_ts_column, watermark_column=none) -%}
    {%- set watermark_column = watermark_column or modification_ts_column -%}
    {% if is_incremental() %}
    and {{ modification_ts_column }} >= (
        select coalesce(max({{ watermark_column }}), timestamp '1900-01-01 00:00:00')
        from {{ this }}
    ) - interval '{{ var("incremental_safety_window_minutes", 5) }} minutes'
    {% endif %}
{%- endmacro %}