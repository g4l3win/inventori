import 'package:flutter/material.dart';
import 'addproduct_page.dart';
import 'updateproduct_page.dart'; // Import halaman update
import 'dart:io';  // Tambahkan ini untuk menggunakan File


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // List produk yang bisa berubah
  List<Map<String, dynamic>> products = [
    {
      'gambar' : 'img/fotoa.jpg',
      'name': 'Kaos Kaki',
      'code': 'KKJL001',
      'price': 50000,
      'quantity': 52,
      'unit': 'Lusin'
    },
    {
      'gambar' : 'img/fotob.jpg',
      'name': 'Sarung tangan putih',
      'code': 'STP001',
      'price': 48000,
      'quantity': 23,
      'unit': 'Lusin'
    },
    // Tambahkan produk lainnya jika diperlukan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              // Navigasi ke halaman AddProductPage dan tunggu hasil
              final newProduct = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              );

              // Tambahkan produk baru jika tidak null
              if (newProduct != null) {
                setState(() {
                  products.add(newProduct); // Tambah produk ke list
                });
              }
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
              ListView.builder(
                shrinkWrap: true, // Agar tidak menyebabkan overflow
                physics: NeverScrollableScrollPhysics(), // Menghindari scroll ganda
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductItem(
                    product['gambar'],
                    product['name'],
                    product['code'],
                    product['price'],
                    product['quantity'],
                    product['unit'],
                    context,
                    index, // Kirimkan index untuk menghapus item
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  // Fungsi untuk membangun tampilan setiap item produk
  Widget _buildProductItem(String gambar, String name, String code, int price, int quantity, String unit, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Kolom kiri dan kanan
        children: [
          //kolom gambar
          Column(
            children: [
              gambar.isNotEmpty
                  ? (_isLocalFile(gambar)
                  ? Image.file(
                File(gambar), // Jika gambar berasal dari file lokal
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                gambar, // Jika gambar berasal dari asset lokal
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ))
                  : Container(
                width: 40,
                height: 40,
                color: Colors.grey, // Placeholder jika tidak ada gambar
              ),
            ],
          ),
          SizedBox(width: 10),
          // Kolom di kiri (nama produk, kode, dan harga)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                code,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Rp $price',  // Ubah harga ke format tanpa desimal
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          Spacer(), // Memberikan jarak otomatis antara teks dan ikon
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
                  _showOptions(context, name, index); // Menampilkan pilihan opsi
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan modal bottom sheet dengan opsi Update dan Delete
  void _showOptions(BuildContext context, String productName, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black87,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.white),
                title: Text('Update', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Tutup modal bottom sheet
                  _updateProduct(context, index); // Pindah ke halaman update
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context); // Tutup modal bottom sheet
                  _deleteProduct(context, index); // Hapus produk
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk update produk
  void _updateProduct(BuildContext context, int index) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProductPage(product: products[index]), // Pindah ke halaman update
      ),
    );

    // Jika produk terupdate, lakukan update pada state
    if (updatedProduct != null) {
      setState(() {
        products[index] = updatedProduct; // Perbarui produk di list
      });
    }
  }

  // Fungsi untuk delete produk
  void _deleteProduct(BuildContext context, int index) {
    setState(() {
      products.removeAt(index); // Menghapus produk dari list
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Produk berhasil dihapus'),
    ));
  }
}

// Fungsi untuk cek apakah gambar adalah path file lokal
bool _isLocalFile(String path) {
  return path.startsWith('/data/') || path.startsWith('/storage/'); // Sesuaikan dengan path dari cache/galeri
}
