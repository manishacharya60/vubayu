import 'package:flutter/material.dart';

String buildPrompt(
    BuildContext context, String? location, TimeOfDay time, String season) {
  final timeString = time.format(context);

  final mainPrompt = '''
    I’m trying to create an app that analyzes soil sample images to predict the various properties. Please help me out:

    Please analyze the provided image of a soil sample clicked at time $timeString from $location during the $season season based on the following properties: color, texture, structure, moisture content, presence of organic matter, and root growth. Provide detailed observations and classifications for each property. Additionally, offer practical recommendations for agriculture and other uses based on the findings. Include information on endangered species, suitable cash crops, farming tools, recommended insecticides and pesticides, additional uses, specific heat capacity, environmental impact, and natural disaster risk.

    Color:
    1.Analyze the soil color to indicate organic matter content, drainage conditions, and the presence of certain minerals.
    2.Dark soils often have higher organic content.
    3.Red or yellow soils may indicate the presence of iron oxides.
    4.Determine and describe the soil color.

    Soil Type:
    1.Estimate the soil type by analyzing the proportion of sand, silt, and clay particles.
    2.Sandy soils appear gritty.
    3.Silty soils appear smooth.
    4.Clay soils appear sticky and wet.
    5.Categorize the soil type.

    Porosity: 
    1.Soil porosity is the measure of the void spaces in soil and is crucial for determining water retention and air circulation within the soil.
    2.High porosity indicates more space for air and water, often found in sandy soils.
    3.Medium porosity is typical of silty soils, balancing water retention and drainage.
    4.Low porosity suggests compacted or clayey soils, with limited space for air and water movement.
    
    Structure:
    1.Assess the soil structure, which describes how soil particles are grouped together into aggregates.
    2.Good soil structure is crumbly and granular, indicating good aeration and drainage.
    3.Poor soil structure may be compacted or cloddy.
    4.Classify the soil structure.
    5.Moisture Content:
    6.Observe the dampness of the soil to estimate its moisture level.
    7.Determine the moisture content.

    Presence of Organic Matter:
    1.Look for visible organic matter such as decomposed leaves and roots.
    2.Detect and describe the presence of organic matter.
    
    Root Growth:
    1.Inspect root growth to provide information about soil health.
    2.Describe the observed root growth.

    Practical Recommendations:
    
    Endangered Species:
    1.List some endangered plants, worms, insects, or small animals that could flourish in this soil.
    
    Cash Crops:
    1.Suggest appropriate cash crops that can be cultivated in this area.
    
    Farming Tools:
    1.Recommend suitable tools for farming in this area that won't destroy the soil structure.
    
    Insecticides and Pesticides:
    1.Advise on the types of insecticides, pesticides, or fertilizers that could be used.
    
    Additional Uses:
    1.Identify any additional uses for the soil, such as for clay making or pottery.
    
    Specific Heat Capacity:
    1.Identify if this type of soil cools or heats faster or slower.
    
    Environmental Impact:
    1.Predict if this type of soil is responsible for desertification, drought, salinization, glaciation, or permafrost formation.
    
    Natural Disaster Risk:
    1.Identify if this soil is prone to landslide, earthquake, or could be easily carried away by flood or other natural disasters.
    ''';

  const format = '''
  Please provide the response in JSON format such that it can be parsed and easily displayed in my app. The JSON should have the following structure. Don't use more than two words:

  {
    "color": \$color,
    "soil_type": \$soil_type,
    "structure": \$structure,
    "moisture_content": \$moisture_content,
    "organic_matter": \$organic_matter,
    "root_growth": \$root_growth,
    "porosity": \$porosity,
    "rocks_presence": \$rocks_presence,
    "carbon_sequestration_potential": \$carbon_sequestration_potential,
    "water_retention_(hold)_capacity": \$water_retention_hold_capacity,
    "aggregate_stability_value ": \$aggregate_stability_value,
    "soil_respiration_rate": \$soil_respiration_rate,
    "matter_content_per_square_pixels": \$matter_content_per_square_pixels,
    "carbon_input": \$carbon_input,
    "gas_exchange _capacity": \$gas_exchange_capacity,
    "weathering_rate": \$weathering_rate,
    "endangered_species": \$endangered_species,
    "cash_crops": \$cash_crops,
    "farming_tools": \$farming_tools,
    "insecticides_pesticides_fertilizers": \$insecticides_pesticides_fertilizers,
    "additional_uses": \$additional_uses,
    "specific_heat_capacity": \$specific_heat_capacity,
    "environmental_impact": \$environmental_impact,
    "natural_disaster_risks": \$natural_disaster_risks
}

color, soil_type (soil type should be Sandy, Silty, Clayey, Loamy, Peaty), porosity (high, medium, low), root_growth, rocks_presence, structure, moisture_content (Damp, Dry), organic_matter (Present, Absent), specific_heat_capacity (High or Low) should be of type String.
carbon_sequestration_potential, water_retention_hold_capacity, aggregate_stability_value, soil_respiration_rate, matter_content_per_square_pixels, carbon_input, gas_exchange_capacity, weathering_rate, should be of type double out of 100%.
endangered_species, cash_crops, farming_tools, insecticides_pesticides_fertilizers, additional_uses, environmental_impact, natural_disaster_risks should be of type List<String> with exactly 2 items.
  ''';

  return mainPrompt + format;
}
