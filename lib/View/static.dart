import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StaticChart extends StatefulWidget {
  const StaticChart({super.key});

  @override
  State<StaticChart> createState() => _StaticChartState();
}

class _StaticChartState extends State<StaticChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("DAY",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
             CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 12.0,
              animation: true,
              percent: 0.7,
              center: Text(
                "70.0%",
                style:
                     TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              progressColor: Colors.blue,
            ),
            SizedBox(height: 30),
            Text("WEEK",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
            LineChartSample2(),
            SizedBox(height: 20),
            Text("MONTH",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
            BarChartSample2(),  
          ],
        ),
      ),
    );
  }
}


class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
           mainData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('Mon', style: style);
        break;
      case 4:
        text = const Text('Tue', style: style);
        break;
      case 6:
        text = const Text('Wed', style: style);
        break;
      case 8:
        text = const Text('Thr', style: style);
        break;
      case 10:
        text = const Text('Fir', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '50';
        break;
      case 2:
        text = '100';
        break;
      case 3:
        text = '150';
        break;
      case 4:
        text = '200';
        break;
      case 5:
        text = '250';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      borderData: FlBorderData(
        border: Border(
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 0),
          ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),

      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(2, 1.6),
            FlSpot(4, 4),
            FlSpot(6, 3.8),
            FlSpot(8, 1),
            FlSpot(9, 3),
            FlSpot(10, 3),
          ],
          isCurved: false,
          color: Color.fromARGB(255, 63, 206, 117),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(2, 1),
            FlSpot(4, 3),
            FlSpot(6, 3),
            FlSpot(8, 4.3),
            FlSpot(9, 2),
            FlSpot(10, 4),
          ],
          isCurved: false,
          color: Colors.blue,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }
}





class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 13;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 25, 32);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 38, 30);
    final barGroup5 = makeGroupData(4, 37, 26);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[          
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 50,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  
                  borderData: FlBorderData(
                      border: Border(
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 0),
                        ),
                    ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.transparent,
                        strokeWidth: 1,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 0) {
      text = '50';
    } else if (value == 10) {
      text = '100';
    } else if (value == 20) {
      text = '150';
    } else if (value == 30) {
      text = '200';
    } else if (value == 40) {
      text = '250';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jun', 'Feb', 'Mar', 'Apr', 'May'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 0,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.blue,
          width: width,
          borderRadius: BorderRadius.circular(0)
        ),
        BarChartRodData(
          toY: y2,
          color: Color.fromARGB(255, 63, 206, 117),
          width: width,
          borderRadius: BorderRadius.circular(0)
        ),
      ],
    );
  }

}