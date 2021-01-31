import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  static final routeName = '/stats_screen';

  DatabaseHelper helper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.show_chart_outlined,
              color: Colors.green,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Statistics',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: helper.getStatisics(),
        builder: (constext, map) {
          if (map.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatsWidget(
                    color: Colors.purpleAccent,
                    title: 'Total Cards Appeared',
                    stat: map.data['total_appeared'],
                  ),
                  StatsWidget(
                    color: Colors.blue,
                    title: 'Unique Cards',
                    stat: map.data['unique_cards'],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: StatsWidget(
                          color: Colors.green,
                          title: 'Known',
                          stat: map.data['known'],
                        ),
                      ),
                      Expanded(
                        child: StatsWidget(
                          color: Colors.red,
                          title: 'Unknown',
                          stat: map.data['unknown'],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: RichText(
                        text: TextSpan(
                            text: 'You know ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            children: [
                          TextSpan(
                              text: map.data['known'] != 0
                                  ? '${map.data['known'] / map.data['unique_cards'] * 100}%'
                                  : '0%',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: ' of total viewed Cards',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))
                        ])),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}

class StatsWidget extends StatelessWidget {
  final String title;
  final int stat;
  final Color color;

  const StatsWidget({Key key, this.title, this.stat, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: Colors.grey[300]),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(color: color),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$stat',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ))),
        ],
      ),
    );
  }
}
