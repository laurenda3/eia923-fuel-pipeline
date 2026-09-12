SELECT 
    d.plant_name,
    d.plant_state,
    f.fuel_type_code,
    f.active_boiler_count,
    ROUND(f.annual_fuel_consumed, 0) AS total_fuel_consumed,
    f.physical_unit_label
FROM fct_plant_fuel_consumption f
JOIN dim_plants d 
    ON f.plant_id = d.plant_id
WHERE f.active_boiler_count >= 4
ORDER BY f.active_boiler_count DESC, total_fuel_consumed DESC
LIMIT 5;
