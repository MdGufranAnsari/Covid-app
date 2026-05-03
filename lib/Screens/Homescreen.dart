
import 'dart:convert';

import 'package:covid_data/Screens/Countries_list.dart';
import 'package:covid_data/Screens/Model.dart';
import 'package:covid_data/Screens/Url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String baseUrl;

  final colorList = <Color>[
    const Color(0xfffd79a8),
    const Color(0xff4caf50),
    const Color(0xff0984e3),
    const Color(0xfffdcb6e),
    const Color(0xff6c5ce7),
    const Color(0xffe17055),


  ];

  @override
  void initState() {

    super.initState();
    // Set the country name, API key, and API URL
  }

  Future<WorldStat> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.WorldUrl),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Check if the response is a list
        if (responseData is List) {
          // Handle list response (assuming the first item is the desired object)
          return WorldStat.fromJson(responseData.first);
        } else if (responseData is Map<String, dynamic>) {
          // Handle map response
          return WorldStat.fromJson(responseData);
        } else {
          throw Exception('Received unexpected response format');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text('Covid-Info')),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, AsyncSnapshot<WorldStat> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue, // Customize the color
                      size: 50.0, // Customize the size
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 8),
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Deaths': double.parse(snapshot.data!.deaths.toString()),
                            'Recovered':
                            double.parse(snapshot.data!.recovered.toString()),
                            'Cases': double.parse(snapshot.data!.cases.toString()),
                          },
                          animationDuration: Duration(milliseconds: 700),
                          chartLegendSpacing: 32,
                          chartRadius: w*.45,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 28,
                          // centerText: "HYBRID",
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                        SizedBox(
                          height: h * .06,
                        ),

                        Card(
                          child: Column(
                            children:[ ReusbaleRow(
                                title: 'Active Cases', value: snapshot.data!.active.toString()),

                          ReusbaleRow(
                              title: 'Recovered Per One Million',
                              value: snapshot.data!.recoveredPerOneMillion.toString()),
                          ReusbaleRow(
                              title: 'Deaths Per One Million',
                              value: snapshot.data!.deathsPerOneMillion.toString()),
                          ReusbaleRow(
                              title: 'Today Recovered',
                              value: snapshot.data!.todayRecovered.toString()),
                          ReusbaleRow(
                              title: 'Today Cases',
                              value: snapshot.data!.todayCases.toString()),
                          Padding(padding: EdgeInsets.all(12),
                            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Today Deaths',
                            style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blue
                            ),), Text(snapshot.data!.todayDeaths.toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600, color: Colors.green
                                ))
                            ],
                            ),
                          )
                                           ] ),
                        ),

                        SizedBox(
                          height: h * .06,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CountriesPage(), // Replace SecondScreen() with your destination screen
                              ),
                            );
                          },
                          child:Padding(padding: EdgeInsets.only(bottom: h*.03),
                            child: Container(
                              height: h * .06,
                              width: w * 0.88,
                              decoration: BoxDecoration(
                                color: Colors.green,

                                borderRadius: BorderRadius.circular(
                                    15.0), // Adjust the radius as needed
                              ),
                              child:
                                 Center(
                                  child: Text(
                                    'Track Countries',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ),
                          ),

                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ReusbaleRow extends StatelessWidget {
   final title, value;
  ReusbaleRow({Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.blue ,fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.green,fontWeight: FontWeight.w700, fontSize: 16),
            ),

          ],
        ),
        Divider(
          // thickness: 1,
        ),
      ]),
    );
  }
}
