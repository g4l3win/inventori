import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            Text(
                'History',
                style: TextStyle(color: Colors.white)
            ),
            SizedBox(width: 20), // Memberi jarak antara judul dan search bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.purple.shade300, // Warna latar belakang search bar
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none, // Menghapus border search bar
                  ),
                ),
                style: TextStyle(color: Colors.white), // Warna teks search bar
              ),
            ),
          ],
        ),
        actions: [
          // Ikon pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHistoryItem('Thu, 19 May 2022', 'Rp 72.750.000,00'),
            _buildHistoryItem('Thu, 19 May 2022', 'Rp 3.000,00'),
            // Tambahkan item lainnya sesuai kebutuhan
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi untuk tombol FAB (misalnya menghapus riwayat)
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.delete),
      ),
      backgroundColor: Colors.black, // Latar belakang hitam
    );
  }

  // Fungsi untuk membuat item riwayat
  Widget _buildHistoryItem(String date, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebar item kiri dan kanan
        children: [
          Row(
            children: [
              Icon(Icons.check, color: Colors.green), // Ikon centang hijau
              SizedBox(width: 10), // Jarak antara ikon dan teks
              Text(
                date,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
