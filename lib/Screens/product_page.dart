import 'package:flutter/material.dart';
import 'addproduct_page.dart';
import 'updateproduct_page.dart'; // Import halaman update

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // List produk yang bisa berubah
  List<Map<String, dynamic>> products = [
    {
      'name': 'Kaos Kaki Jempol Lutut',
      'code': 'KKJL001',
      'price': 'Rp 50.000,00',
      'quantity': 52,
      'unit': 'Lusin'
    },
    {
      'name': 'Sarung tangan putih',
      'code': 'STP001',
      'price': 'Rp 48.000,00',
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
            onPressed: () {
              // Navigasi ke halaman AddProductPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              ); // Aksi untuk menambahkan produk baru
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
  Widget _buildProductItem(String name, String code, String price, int quantity, String unit, BuildContext context, int index) {
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
