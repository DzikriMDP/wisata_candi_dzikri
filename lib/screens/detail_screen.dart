import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';
import 'package:wisata_candi/screens/profile_screen.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({
    super.key,
    required this.candi,
  });

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavoriteProvider>().isFavorite(candi.name);

    return Scaffold(
      // Tombol sementara untuk menguji ProfileScreen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
        child: const Icon(Icons.person),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama dan tombol kembali
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      candi.imageAsset,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Tombol kembali
                Positioned(
                  top: 40,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),

            // Informasi candi
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama candi dan tombol favorit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          candi.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<FavoriteProvider>().toggle(candi.name);
                        },
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Informasi lokasi
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.place, color: Colors.red),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Lokasi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(': '),
                      Expanded(child: Text(candi.location)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Divider(color: Colors.deepPurple.shade100),

                  const SizedBox(height: 16),

                  // Deskripsi candi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    candi.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}