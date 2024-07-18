import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
                'VISUALIZATION',
                style: TextStyle(color: Color(0xFF00FFbc), fontSize: 18),
              ),
              const SizedBox(height: 16),
              _buildVisualizationCard(),
              const SizedBox(height: 16),
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
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name: $sampleName',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1a282f)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Season: $season',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1a282f)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Timing: $timing',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1a282f)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a282f),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'IMAGE\nHERE',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFffffff)),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 14),
            ),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: percentage / 100),
              duration: const Duration(seconds: 2),
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
                style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 14),
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
        final cardHeight = cardWidth * 1.2; // Increase height by 20%
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

  Widget _buildDoughnutChartCard(String title, String subtitle, double percentage, double width, double height, {Duration animationDuration = const Duration(milliseconds: 1500)}) {
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
                      animationDuration: animationDuration = const Duration(milliseconds: 2000),
                    ),
                    Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Color(0xFF00FFbc), fontSize: 12),
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