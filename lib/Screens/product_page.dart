import 'package:flutter/material.dart';
import 'addproduct_page.dart';
import 'history_page.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi ke halaman AddProductPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              );// Aksi untuk menambahkan produk baru
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Membungkus konten dengan scroll view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul atau informasi singkat
              Text(
                'Daftar Produk',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              // Expanded ListView untuk daftar produk
              ListView(
                shrinkWrap: true, // Agar tidak menyebabkan overflow
                physics:
                    NeverScrollableScrollPhysics(), // Menghindari scroll ganda
                children: [
                  _buildProductItem('Kaos Kaki Jempol Lutut', 'KKJL001',
                      'Rp 50.000,00', 52, 'Lusin'),
                  _buildProductItem(
                      'Sarung tangan putih', 'STP001', 'Rp 48.000,00', 23, 'Lusin'),
                  // Tambahkan item lain sesuai kebutuhan
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  // Fungsi untuk membangun tampilan setiap item produk
  Widget _buildProductItem(String name, String code, String price, int quantity, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Kolom kiri dan kanan
        children: [
          // Kolom di kiri (nama produk, kode, dan harga)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                code,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                price,
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),

          // Kolom di kanan (jumlah dan satuan)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$quantity',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              Text(
                unit,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // Aksi untuk melihat detail atau mengedit produk
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
