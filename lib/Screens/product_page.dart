import 'package:flutter/material.dart';
import 'addproduct_page.dart';
import 'updateproduct_page.dart';
import 'package:inventori/db_helper/repository.dart'; // Tambahkan ini
import 'dart:io';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> products = [];
  final ProductRepository _productRepository =
      ProductRepository(); // Tambahkan ini

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Panggil fungsi untuk memuat produk dari database
  }

  Future<void> _loadProducts() async {
    List<Map<String, dynamic>> productList =
        await _productRepository.getAllProducts();
    setState(() {
      products = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final newProduct = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              );

              if (newProduct != null) {
                await _productRepository.addProduct(newProduct);
                _loadProducts(); // Refresh daftar produk
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar Produk',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
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
                    context,
                    index,
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

  Widget _buildProductItem(String gambar, String name, String code, int price,
      int quantity, String unit, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              gambar.isNotEmpty
                  ? (_isLocalFile(gambar)
                      ? Image.file(
                          File(gambar),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          gambar,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ))
                  : Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey,
                    ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                code,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Rp $price',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          Spacer(),
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
                  _showOptions(context, name, index);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

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
                  Navigator.pop(context);
                  _updateProduct(context, index);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  Navigator.pop(context);
                  await _productRepository
                      .deleteProduct(products[index]['code']);
                  _loadProducts(); // Refresh setelah delete
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateProduct(BuildContext context, int index) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProductPage(product: products[index]),
      ),
    );

    if (updatedProduct != null) {
      await _productRepository.updateProduct(
          products[index]['code'], updatedProduct);
      _loadProducts();
    }
  }

  bool _isLocalFile(String path) {
    return path.startsWith('/data/') || path.startsWith('/storage/');
  }
}
