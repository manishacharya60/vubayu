import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'results2.dart';
// ignore: unused_import
import 'dart:io';

class ResultsPage extends StatelessWidget {
  final String sampleName;
  final String season;
  final String timing;
  final String color;
  final double carbonSequestrationPotential;
  final String texture;
  final double waterRetentionCapacity;
  final String structure;
  final String moisture;
  final String organics;
  final String roots;
  final double aggregateStabilityValue;
  final double soilRelatedRespirationRate;
  final double contentsPerSquarePixels;
  final double totalCarbonInputOnSoil;
  // New properties
  final String porosity;
  final double gasExchangeCapacity;
  final String rocksPresence;
  final double weatheringRate;
  final String imagePath;

  const ResultsPage({
     super.key,
    required this.sampleName,
    required this.season,
    required this.timing,
    required this.color,
    required this.carbonSequestrationPotential,
    required this.texture,
    required this.waterRetentionCapacity,
    required this.structure,
    required this.moisture,
    required this.organics,
    required this.roots,
    required this.aggregateStabilityValue,
    required this.soilRelatedRespirationRate,
    required this.contentsPerSquarePixels,
    required this.totalCarbonInputOnSoil,
    // New required properties
    required this.porosity,
    required this.gasExchangeCapacity,
    required this.rocksPresence,
    required this.weatheringRate,
    required this.imagePath,
  });
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a282f),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00ffbc)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 28, top: 4.0),
            child: Text(
              'vubayu results',
              style: TextStyle(color: Color(0xFF00FFbc), fontSize: 20),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF1a282f),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'VISUALISATION',
                style: TextStyle(color: Color(0xFF00FFbc), fontSize: 18),
              ),
              const SizedBox(height: 12),
              _buildVisualizationCard(),
              const SizedBox(height: 12),
               const Text(
                'Click on the cards for details:',
                style: TextStyle(color: Color(0xFF00FFbc), fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Color',
                color,
                'Carbon Sequestration Potential',
                carbonSequestrationPotential,
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                'Texture',
                texture,
                'Water Retention (Hold) Capacity',
                waterRetentionCapacity,
              ),
              const SizedBox(height: 16),
              _buildDoughnutChartCards(),
              const SizedBox(height: 16),
              // New cards
              _buildInfoCard(
                'Porosity',
                porosity,
                'Gas Exchange Capacity',
                gasExchangeCapacity,
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                'Rocks Presence',
                rocksPresence,
                'Weathering Rate',
                weatheringRate,
              ),
               const SizedBox(height: 16),
              _buildAdditionalFeaturesButton(context),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildVisualizationCard() {
  return Card(
    color: const Color(0xFF00FFbc),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Name: $sampleName',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1a282f)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Season: $season',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1a282f)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Timing: $timing',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1a282f)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF1a282f),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildInfoCard(String label, String value, String subtitle, double percentage) {
    return Card(
      color: const Color(0xFF2C3E50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color(0xFF00FFbc),
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color(0xFF00FFbc),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 15),
            ),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: percentage / 100),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, _) => CustomPaint(
                painter: RoundedLinearProgressPainter(
                  backgroundColor: const Color(0xFF00805e),
                  valueColor: const Color(0xFF00FFbc),
                  value: value,
                ),
                child: const SizedBox(
                  height: 4,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${percentage.toStringAsFixed(0)}%',
                style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoughnutChartCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 16) / 2;
        final cardHeight = cardWidth * 1.2;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildDoughnutChartCard('Structure: $structure', 'Aggregate\nStability Value', aggregateStabilityValue, cardWidth, cardHeight),
            _buildDoughnutChartCard('Moisture: $moisture', 'Soil Related\nRespiration Rate', soilRelatedRespirationRate, cardWidth, cardHeight),
            _buildDoughnutChartCard('Organics: $organics', 'Contents Per\nSquare Pixels', contentsPerSquarePixels, cardWidth, cardHeight),
            _buildDoughnutChartCard('Roots: $roots', 'Total Carbon\nInput on Soil', totalCarbonInputOnSoil, cardWidth, cardHeight),
          ],
        );
      },
    );
  }

  // ignore: unused_element
  Widget _buildDoughnutChartCard(String title, String subtitle, double percentage, double width, double height, {Duration animationDuration = const Duration(milliseconds: 1000)}) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: const Color(0xFF2C3E50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: width * 0.6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      dataMap: {
                        "Value": percentage,
                        "Remaining": 100 - percentage,
                      },
                      chartType: ChartType.ring,
                      colorList: const [Color(0xFF00FFbc), Color(0xFF00805e)],
                      chartRadius: width * 0.4,
                      ringStrokeWidth: 10,
                      legendOptions: const LegendOptions(showLegends: false),
                      chartValuesOptions: const ChartValuesOptions(showChartValues: false),
                      animationDuration: const Duration(milliseconds: 2000),
                    ),
                    Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedLinearProgressPainter extends CustomPainter {
  final Color backgroundColor;
  final Color valueColor;
  final double value;

  RoundedLinearProgressPainter({
    required this.backgroundColor,
    required this.valueColor,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(5),
    );

    canvas.drawRRect(rect, paint);

    paint.color = valueColor;

    final valueRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width * value, size.height),
      const Radius.circular(5),
    );

    canvas.drawRRect(valueRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  
}

Widget _buildAdditionalFeaturesButton(BuildContext context) {
  return Center(
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
      child: ElevatedButton(
        onPressed: () {
          // Navigate to Results2Page with the required values
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Results2Page(
                seedsCashCropsValue1: 'Cotton',
                seedsCashCropsValue2: 'Soybeans',
                endangeredSpeciesValue1: 'Bengal Tiger',
                endangeredSpeciesValue2: 'Indian Elephant',
                farmingToolsValue1: 'Organic Fertilizers',
                farmingToolsValue2: 'Drip Irrigation',
                alternativeValue1: 'Urea & Nitrogen',
                alternativeValue2: 'Pottery Making',
                bestCaptureValue1: 'High',
                bestCaptureValue2: 'No Impact',
                cultivationSystemValue1: 'Yes',
                cultivationSystemValue2: 'Light Houses',
                naturalDisasterValue1: 'Earthquake',
                naturalDisasterValue2: 'Drought',
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00ffbc),
          foregroundColor: const Color(0xFF1a282f),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        child: const Text(
          'Additional Environmental Features',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}