import 'package:flutter/material.dart';
import 'package:projectss/notification.dart';
void main() {
  runApp(const Search());
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"title": "หมา", "description": "หมวดหมู่: หมา"},
    {"title": "แมว", "description": "หมวดหมู่: แมว"},
    {"title": "กระต่าย", "description": "หมวดหมู่: กระต่าย"},
    {"title": "นก", "description": "หมวดหมู่: นก"},
    {"title": "ปลา", "description": "หมวดหมู่: ปลา"},
    {"title": "สัตว์เล็ก", "description": "หมวดหมู่: สัตว์เล็ก"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              color: const Color.fromARGB(255, 1, 65, 138),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [IconButton(
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
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'ค้นหา',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Grid Section
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 156, 206, 229),
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: List.generate(categories.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to CategoryPage with category details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              title: categories[index]["title"]!,
                              description: categories[index]["description"]!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            categories[index]["title"]!,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              color: Colors.green[100],
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String title;
  final String description;

  const CategoryPage({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
              child: Text('ย้อนกลับ'),
            ),
          ],
        ),
      ),
    );
  }
}
