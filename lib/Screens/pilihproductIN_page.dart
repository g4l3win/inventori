import 'package:flutter/material.dart';

class PilihProductINPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            Text(
              'Product',
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
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Produk Masuk',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildProductItem(
                    context,
                    'Kaos Kaki Jempol Lutut',
                    'KKJL001',
                    'Rp 50.000,00',
                    52,
                    'Lusin',
                  ),
                  _buildProductItem(
                    context,
                    'Sarung tangan putih',
                    'STP001',
                    'Rp 48.000,00',
                    23,
                    'Lusin',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildProductItem(
      BuildContext context,
      String name,
      String code,
      String price,
      int quantity,
      String unit,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          _showQuantityDialog(context, name, quantity);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: Colors.white)),
                Text('Code: $code', style: TextStyle(color: Colors.white70)),
                Text(price, style: TextStyle(color: Colors.white)),
              ],
            ),
            Text('$quantity $unit', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _showQuantityDialog(BuildContext context, String productName, int quantity) {
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
                  print('Menambah $enteredQuantity unit $productName ke inventaris.');
                  _showSnackBar(context, 'Menambah $enteredQuantity unit $productName ke inventaris.');
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
