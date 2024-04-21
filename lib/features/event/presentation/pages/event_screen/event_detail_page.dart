import 'package:flutter/material.dart';
import 'package:uni_link/constant/color.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color:oPrimaryColor,
              width: double.infinity,
              ),

            SizedBox(height: 20),
            Text(
              'Event Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Event Date',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Event Description',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.people, size: 30),
                    SizedBox(height: 10),
                    Text(
                      'Attendees',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.location_on, size: 30),
                    SizedBox(height: 10),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.access_time, size: 30),
                    SizedBox(height: 10),
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('RSVP'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
