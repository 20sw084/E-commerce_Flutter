import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/constants.dart';

class SalesData {
  final String year;
  final double sales;
  SalesData(this.year, this.sales);
}

class AnalyticsChart extends StatefulWidget {
  const AnalyticsChart({Key? key}) : super(key: key);

  @override
  State<AnalyticsChart> createState() => _AnalyticsChartState();
}

class _AnalyticsChartState extends State<AnalyticsChart> {
  //
  //

  String selectedTimeRange = 'Today';
  int selectedSalesDataIndex = 0;
  List<String> timeRange = ['Today', 'Yesterday', 'Last Week', 'Last Month', 'Last Year'];
  List<List<SalesData>> salesDataList = [
    [
      SalesData('12 am', 25),
      SalesData('01 am', 19),
      SalesData('02 am', 35),
      SalesData('03 am', 12),
      SalesData('04 am', 15),
      SalesData('05 am', 05),
      SalesData('06 am', 40),
      SalesData('07 am', 55),
      SalesData('08 am', 25),
      SalesData('09 am', 15),
      SalesData('10 am', 25),
      SalesData('11 am', 35),
      SalesData('12 pm', 05),
      SalesData('01 pm', 19),
      SalesData('02 pm', 35),
      SalesData('03 pm', 25),
      SalesData('04 pm', 75),
      SalesData('05 pm', 65),
      SalesData('06 pm', 55),
      SalesData('07 pm', 25),
      SalesData('08 pm', 35),
      SalesData('09 pm', 02),
      SalesData('10 pm', 15),
      SalesData('11 pm', 25),
    ],
    [
      SalesData('12 am', 25),
      SalesData('01 am', 19),
      SalesData('02 am', 35),
      SalesData('03 am', 12),
      SalesData('04 am', 15),
      SalesData('05 am', 05),
      SalesData('06 am', 10),
      SalesData('07 am', 45),
      SalesData('08 am', 25),
      SalesData('09 am', 15),
      SalesData('10 am', 25),
      SalesData('11 am', 35),
      SalesData('12 pm', 05),
      SalesData('01 pm', 19),
      SalesData('02 pm', 35),
      SalesData('03 pm', 25),
      SalesData('04 pm', 45),
      SalesData('05 pm', 25),
      SalesData('06 pm', 15),
      SalesData('07 pm', 25),
      SalesData('08 pm', 35),
      SalesData('09 pm', 02),
      SalesData('10 pm', 15),
      SalesData('11 pm', 25),
    ],
    [
      SalesData('1 Jul', 19),
      SalesData('2 Jul', 35),
      SalesData('3 Jul', 25),
      SalesData('4 Jul', 28),
      SalesData('5 Jul', 34),
      SalesData('6 Jul', 32),
      SalesData('7 Jul', 40),
    ],
    [
      SalesData('1 Jul', 19),
      SalesData('2 Jul', 35),
      SalesData('3 Jul', 25),
      SalesData('4 Jul', 28),
      SalesData('5 Jul', 34),
      SalesData('6 Jul', 32),
      SalesData('7 Jul', 40),
      SalesData('8 Jul', 19),
      SalesData('9 Jul', 35),
      SalesData('10 Jul', 25),
      SalesData('11 Jul', 28),
      SalesData('12 Jul', 34),
      SalesData('13 Jul', 32),
      SalesData('14 Jul', 40),
      SalesData('15 Jul', 19),
      SalesData('16 Jul', 35),
      SalesData('17 Jul', 25),
      SalesData('18 Jul', 28),
      SalesData('19 Jul', 34),
      SalesData('20 Jul', 32),
      SalesData('21 Jul', 40),
      SalesData('22 Jul', 35),
      SalesData('23 Jul', 25),
      SalesData('24 Jul', 28),
      SalesData('25 Jul', 34),
      SalesData('26 Jul', 32),
      SalesData('27 Jul', 40),
      SalesData('28 Jul', 19),
      SalesData('29 Jul', 35),
      SalesData('30 Jul', 25),
      SalesData('31 Jul', 28),
    ],
    [
      SalesData('Jan', 191919),
      SalesData('Feb', 353535),
      SalesData('Mar', 252525),
      SalesData('Apr', 282828),
      SalesData('May', 343434),
      SalesData('Jun', 323232),
      SalesData('Jul', 402324),
      SalesData('Aug', 191231),
      SalesData('Sep', 352345),
      SalesData('Oct', 254567),
      SalesData('Nov', 184564),
      SalesData('Dec', 374234),
    ]
  ];

  //
  //

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Analytics Overview', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
        Container(
            padding: const EdgeInsets.only(right: 12, left: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.purple.shade100.withOpacity(0.5))),
            width: 180,
            child: DropdownButton<String>(
                value: selectedTimeRange,
                onChanged: (value) => setState(() {
                      selectedTimeRange = value.toString();
                      for (var i = 0; i < timeRange.length; i++) {
                        if (value == timeRange[i]) selectedSalesDataIndex = i;
                      }
                    }),
                iconEnabledColor: red,
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                style: TextStyle(color: Colors.grey.shade700),
                items: timeRange.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList()))
      ]),
      const SizedBox(height: 16),
      SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: [
          SplineAreaSeries(
              borderWidth: 3,
              // borderColor: red,
              borderGradient: LinearGradient(
                  stops: const [0, 0.25, 0.8, 1], colors: [red.withOpacity(0), red.withOpacity(0.25), red.withOpacity(0.5), red.withOpacity(0)]),
              dataSource: salesDataList[selectedSalesDataIndex],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.3, 1],
                colors: [red.withOpacity(0.3), red.withOpacity(0.1), black.withOpacity(0)],
              )),
        ],
      ),
    ]);
  }
}
