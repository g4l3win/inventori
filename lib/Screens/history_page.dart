import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Daftar riwayat yang bisa diubah
  List<Map<String, String>> history = [
    {'date': 'Thu, 19 May 2022', 'amount': 'Rp 72.750.000,00'},
    {'date': 'Thu, 19 May 2022', 'amount': 'Rp 3.000,00'},
    // Tambahkan item lainnya sesuai kebutuhan
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
            Text('History', style: TextStyle(color: Colors.white)),
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
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            return _buildHistoryItem(item['date']!, item['amount']!, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi untuk tombol FAB (misalnya menghapus riwayat)
          _showDeleteOptions();
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.delete),
      ),
      backgroundColor: Colors.black, // Latar belakang hitam
    );
  }

  // Fungsi untuk membuat item riwayat
  Widget _buildHistoryItem(String date, String amount, int index) {
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

  // Fungsi untuk menampilkan modal dengan pilihan item yang bisa dihapus
  void _showDeleteOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black87,
          child: Wrap(
            children: history.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> item = entry.value;
              return ListTile(
                leading: Icon(Icons.history, color: Colors.white),
                title: Text(
                  '${item['date']} - ${item['amount']}',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.delete, color: Colors.red),
                onTap: () {
                  Navigator.pop(context); // Tutup modal
                  _deleteItem(index); // Hapus item yang dipilih
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Fungsi untuk menghapus item dari list riwayat
  void _deleteItem(int index) {
    setState(() {
      history.removeAt(index); // Hapus item dari daftar
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Item berhasil dihapus'),
    ));
  }
}
