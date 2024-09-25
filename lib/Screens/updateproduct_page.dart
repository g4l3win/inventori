import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // Import untuk file

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

  File? _image; // Untuk menyimpan gambar baru yang dipilih
  @override
  void initState() {
    super.initState();
    // Mengisi TextEditingController dengan data produk yang akan diupdate
    codeController = TextEditingController(text: widget.product['code']);
    nameController = TextEditingController(text: widget.product['name']);
    priceController =
        TextEditingController(text: widget.product['price'].toString());
    stockController =
        TextEditingController(text: widget.product['quantity'].toString());
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

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Simpan gambar baru yang dipilih
      });
    }
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
              // Tampilkan gambar produk atau tombol untuk pilih gambar
              Text(
                'Product Image *',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              _image != null
                  ? Image.file(
                      _image!, // Gambar baru yang dipilih
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : widget.product['gambar'] != null
                      ? _isLocalFile(widget.product['gambar'])
                          ? Image.file(
                              File(widget.product['gambar']), // Gambar lama dari produk
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : widget.product['gambar'].startsWith('http')
                              ? Image.network(
                                  widget.product['gambar'], // Jika gambar berasal dari URL
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  widget.product['gambar'], // Jika gambar berasal dari asset lokal
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                      : Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey[300],
                          child: Icon(Icons.add_a_photo, color: Colors.white),
                        ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage, // Aksi untuk memilih gambar baru
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child:
                    Text('Pilih gambar', style: TextStyle(color: Colors.white)),
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

              // Update Product Button
              SizedBox(
                width: double.infinity, // Agar tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi untuk edit produk
                    if (_formKey.currentState?.validate() == true) {
                      // Kembalikan produk yang telah diupdate ke halaman sebelumnya
                      Navigator.pop(context, {
                        'gambar': _image?.path ??
                            widget.product[
                                'gambar'], // Gambar baru atau tetap gambar lama
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
                  child: Text('Update Product',
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

// Fungsi untuk cek apakah gambar adalah path file lokal
bool _isLocalFile(String path) {
  return path.startsWith('/data/') ||
      path.startsWith('/storage/'); // Sesuaikan dengan path dari cache/galeri
}
