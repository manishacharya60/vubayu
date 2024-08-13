import 'package:flutter/material.dart';

class Results2Page extends StatelessWidget {
  final String specificHeatCapacity;
  final String seedsCashCropsValue1;
  final String seedsCashCropsValue2;
  final String endangeredSpeciesValue1;
  final String endangeredSpeciesValue2;
  final String farmingToolsValue1;
  final String farmingToolsValue2;
  final String insecticidesPesticides1;
  final String insecticidesPesticides2;
  final String additionalUse1;
  final String additionalUse2;
  final String bestCaptureValue1;
  final String bestCaptureValue2;
  final String cultivationSystemValue1;
  final String cultivationSystemValue2;
  final String environmentalImpactValue1;
  final String environmentalImpactValue2;
  final String naturalDisasterValue1;
  final String naturalDisasterValue2;

  const Results2Page({
    super.key,
    this.specificHeatCapacity = 'Value',
    this.seedsCashCropsValue1 = 'Value 1',
    this.seedsCashCropsValue2 = 'Value 2',
    this.endangeredSpeciesValue1 = 'Value 1',
    this.endangeredSpeciesValue2 = 'Value 2',
    this.farmingToolsValue1 = 'Value 1',
    this.farmingToolsValue2 = 'Value 2',
    this.insecticidesPesticides1 = 'Value 1',
    this.insecticidesPesticides2 = 'Value 2',
    this.additionalUse1 = 'Value 1',
    this.additionalUse2 = 'Value 2',
    this.bestCaptureValue1 = 'Value 1',
    this.bestCaptureValue2 = 'Value 2',
    this.cultivationSystemValue1 = 'Value',
    this.cultivationSystemValue2 = 'Value',
    this.environmentalImpactValue1 = 'Value',
    this.environmentalImpactValue2 = 'Value',
    this.naturalDisasterValue1 = 'Value',
    this.naturalDisasterValue2 = 'Value',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a282f),
      appBar: AppBar(
        backgroundColor: Color(0xFF1a282f),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF00ffbc)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('vubayu results',
                style: TextStyle(
                    color: Color(0xFF00ffbc),
                    fontSize: 20,
                    fontFamily: 'Quicksand')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00ffbc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'ADDITIONALS',
                    style: TextStyle(
                      color: Color(0xFF1a282f),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildSection('Seeds for Cash Crops', seedsCashCropsValue1,
                  seedsCashCropsValue2, Icons.grass, Icons.eco),
              _buildSection('Endangered Species', endangeredSpeciesValue1,
                  endangeredSpeciesValue2, Icons.pets, Icons.bug_report),
              _buildSection('Sustainable Farming Tools', farmingToolsValue1,
                  farmingToolsValue2, Icons.agriculture, Icons.build),
              _buildExpandableCard(
                'Insecticides, Pesticides & Fertilizers',
                '1. $insecticidesPesticides1',
                '2. $insecticidesPesticides2',
              ),
              _buildExpandableCard(
                'Additional Uses',
                'Use 1: $additionalUse1',
                'Use 2: $additionalUse2',
              ),
              _buildExpandableCard(
                'Thermal & Environmental Impact',
                'Heat Capacity: $specificHeatCapacity',
                'Impacts : $environmentalImpactValue1, $environmentalImpactValue2',
              ),
              _buildExpandableCard(
                  'Natural Disaster Risks',
                  'Risk 1: $naturalDisasterValue1',
                  'Risk 2: $naturalDisasterValue2'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String value1, String value2,
      IconData icon1, IconData icon2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: Color(0xFF00ffbc),
                fontSize: 16,
                fontFamily: 'Quicksand')),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildCard(value1, icon1)),
            SizedBox(width: 16),
            Expanded(child: _buildCard(value2, icon2)),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCard(String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2d3e50).withOpacity(1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF00ffbc), size: 40),
          SizedBox(height: 8),
          Text(value,
              style:
                  TextStyle(color: Color(0xFF00ffbc), fontFamily: 'Quicksand')),
        ],
      ),
    );
  }

  Widget _buildExpandableCard(String title, String alternativeValue1,
      [String? value2]) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF00ffbc),
        ),
        dividerColor: Colors.transparent,
      ),
      child: Card(
        color: Color(0xFF2d3e50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(color: Color(0xFF00ffbc), fontFamily: 'Quicksand'),
          ),
          iconColor: Color(0xFF00ffbc),
          collapsedIconColor: Color(0xFF00ffbc),
          backgroundColor: Color(0xFF2d3e50),
          collapsedBackgroundColor: Color(0xFF2d3e50),
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          expandedAlignment: Alignment.centerLeft,
          children: [
            Container(
              color: Color(0xFF2d3e50),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' $alternativeValue1',
                    style: TextStyle(
                        color: Color(0xFF00ffbc),
                        fontFamily: 'Quicksand',
                        fontSize: 15),
                  ),
                  if (value2 != null)
                    Text(
                      ' $value2',
                      style: TextStyle(
                          color: Color(0xFF00ffbc),
                          fontFamily: 'Quicksand',
                          fontSize: 15),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
