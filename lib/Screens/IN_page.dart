import 'package:flutter/material.dart';
import 'package:inventori/Screens/pilihproductIN_page.dart';

class INPage extends StatefulWidget {
  @override
  _INPageState createState() => _INPageState();
}

class _INPageState extends State<INPage> {
  // Daftar produk masuk
  List<Map<String, dynamic>> products = [
    {'name': 'Kaos Kaki Jempol Lutut', 'code': 'KKJL001', 'price': 50000, 'quantity': 2, 'unit': 'Lusin'},
  ];

  // Fungsi untuk menghitung total harga
  num _calculateTotalPrice() {
    num total = 0;
    for (var product in products) {
      total += product['price'] * product['quantity']; // Mengalikan harga dan kuantitas
    }
    return total;
  }

  // Fungsi untuk menambah produk baru dari PilihProductINPage
  Future<void> _addProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PilihProductINPage()), // Navigasi ke halaman pilih produk
    );

    if (result != null) {
      print("Produk yang ditambahkan: $result");
      setState(() {
        // Langsung tambahkan produk baru ke daftar tanpa pengecekan
        products.add(result);
      });
    } else {
      print("Tidak ada produk yang ditambahkan.");
    }
  }

  // Fungsi untuk menghapus produk
  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index); // Menghapus produk dari daftar
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Produk berhasil dihapus'),
    ));
  }

  // Fungsi untuk menampilkan opsi hapus produk
  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black87,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Product', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context); // Tutup modal
                  _deleteProduct(index); // Hapus produk
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IN Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Add Product Button
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity, // Agar tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: _addProduct, // Panggil fungsi untuk menambahkan produk baru
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  child: Text('Add Product', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              // Judul atau informasi singkat
              Text(
                'List Produk Masuk',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // ListView untuk daftar produk
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductItem(
                    product['name'],
                    product['code'],
                    product['price'],
                    product['quantity'],
                    product['unit'],
                    index, // Tambahkan index untuk hapus dan update
                  );
                },
              ),
              SizedBox(height: 20),
              // Total harga
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'TOTAL',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    Text(
                      'Rp ${_calculateTotalPrice()},00', // Menampilkan total harga yang dihitung
                      style: TextStyle(fontSize: 35.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  // Fungsi untuk membangun tampilan setiap item produk
  Widget _buildProductItem(String name, String code, int price, int quantity, String unit, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Kolom kiri dan kanan
        children: [
          // Kolom di kiri (nama produk, kode, dan harga)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: 25)),
              Text('Code: $code', style: TextStyle(color: Colors.grey)),
              Text('Rp $price,00', style: TextStyle(color: Colors.green)),
            ],
          ),
          // Kolom di kanan (jumlah dan satuan)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$quantity', style: TextStyle(color: Colors.green, fontSize: 16)),
              Text(unit, style: TextStyle(color: Colors.grey, fontSize: 14)),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  _showOptions(context, index); // Tampilkan opsi hapus produk
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
