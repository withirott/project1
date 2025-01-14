import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: Add(),
    debugShowCheckedModeBanner: false,
  ));
}

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Add> {
  File? _selectedImage; // ตัวแปรเก็บรูปภาพที่ผู้ใช้เลือก
  int _selectedIndex = 0; // เก็บสถานะไอคอนที่เลือกใน BottomNavigationBar

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // อัปเดตสถานะไอคอนที่เลือก
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // สีพื้นหลัง
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "LOGO",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "โพสต์ใหม่",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // เพิ่ม action ได้
            },
            icon: Icon(Icons.settings, color: Colors.transparent),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // ฟังก์ชันเมื่อกดปุ่ม "X"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("X"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // ฟังก์ชันเมื่อกดปุ่ม "ถัดไป"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("ถัดไป"),
                ),
              ],
            ),
            SizedBox(height: 20),

            // กรอบใส่รูปภาพสัตว์พร้อมไอคอนมุมขวาล่าง
            GestureDetector(
              onTap: _pickImage, // เปิดตัวเลือกเลือกรูปภาพเมื่อกด
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      image: _selectedImage != null
                          ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? Center(
                      child: Text(
                        "ใส่รูปภาพสัตว์",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                        : null,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.black54,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // กรอบที่ 1
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildTextField('ชื่อสัตว์'),
                  SizedBox(height: 10),
                  _buildTextField('อายุ'),
                  SizedBox(height: 10),
                  _buildTextField('เพศ'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // กรอบที่ 2
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildMultilineTextField('ลักษณะเด่น สีขน หรืออุปนิสัย'),
            ),
            SizedBox(height: 20),
            // กรอบที่ 3
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildMultilineTextField('รายละเอียดเพิ่มเติมเกี่ยวกับสัตว์'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[100],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.search, 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.add, 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 3),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: _selectedIndex == index ? Colors.white : Colors.transparent,
      child: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.black,
      ),
    );
  }
}
Widget _buildMultilineTextField(String hint) {
  return TextField(
    maxLines: null, // ไม่จำกัดจำนวนบรรทัด
    keyboardType: TextInputType.multiline, // รองรับข้อความหลายบรรทัด
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );
}