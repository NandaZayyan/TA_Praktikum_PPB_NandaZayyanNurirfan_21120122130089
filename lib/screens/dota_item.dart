import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Map<String, dynamic>> itemList = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    // Membaca file JSON dari assets
    final String response = await rootBundle.loadString('assets/items.json');
    final Map<String, dynamic> data = json.decode(response);

    // Pastikan setState hanya dipanggil jika widget masih aktif
    if (mounted) {
      setState(() {
        itemList = List<Map<String, dynamic>>.from(data['items']);
      });
    }
  }

  // Fungsi untuk mengubah huruf pertama menjadi kapital
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Dota 2 Items'),
      ),
      body: itemList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0), // Padding di sekitar grid
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Menampilkan 5 kolom
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8, // Mengatur proporsi item agar lebih tinggi
              ),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                final itemName = item['name'] ?? 'Unknown Item';
                final itemImageUrl = item['image_url'] ?? ''; // URL gambar

                return Card(
                  elevation: 4.0, // Bayangan untuk efek elegan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Membulatkan sudut
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 7, // Fleksibilitas untuk menyesuaikan ruang gambar
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8.0), // Membulatkan sudut atas
                          ),
                          child: Image.network(
                            itemImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 50); // Ikon jika gagal
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator()); // Loading indikator
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3, // Fleksibilitas untuk teks
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 4.0), // Padding di sekitar teks
                          child: Text(
                            capitalizeFirstLetter(itemName),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9.0,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis, // Memotong teks panjang
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
