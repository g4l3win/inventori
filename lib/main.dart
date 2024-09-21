import 'package:flutter/material.dart';
import 'Screens/login_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Inventory Management', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.purple, // Tema warna utama
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(), // Halaman pertama yang ditampilkan
    );
  }
}

