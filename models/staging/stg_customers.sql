with source as (
    select * from {{ ref('raw_customers') }}
),

transformed as (
    select
        id as customer_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,
        trim(first_name) || ' ' || trim(last_name) as full_name,
        current_timestamp as created_at
    from source
)

select * from transformed
