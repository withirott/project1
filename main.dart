import 'package:flutter/material.dart';
import 'search.dart'; // หน้า Search
import 'main1.dart';   // หน้า Logo
import 'home1.dart';    // หน้า Add
import 'profile.dart'; // หน้า Profile
import 'package:projectss/logo.dart';
void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      fontFamily: 'Circular',
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // หน้าหลัก (Home)
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return Logo(); // หน้าแรกคือหน้า Logo
                  },
                );
              },
            ),
            // ส่วน Bottom Navigation Bar ที่มีไอคอน
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.blue[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ปุ่ม Home
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Main1()), // ไปที่หน้า Logo
                        );
                      },
                    ),
                    // ปุ่ม Search
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()), // ไปที่หน้า Search
                        );
                      },
                    ),
                    // ปุ่ม Add
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Add()), // ไปที่หน้า Add
                        );
                      },
                    ),
                    // ปุ่ม Profile
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()), // ไปที่หน้า Profile
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
