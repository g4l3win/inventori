import 'package:flutter/material.dart';

class PilihProductINPage extends StatelessWidget {

  final List<Map<String, dynamic>> productList = [
    {'name': 'Kaos Kaki Jempol', 'code': 'KKJL001', 'price': 50000, 'quantity': 52, 'unit': 'Lusin'},
    {'name': 'Sarung Tangan Putih', 'code': 'STP001', 'price': 48000, 'quantity': 23, 'unit': 'Lusin'},
    // Tambahkan produk lainnya
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(
          color: Colors.white, // Mengubah warna arrow back menjadi putih
        ),
        title: Row(
          children: [
            Text(
              'pilih Product masuk',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.purple.shade300,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final product = productList[index];
            return _buildProductItem(
              context,
              product['name'],
              product['code'],
              product['price'],
              product['quantity'],
              product['unit'],
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildProductItem(
      BuildContext context,
      String name,
      String code,
      int price,
      int quantity,
      String unit,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          _showQuantityDialog(context, name, code, price, unit); // Tambahkan harga dan unit ke dialog
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: Colors.white)),
                Text('Code: $code', style: TextStyle(color: Colors.white70)),
                Text('Rp $price', style: TextStyle(color: Colors.white)),
              ],
            ),
            Text('$quantity $unit', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog input kuantitas
  void _showQuantityDialog(BuildContext context, String name, String code, int price, String unit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController quantityController = TextEditingController();

        return AlertDialog(
          title: Text('Input Quantity'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
              hintText: 'Enter quantity',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                int? enteredQuantity = int.tryParse(quantityController.text);
                if (enteredQuantity != null) {
                  // Kembalikan data produk beserta kuantitasnya ke halaman INPage
                  Navigator.of(context).pop({
                    'name': name,
                    'code': code,
                    'price': price,
                    'quantity': enteredQuantity,
                    'unit': unit,
                  });
                  print('Menambah $enteredQuantity unit $name ke inventaris.');
                  _showSnackBar(context, 'Menambahkan $enteredQuantity unit $name dari inventaris.');
                }
                else {
                  print("Kuantitas tidak valid");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

