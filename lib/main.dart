import 'package:flutter/material.dart';
import 'Screens/dashboard_page.dart'; // Import halaman Dashboard
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.purple, // Tema warna utama
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardPage(), // Halaman pertama yang ditampilkan
    );
  }
}

