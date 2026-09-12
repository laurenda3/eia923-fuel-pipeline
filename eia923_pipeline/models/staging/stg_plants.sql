with source_data as (
    select * from {{ source('eia923_raw', 'raw_plant_frame') }}
),

renamed_and_ranked as (
    select
        cast(plant_id as integer) as plant_id,
        trim(plant_name) as plant_name,
        trim(plant_state) as plant_state,
        cast(sector_number as integer) as sector_number,
        cast(naics_code as integer) as naics_code,
        trim(balancing_authority_code) as balancing_authority_code,
        trim(balancing_authority_name) as balancing_authority_name,
        case 
            when upper(trim(combined_heat_and_power_status)) = 'Y' then true 
            else false 
        end as is_combined_heat_and_power,
        row_number() over (
            partition by cast(plant_id as integer) 
            order by coalesce(year, 0) desc
        ) as row_num
    from source_data
    where plant_id is not null
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
from renamed_and_ranked
where row_num = 1
