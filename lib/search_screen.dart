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

  @override
  void initState() {
    searchApiCall();
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    newList = listResponse!
                        .where((element) => element
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount:
                    newList == null ? listResponse!.length : newList!.length,
                itemBuilder: ((context, index) {
                  return newList == null
                      ? HomeContainer(
                          day: listResponse![index]['date_time'],
                          description: listResponse![index]['description'],
                          organiserName: listResponse![index]['organiser_name'],
                          date: listResponse![index]['date_time'],
                          title: listResponse![index]['title'],
                          imageLink: listResponse![index]['banner_image'],
                          address: listResponse![index]['venue_name'],
                        )
                      : Expanded(
                          child: HomeContainer(
                            day: newList![index]['date_time'],
                            description: newList![index]['description'],
                            organiserName: newList![index]['organiser_name'],
                            date: newList![index]['date_time'],
                            title: newList![index]['title'],
                            imageLink: newList![index]['banner_image'],
                            address: newList![index]['venue_name'],
                          ),
                        );
                })),
          )
        ],
      ),
    );
  }
}
