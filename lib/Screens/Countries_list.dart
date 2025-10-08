import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_data/Screens/Country_detail.dart';
import 'package:covid_data/Screens/Url.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({Key? key}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  TextEditingController searchController = TextEditingController();

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(AppUrl.CountriesUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load flag data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // Replace the title with a back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0), // Adjust margin as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black),
            ),
            child: TextFormField(
              controller: searchController,
              onChanged: (val) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Search your country',
                border: InputBorder.none,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading spinner while waiting for data
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue, // Customize the color
                      size: 50.0, // Customize the size
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display the list of countries once data is loaded
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (searchController.text.isEmpty ||
                          name.toLowerCase().contains(
                              searchController.text.toLowerCase())) {
                        return GestureDetector(

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetails(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']
                                  ['flag'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalRecovered:
                                  snapshot.data![index]['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered:
                                  snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag']
                                    .toString(),
                                height: h * .08,
                                width: h * .08,
                              ),
                              title: Text(
                                snapshot.data![index]['country'].toString(),
                                style: TextStyle(color: Colors.blue,
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: TextStyle(color: Colors.green,
                                    fontSize: 15, fontWeight: FontWeight.w600,


                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
