import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  final Map<String, dynamic> product; // Menerima data produk

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController unitController;

  @override
  void initState() {
    super.initState();
    // Mengisi TextEditingController dengan data produk yang akan diupdate
    codeController = TextEditingController(text: widget.product['code']);
    nameController = TextEditingController(text: widget.product['name']);
    priceController = TextEditingController(text: widget.product['price'].toString());
    stockController = TextEditingController(text: widget.product['quantity'].toString());
    unitController = TextEditingController(text: widget.product['unit']);
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code
              TextFormField(
                controller: codeController,
                decoration: InputDecoration(
                  labelText: 'Code *',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name *',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Price
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price *',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Stock
              TextFormField(
                controller: stockController,
                decoration: InputDecoration(
                  labelText: 'Stock *',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product stock';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Unit
              TextFormField(
                controller: unitController,
                decoration: InputDecoration(
                  labelText: 'Unit *',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product unit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Update Product Button
              SizedBox(
                width: double.infinity, // Agar tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi untuk edit produk
                    if (_formKey.currentState?.validate() == true) {
                      // Kembalikan produk yang telah diupdate ke halaman sebelumnya
                      Navigator.pop(context, {
                        'name': nameController.text,
                        'code': codeController.text,
                        'price': int.parse(priceController.text),
                        'quantity': int.parse(stockController.text),
                        'unit': unitController.text,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Warna tombol ungu
                  ),
                  child: Text('Update Product', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black, // Latar belakang hitam
      resizeToAvoidBottomInset: true, // Atur ulang ketika keyboard muncul
    );
  }
}
