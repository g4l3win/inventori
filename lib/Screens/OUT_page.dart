import 'package:flutter/material.dart';
import 'package:inventori/Screens/pilihproductOUT_page.dart';

class OUTPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OUT Product'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Navigasi ke halaman INPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OUTPage()),
              ); // Aksi untuk menambahkan produk baru
            },
          )
        ],
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        // Add Product Button

        child: SingleChildScrollView(
          // Membungkus konten dengan scroll view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity, // Agar tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PilihProductOUTPage()),
                    ); //AKSI MILIH PRODUK UNTUK DITAMBAHIN
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors
                      .purple, // Warna latar belakang tombol// Warna tombol ungu
                  ),
                  child: Text(
                    'Add Product', style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 20),
              // Judul atau informasi singkat
              Text(
                'List Produk Keluar',
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
                      'Rp 50.000,00', 1, 'Lusin'),
                  _buildProductItem(
                      'Sarung tangan putih', 'STP001', 'Rp 48.000,00', 1,
                      'Lusin'),
                  // Tambahkan item lain sesuai kebutuhan
                ],
              ),
          SizedBox(height: 20),
          // Total harga
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TOTAL KELUAR',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                Text(
                  'Rp 98.000,00',
                  style: TextStyle(fontSize: 35.0, color: Colors.white),
                ),
              ],
            ),

          )],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
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

