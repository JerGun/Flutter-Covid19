import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_covid19/models/chart.dart';
import 'package:flutter_covid19/models/covid.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

import 'components/chart_info.dart';
import 'components/symptoms_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Covid> futureCovid;
  late double recovered;
  late double active;
  late double deaths;

  Future<void> getData() async {
    futureCovid = fetchData();
    setState(() {});
  }

  Future<Covid> fetchData() async {
    final response = await http.get(
        Uri.parse('https://static.easysunday.com/covid-19/getTodayCases.json'));

    return response.statusCode == 200
        ? Covid.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load data');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 500), getData);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<Covid>(
            future: futureCovid,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                                color: Colors.deepPurpleAccent,
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20, top: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'COVID 19',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Coronavirus disease (COVID 19)',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Symptoms of ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Covid19',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            height: 160,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView(
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                SymptomsItem(
                                                  icon: 'fever',
                                                  title: 'Fever',
                                                ),
                                                SymptomsItem(
                                                  icon: 'headache',
                                                  title: 'Headache',
                                                ),
                                                SymptomsItem(
                                                  icon: 'chest_pain',
                                                  title: 'Chest Pain',
                                                ),
                                                SymptomsItem(
                                                  icon: 'sore_throat',
                                                  title: 'Sore Throat',
                                                ),
                                                SymptomsItem(
                                                  icon: 'difficulty_breathing',
                                                  title:
                                                      'Difficulty \n Breathing',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.2,
                          left: MediaQuery.of(context).size.width * 0.05,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: MediaQuery.of(context).size.height *
                                      0.015,
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  child: Text(
                                    '${snapshot.data!.continent} / ${snapshot.data!.country}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Positioned(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.015,
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  child: Text(
                                    snapshot.data!.updateDate,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: SfCircularChart(
                                        series: <CircularSeries>[
                                          DoughnutSeries<Chart, String>(
                                            dataSource: [
                                              Chart(
                                                  'Recovered',
                                                  snapshot.data!.recovered
                                                      .toDouble(),
                                                  Color.fromRGBO(
                                                      80, 255, 110, 1)),
                                              Chart(
                                                  'Active',
                                                  snapshot.data!.active
                                                      .toDouble(),
                                                  Color.fromRGBO(
                                                      255, 220, 80, 1)),
                                              Chart(
                                                  'Deaths',
                                                  snapshot.data!.deaths
                                                      .toDouble(),
                                                  Color.fromRGBO(
                                                      255, 80, 80, 1)),
                                            ],
                                            pointColorMapper: (Chart data, _) =>
                                                data.color,
                                            xValueMapper: (Chart data, _) =>
                                                data.x,
                                            yValueMapper: (Chart data, _) =>
                                                data.y,
                                            innerRadius: '70%',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total: ${snapshot.data!.confirmed.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(height: 10),
                                        ChartInfo(
                                          title: 'Recovered',
                                          color:
                                              Color.fromRGBO(80, 255, 110, 1),
                                          snapshot: snapshot.data!.recovered
                                              .toString()
                                              .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                        ),
                                        SizedBox(height: 5),
                                        ChartInfo(
                                          title: 'Active',
                                          color:
                                              Color.fromRGBO(255, 220, 80, 1),
                                          snapshot: snapshot.data!.active
                                              .toString()
                                              .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                        ),
                                        SizedBox(height: 5),
                                        ChartInfo(
                                          title: 'Deaths',
                                          color: Color.fromRGBO(255, 80, 80, 1),
                                          snapshot: snapshot.data!.deaths
                                              .toString()
                                              .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : (snapshot.hasError
                      ? Text('${snapshot.error}')
                      : Center(child: CircularProgressIndicator()));
            },
          ),
        ),
      ),
    );
  }
}
