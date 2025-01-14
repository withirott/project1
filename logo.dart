import 'package:flutter/material.dart';
import 'package:projectss/notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Logo(),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              color: Colors.lightBlue,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.black),
                        onPressed: () {
                          // เมื่อคลิกที่ไอคอนจะนำทางไปที่ NotificationScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Icon_notification()),
                          );
                        },
                      ),
                      Text(
                        'LOGO',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 24.0), // Placeholder for alignment
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person, size: 30),
                          ),
                          SizedBox(height: 8.0),
                          Text('โปรไฟล์'),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'ชื่อสัตว์',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Image Section with Swipe Feature (PageView)
            Expanded(
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.all(16.0),
                child: PageView(
                  children: [
                    // Add multiple images to be swiped
                    Image.asset('assets/image/cat.png', fit: BoxFit.cover),
                    Image.asset('assets/image/dog.png', fit: BoxFit.cover),
                    Image.asset('assets/image/horse.png', fit: BoxFit.cover),
                    // You can add as many images as you want
                  ],
                ),
              ),
            ),

            // Message Section
            Container(
              color: Colors.lightBlue,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'ข้อความ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
