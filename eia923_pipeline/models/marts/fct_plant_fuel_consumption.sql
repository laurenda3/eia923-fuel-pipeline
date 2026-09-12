with enriched_fuel as (
    select * from {{ ref('int_boiler_fuel_enriched') }}
)

select
    plant_id,
    fuel_type_code,
    physical_unit_label,
    report_year,
    count(distinct boiler_id) as active_boiler_count,
    round(sum(total_fuel_consumption_quantity), 2) as annual_fuel_consumed
from enriched_fuel
group by
    plant_id,
    fuel_type_code,
    physical_unit_label,
    report_year
