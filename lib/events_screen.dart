import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EventsScreen extends StatelessWidget {
  String eventimageLink;
  String eventtitle;
  String eventorganiserName;
  String eventdate;
  String eventday;
  String eventaddress;
  String eventdescription;
  EventsScreen(
      {super.key,
      required this.eventaddress,
      required this.eventdate,
      required this.eventday,
      required this.eventdescription,
      required this.eventimageLink,
      required this.eventorganiserName,
      required this.eventtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(eventimageLink),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text(
                eventtitle,
                style: GoogleFonts.inter(
                    fontSize: 35, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.abc_sharp,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventorganiserName,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'organiser',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_view_day_rounded,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventdate,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        eventday,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventaddress,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '36 GUild street LOndon UK',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'About the Event',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(eventdescription),
            ]),
          ),
          GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text('Book Now'), Icon(Icons.arrow_right_sharp)],
                  ),
                  height: 57,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ))
        ],
      ),
    );
  }
}
