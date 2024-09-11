import 'package:flutter/material.dart';
import 'package:inventori/Screens/OUT_page.dart';
import 'package:inventori/Screens/history_page.dart';
import 'product_page.dart';
import 'login_page.dart';
import 'IN_page.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //scaffold untuk mengatur halaman aplikasi yang konsisten buat appbar, body dst
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menyembunyikan tombol arrow back
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigasi ke halaman login dan hapus riwayat halaman sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) =>
                    false, // Menghapus semua halaman sebelumnya
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Admin
            Card(
              color: Colors.purple,
              child: ListTile(
                title: Text(
                  'Admin',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'admin@gmail.com\n(Admin)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Menu Grid
            Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),

            // Grid View for Menu
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildMenuItem('Product', '2 Item', Icons.inventory,
                      onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductPage()),
                    );
                  }),
                  _buildMenuItem('History', '1 Act', Icons.history, onTap: () {
                    // Navigasi ke halaman history
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    ); // Aksi untuk melihat history
                  }),
                  _buildMenuItem('IN', '1 Item', Icons.arrow_downward,
                      onTap: () {
                    // Navigasi ke halaman history
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => INPage()),
                    );
                  }),
                  _buildMenuItem('OUT', '2 Item', Icons.arrow_upward,
                      onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OUTPage()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black, // Background hitam sesuai dengan gambar
    );
  }

  // Fungsi untuk membangun tampilan setiap item di Grid
  Widget _buildMenuItem(String title, String subtitle, IconData icon,
      {VoidCallback? onTap}) {
    return Card(
      color: Colors.deepPurple,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 30), // Tambahkan Icon
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[200], fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
