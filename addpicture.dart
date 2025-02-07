import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart';
import 'apppage.dart';
import 'homefirst.dart';
import 'profile.dart';
import 'applylogin.dart';
import 'profile2.dart';

void main() {
  runApp(MaterialApp(
    home: Addpicture(),
    debugShowCheckedModeBanner: false,
  ));
}

class Addpicture extends StatefulWidget {
  const Addpicture({super.key});

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Addpicture> {
  File? _selectedImage; // ตัวแปรเก็บรูปภาพที่ผู้ใช้เลือก
  int _selectedIndex = 0; // เก็บสถานะไอคอนที่เลือกใน BottomNavigationBar

  // ตัวแปรเก็บข้อมูลสัตว์
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _traitsController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5000/api/upload'),
    );

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = json.decode(await response.stream.bytesToString());
      print("✅ อัปโหลดสำเร็จ: ${responseData['imageUrl']}");
    } else {
      print("❌ อัปโหลดล้มเหลว");
    }
  }

  Future<void> _submitData() async {
    final data = {
      'name': _nameController.text,
      'gender': _genderController.text,
      'age': _ageController.text,
      'traits': _traitsController.text,
      'details': _detailsController.text,
      'image': _selectedImage != null ? _selectedImage!.path : '',  // ส่งข้อมูลรูปภาพ (ถ้ามี)
    };

    try {
      // เริ่มต้นการอัปโหลดรูปภาพ
      if (_selectedImage != null) {
        await uploadImage(_selectedImage!);
      }

      // ส่งข้อมูลไปยัง API (URL ของ API คือ 'http://localhost:5000/api/postdata')
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/postdata'),  // URL ของ API ของคุณ
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),  // แปลงข้อมูลเป็น JSON
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('บันทึกข้อมูลสำเร็จ: ${responseData['message']}');
      } else {
        print('บันทึกข้อมูลล้มเหลว');
      }
    } catch (error) {
      print('เกิดข้อผิดพลาด: $error');
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
      backgroundColor: const Color(0xFFF3D9C5), // สีพื้นหลัง
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'assets/image.png', // โลโก้ CAT DOG
              height: 75,         // กำหนดความสูงของโลโก้
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
                  child: Text("ยกเลิก"),
                ),
                const Text(
                  "โพสต์ใหม่", // ข้อความที่ต้องการแสดง
                  style: TextStyle(
                    color: Colors.black, // สีข้อความ
                    fontSize: 16,        // ขนาดฟอนต์
                    fontWeight: FontWeight.bold, // ทำให้ตัวหนา
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // เรียกใช้ฟังก์ชัน _submitData เมื่อกดปุ่มบันทึก
                    _submitData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("บันทึก"),
                )
              ],
            ),
            const SizedBox(height: 20),
            // เพิ่มปุ่มเลือกภาพ
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("เลือกภาพจากแกลเลอรี"),
            ),
            SizedBox(height: 20),
            // แสดงภาพที่เลือก
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : Text("กรุณาเลือกภาพ"),
            const SizedBox(height: 20),
            // เพิ่มฟอร์มกรอกข้อมูล
            _buildTextField(_nameController, 'ชื่อสัตว์'),
            _buildTextField(_genderController, 'เพศ'),
            _buildTextField(_ageController, 'อายุ'),
            _buildTextField(_traitsController, 'ลักษณะนิสัย'),
            _buildTextField(_detailsController, 'รายละเอียดข้อมูลเล็กน้อย'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()), // แก้ไขให้ HomePage ถูกต้อง
                );
              },
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Search()), // แก้ไขให้ Search ถูกต้อง
                );
              },
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.add, 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()), // แก้ไขให้ ProfileScreen ถูกต้อง
                );
              },
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันนี้จะใช้สำหรับสร้าง TextField พร้อมสไตล์
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
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
        color: _selectedIndex == index ? Colors.black : Colors.black,
      ),
    );
  }
}
