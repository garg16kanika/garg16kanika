import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String? stringResponse;
Map? mapResponse;
Map? dataResponse;
List? listResponse;
List? newList;

List<String> eventNameList = <String>[];
List<String> tempList = <String>[];
bool isLoading = false;

class _SearchScreenState extends State<SearchScreen> {
  Future searchApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event"));
    if (response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['content']['data'];

        print(mapResponse!['content']['data']);
      });
    }
  }

  _filterEventName(String text) {
    if (text.isEmpty) {
      setState(() {
        eventNameList = tempList;
      });
    } else {
      final List<String> filteredEvents = <String>[];
      tempList.map((event) {
        if (event.contains(text.toString().toUpperCase())) {
          filteredEvents.add(event);
        }
      }).toList();
      setState(() {
        eventNameList = filteredEvents;
      });
    }
  }

  _fetchEvent() async {
    setState(() {
      isLoading = true;
    });
    tempList = <String>[];
    ;
    final response = await http.get(Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event"));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      jsonResponse['message'].forEach((event, subevent) {
        tempList.add(event.toString().toUpperCase());
      });
    } else {
      throw Exception("Failed to load Dogs Breeds.");
    }
    setState(() {
      eventNameList = tempList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    searchApiCall();
    _fetchEvent();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 18),
          //   child: TextField(
          //     onChanged: (value) {
          //       if (value.isNotEmpty) {
          //         newList = listResponse!.data
          //             .where((element) => element
          //                 .toString()
          //                 .toLowerCase()
          //                 .contains(value.toLowerCase()))
          //             .toList();
          //       }
          //     },
          //     decoration: InputDecoration(
          //       hintText: 'Search',
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Dog Breeds Here...",
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (text) {
                          _filterEventName(text);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : ListView.builder(
                                itemCount: eventNameList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(
                                    eventNameList[index],
                                  ));
                                }),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            child: ListView.builder(
                itemCount: listResponse!.length,
                itemBuilder: ((context, index) {
                  return HomeContainer(
                    day: listResponse![index]['date_time'],
                    description: listResponse![index]['description'],
                    organiserName: listResponse![index]['organiser_name'],
                    date: listResponse![index]['date_time'],
                    title: listResponse![index]['title'],
                    imageLink: listResponse![index]['banner_image'],
                    address: listResponse![index]['venue_name'],
                  );
                })),
          )
        ],
      ),
    );
  }
}
