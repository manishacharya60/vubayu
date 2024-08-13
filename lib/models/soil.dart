class Soil {
  final String color;
  final String soilType;
  final String structure;
  final String moistureContent;
  final String organicMatter;
  final String rootGrowth;
  final String porosity;
  final String rocksPresence;
  final double carbonSequestrationPotential;
  final double waterRetentionCapacity;
  final double aggregateStabilityValue;
  final double soilRespirationRate;
  final double matterContentPerSquarePixels;
  final double carbonInput;
  final double gasExchangeCapacity;
  final double weatheringRate;
  final List<String> endangeredSpecies;
  final List<String> cashCrops;
  final List<String> farmingTools;
  final List<String> insecticidesPesticidesFertilizers;
  final List<String> additionalUses;
  final String specificHeatCapacity;
  final List<String> environmentalImpact;
  final List<String> naturalDisasterRisks;

  Soil({
    required this.color,
    required this.soilType,
    required this.structure,
    required this.moistureContent,
    required this.organicMatter,
    required this.rootGrowth,
    required this.porosity,
    required this.rocksPresence,
    required this.carbonSequestrationPotential,
    required this.waterRetentionCapacity,
    required this.aggregateStabilityValue,
    required this.soilRespirationRate,
    required this.matterContentPerSquarePixels,
    required this.carbonInput,
    required this.gasExchangeCapacity,
    required this.weatheringRate,
    required this.endangeredSpecies,
    required this.cashCrops,
    required this.farmingTools,
    required this.insecticidesPesticidesFertilizers,
    required this.additionalUses,
    required this.specificHeatCapacity,
    required this.environmentalImpact,
    required this.naturalDisasterRisks,
  });

  factory Soil.fromJson(Map<String, dynamic> json) {
    return Soil(
      color: json['color'],
      soilType: json['soil_type'],
      structure: json['structure'],
      moistureContent: json['moisture_content'],
      organicMatter: json['organic_matter'],
      rootGrowth: json['root_growth'],
      porosity: json['porosity'],
      rocksPresence: json['rocks_presence'],
      carbonSequestrationPotential: json['carbon_sequestration_potential'],
      waterRetentionCapacity: json['water_retention_(hold)_capacity'],
      aggregateStabilityValue: json['aggregate_stability_value '],
      soilRespirationRate: json['soil_respiration_rate'],
      matterContentPerSquarePixels: json['matter_content_per_square_pixels'],
      carbonInput: json['carbon_input'],
      gasExchangeCapacity: json['gas_exchange _capacity'],
      weatheringRate: json['weathering_rate'],
      endangeredSpecies: List<String>.from(json['endangered_species']),
      cashCrops: List<String>.from(json['cash_crops']),
      farmingTools: List<String>.from(json['farming_tools']),
      insecticidesPesticidesFertilizers:
          List<String>.from(json['insecticides_pesticides_fertilizers']),
      additionalUses: List<String>.from(json['additional_uses']),
      specificHeatCapacity: json['specific_heat_capacity'],
      environmentalImpact: List<String>.from(json['environmental_impact']),
      naturalDisasterRisks: List<String>.from(json['natural_disaster_risks']),
    );
  }
}
