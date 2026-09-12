with boiler_fuel as (
    select * from {{ ref('stg_boiler_fuel') }}
),

plants as (
    select * from {{ ref('stg_plants') }}
)

select
    bf.plant_id,
    p.plant_name,
    p.plant_state,
    p.balancing_authority_code,
    p.balancing_authority_name,
    p.is_combined_heat_and_power,
    bf.report_year,
    bf.boiler_id,
    bf.prime_mover,
    bf.fuel_type_code,
    bf.physical_unit_label,
    bf.total_fuel_consumption_quantity
from boiler_fuel bf
left join plants p
    on bf.plant_id = p.plant_id
