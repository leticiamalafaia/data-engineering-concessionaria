{% test must_be_emplty(model) %}
    select * 
    from {{ model }}
{% endtest %}