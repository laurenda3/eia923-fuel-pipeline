with plant_source as (
    select * from {{ ref('stg_plants') }}
)

select
    plant_id,
    plant_name,
    plant_state,
    sector_number,
    naics_code,
    balancing_authority_code,
    balancing_authority_name,
    is_combined_heat_and_power
from plant_source
