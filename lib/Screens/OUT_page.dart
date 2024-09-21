import 'package:flutter/material.dart';

class OUTPage extends StatefulWidget {
  @override
  _OUTPageState createState() => _OUTPageState();
}

class _OUTPageState extends State<OUTPage> {
  // Daftar produk yang tersedia
  List<Map<String, dynamic>> availableProducts = [
    {'gambar' : 'img/fotoa.jpg', 'name': 'Kaos Kaki', 'code': 'KKJL001', 'price': 50000, 'unit': 'Lusin'},
    {'gambar' : 'img/fotob.jpg','name': 'Sarung Tangan Putih', 'code': 'STP001', 'price': 48000, 'unit': 'Lusin'},
  ];

  // Daftar produk KELUAR
  List<Map<String, dynamic>> products = [];

  // Variabel untuk produk yang dipilih dari dropdown
  Map<String, dynamic>? selectedProduct;

  // Controller untuk jumlah barang yang masuk
  TextEditingController quantityController = TextEditingController();

  // Fungsi untuk menghitung total Harga PRODUK KELUAR
  num _calculateTotalPrice() {
    num total = 0;
    for (var product in products) {
      total += product['price'] * product['quantity']; // Mengalikan harga dan kuantitas
    }
    return total;
  }

  // Fungsi untuk menambah produk Yang mau keluar
  Future<void> _addProduct() async {
    if (selectedProduct != null && quantityController.text.isNotEmpty) {
      int? quantity = int.tryParse(quantityController.text);
      if (quantity != null && quantity > 0) {
        setState(() {
          // Menambahkan produk ke daftar
          products.add({
            'gambar': selectedProduct!['gambar'],
            'name': selectedProduct!['name'],
            'code': selectedProduct!['code'],
            'price': selectedProduct!['price'],
            'quantity': quantity,
            'unit': selectedProduct!['unit'],
          });
          // Reset form setelah menambahkan produk
          selectedProduct = null;
          quantityController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Jumlah barang tidak valid'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pilih produk dan masukkan jumlah barang'),
      ));
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
        title: Text('Produk Keluar', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,),
            onPressed: () {

              // Aksi untuk menyimpan perubahan produk keluar
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Add Product Button
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown untuk memilih produk
              DropdownButton<Map<String, dynamic>>(
                hint: Text(
                  'Pilih produk',
                  style: TextStyle(color: Colors.white),
                ),
                value: selectedProduct,
                onChanged: (Map<String, dynamic>? newValue) {
                  setState(() {
                    selectedProduct = newValue;
                  });
                },
                items: availableProducts.map((Map<String, dynamic> product) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: product,
                    child: Text(
                      product['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.purple[700],
              ),
              SizedBox(height: 20),

              // TextField untuk input kuantitas
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Masukkan jumlah',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black54,
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),

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
                'List Produk Keluar',
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
                    product['gambar'],
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
  Widget _buildProductItem(String gambar, String name, String code, int price, int quantity, String unit, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Kolom kiri dan kanan
        children: [
          Column(
            children: [
              Image.asset(
                gambar,
                width: 40, height: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
          SizedBox(width: 10),
          // Kolom di kiri (nama produk, kode, dan harga)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: 15)),
              Text('Code: $code', style: TextStyle(color: Colors.grey)),
              Text('Rp $price,00', style: TextStyle(color: Colors.green)),
            ],
          ),
          Spacer(), // Memberikan jarak otomatis antara teks dan ikon
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
