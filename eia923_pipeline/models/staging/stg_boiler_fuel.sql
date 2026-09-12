with source_data as (
    select * from {{ source('eia923_raw', 'raw_boiler_fuel') }}
),

cleaned as (
    select
        cast(plant_id as integer) as plant_id,
        trim(plant_name) as plant_name,
        trim(plant_state) as plant_state,
        cast(year as integer) as report_year,
        trim(boiler_id) as boiler_id,
        trim(reported_prime_mover) as prime_mover,
        trim(reported_fuel_type_code) as fuel_type_code,
        trim(physical_unit_label) as physical_unit_label,
        try_cast(replace(coalesce(nullif(trim(total_fuel_consumption_quantity), ''), '0'), ',', '') as double) as total_fuel_consumption_quantity
    from source_data
    where plant_id is not null
)

select * from cleaned
