import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product', style: TextStyle(color: Colors.white)),
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

              // Add Product Button
              SizedBox(
                width: double.infinity, // Agar tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi untuk menambahkan produk
                    if (_formKey.currentState?.validate() == true) {
                      // Lakukan validasi form dan aksi lainnya
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product Added!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Warna tombol ungu
                  ),
                  child: Text('Add Product', style: TextStyle(color: Colors.white)),
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
