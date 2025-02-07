// เรียกใช้ dotenv เพื่อโหลดค่าจาก .env
require("dotenv").config();

// เรียกใช้ไลบรารีที่จำเป็น
const express = require("express");
const mysql = require("mysql2"); // ใช้ mysql2 สำหรับ MySQL หรือ MariaDB
const app = express();
const port = process.env.PORT || 5000;

// เชื่อมต่อกับฐานข้อมูล MySQL หรือ MariaDB
const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// ทดสอบการเชื่อมต่อ
connection.connect((err) => {
  if (err) {
    console.error("❌ Error connecting to database: " + err.stack);
    return;
  }
  console.log("✅ Connected to database");
});

// สร้าง API Endpoint สำหรับดึงข้อมูลสัตว์จากฐานข้อมูล
app.get("/api/pets", (req, res) => {
  connection.query("SELECT * FROM pets", (err, results) => {
    if (err) {
      console.error("❌ Error fetching data:", err);
      return res.status(500).send("Error fetching data");
    }
    res.json(results); // ส่งข้อมูลสัตว์กลับไปยัง client
  });
});

// API สำหรับเพิ่มข้อมูลสัตว์ใหม่
app.post("/api/pets", express.json(), (req, res) => {
  const { name, gender, age, traits, details, imageUrl } = req.body;
  const query = `INSERT INTO pets (name, gender, age, traits, details, imageUrl) VALUES (?, ?, ?, ?, ?, ?)`;
  
  connection.query(query, [name, gender, age, traits, details, imageUrl], (err, results) => {
    if (err) {
      console.error("❌ Error inserting data:", err);
      return res.status(500).send("Error inserting data");
    }
    res.status(201).send("Data inserted successfully");
  });
});

// เริ่มเซิร์ฟเวอร์
app.listen(port, () => {
  console.log(`🚀 Server running at http://localhost:${port}`);
});
