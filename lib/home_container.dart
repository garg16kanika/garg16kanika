import 'package:events_task/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeContainer extends StatelessWidget {
  String imageLink;
  String title;
  String organiserName;
  String date;
  String day;
  String address;
  String description;
  HomeContainer(
      {super.key,
      required this.address,
      required this.date,
      required this.day,
      required this.description,
      required this.imageLink,
      required this.organiserName,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventsScreen(
                      eventday: day,
                      eventdescription: description,
                      eventorganiserName: organiserName,
                      eventdate: date,
                      eventtitle: title,
                      eventimageLink: imageLink,
                      eventaddress: address,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        margin: EdgeInsets.all(14),
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                imageLink,
                fit: BoxFit.cover,
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFF120D26),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      address,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
