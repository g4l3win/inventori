import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Import image_picker
import 'dart:io';  // Import untuk file

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}
class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  File? _image;  // Untuk menyimpan gambar yang dipilih
  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);  // Simpan path gambar yang dipilih
      });
    }
  }
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
              //gambar produk
              Text(
                'Product Image *',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),

              // Tampilkan gambar yang dipilih atau tombol tambah gambar
              _image != null
                  ? Image.file(
                _image!,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              )
                  : GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.grey[300],
                  child: Icon(Icons.add_a_photo, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
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

              // Add Product Button
              SizedBox(
                width: double.infinity, // Agar tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi untuk menambahkan produk
                    if (_formKey.currentState?.validate() == true) {
                      // Kembalikan data produk ke ProductPage
                      Navigator.pop(context, {
                        'gambar': _image?.path ?? 'img/fotoa.jpg',  // Gunakan gambar default jika tidak ada, // Kirim path gambar
                        'code': codeController.text,
                        'name': nameController.text,
                        'price': int.parse(priceController.text),
                        'quantity': int.parse(stockController.text),
                        'unit': unitController.text,
                      });
                      // Lakukan validasi form dan aksi lainnya
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product Added!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Warna tombol ungu
                  ),
                  child: Text('Add Product',
                      style: TextStyle(color: Colors.white)),
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
