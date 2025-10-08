
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
class CountryDetails extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  CountryDetails(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.test,
      required this.totalRecovered});

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.name, style: TextStyle(
               fontWeight: FontWeight.w600, color: Colors.black
          ),),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.topCenter,
                  children: [
                    Padding(padding: EdgeInsets.only(top: h*.067),
                      child: Card(
                        // color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: h*.06,),
                            ReusbaleRow2(title: 'Tests', value: widget.test.toString()),
                            ReusbaleRow2(title: 'Total Cases', value: widget.totalCases.toString()),
                            ReusbaleRow2(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                            ReusbaleRow2(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                            ReusbaleRow2(title: 'Critical', value: widget.critical.toString()),
                            ReusbaleRow2(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                            // ReusbaleRow2(title: 'Active Cases', value: widget.active.toString()),
                            Padding(padding: EdgeInsets.all(12),
                              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Active Cases',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue
                                ),), Text(widget.active.toString(),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green
                                  ))
                              ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.image),
                    )
                  ],
                )
            ],),
          ),
        ),

    );
  }
}
class ReusbaleRow2 extends StatelessWidget {
  String title, value;

  ReusbaleRow2({Key? key, required this.title, required this.value})
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
              style: TextStyle(color: Colors.blue ,fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.green ,fontWeight: FontWeight.w600, fontSize: 16),
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

