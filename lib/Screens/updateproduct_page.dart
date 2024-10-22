import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:inventori/db_helper/repository.dart';

class UpdateProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ProductRepository _productRepository = ProductRepository();

  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController unitController;
  File? _image;

  @override
  void initState() {
    super.initState();
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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> updateProductInDatabase(
      Map<String, dynamic> updatedProduct) async {
    try {
      await _productRepository.updateProduct(
          updatedProduct['code'], updatedProduct);
      Navigator.pop(context, updatedProduct);
    } catch (e) {
      print("Error updating product: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update product')));
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
            Navigator.pop(context);
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
              Text('Product Image *', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              _image != null
                  ? Image.file(_image!,
                      height: 150, width: 150, fit: BoxFit.cover)
                  : widget.product['gambar'] != null
                      ? _isLocalFile(widget.product['gambar'])
                          ? Image.file(File(widget.product['gambar']),
                              height: 150, width: 150, fit: BoxFit.cover)
                          : widget.product['gambar'].startsWith('http')
                              ? Image.network(widget.product['gambar'],
                                  height: 150, width: 150, fit: BoxFit.cover)
                              : Image.asset(widget.product['gambar'],
                                  height: 150, width: 150, fit: BoxFit.cover)
                      : Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey[300],
                          child: Icon(Icons.add_a_photo, color: Colors.white),
                        ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child:
                    Text('Pilih gambar', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              _buildTextField('Code *', codeController),
              SizedBox(height: 20),
              _buildTextField('Name *', nameController),
              SizedBox(height: 20),
              _buildTextField('Price *', priceController, isNumber: true),
              SizedBox(height: 20),
              _buildTextField('Stock *', stockController, isNumber: true),
              SizedBox(height: 20),
              _buildTextField('Unit *', unitController),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      final updatedProduct = {
                        'code': codeController.text,
                        'name': nameController.text,
                        'gambar': _image?.path ?? widget.product['gambar'],
                        'price': int.parse(priceController.text),
                        'quantity': int.parse(stockController.text),
                        'unit': unitController.text,
                      };
                      await updateProductInDatabase(updatedProduct);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  child: Text('Update Product',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the product $label.toLowerCase()';
        }
        return null;
      },
    );
  }

  bool _isLocalFile(String path) {
    return path.startsWith('/data/') || path.startsWith('/storage/');
  }
}
