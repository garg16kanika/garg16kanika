import 'dart:convert';

import 'package:events_task/home_container.dart';
import 'package:events_task/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Events'),
    );
  }
}

String? stringResponse;
Map? mapResponse;
Map? dataResponse;
List? listResponse;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future apiCall() async {
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
    apiCall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: listResponse == null ? 0 : listResponse!.length,
            itemBuilder: (context, index) {
              return HomeContainer(
                day: listResponse![index]['date_time'],
                description: listResponse![index]['description'],
                organiserName: listResponse![index]['organiser_name'],
                date: listResponse![index]['date_time'],
                title: listResponse![index]['title'],
                imageLink: listResponse![index]['banner_image'],
                address: listResponse![index]['venue_name'],
              );
            }));
  }
}
