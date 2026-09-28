import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../widgets/tag_chip.dart';

// Halaman detail satu hewan
class AnimalDetailPage extends StatelessWidget {
  final Animal animal; // data hewan yang dikirim dari HomePage
  const AnimalDetailPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading = bagian paling kiri AppBar (tombol kembali buatan sendiri)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // pop = tutup halaman ini dan kembali ke halaman sebelumnya
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(animal.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      // Agar isi halaman bisa di-scroll jika melebihi layar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero dengan tag yang sama seperti di HomePage,
            // sehingga gambar "terbang" mulus saat pindah halaman
            Hero(
              tag: animal.name,
              // ClipRRect = memotong isinya dengan sudut membulat
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  animal.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Jika gambar gagal dimuat, tampilkan ikon rusak
                  errorBuilder: (c, e, s) => const SizedBox(
                    height: 220,
                    child: Center(child: Icon(Icons.broken_image, size: 48)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Animal Details:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Baris informasi (label : nilai) memakai fungsi bantu _infoRow
            _infoRow('Name', animal.name),
            _infoRow('Type', animal.type),
            // ${...} = string interpolation, menyisipkan nilai ke dalam teks
            _infoRow('Height', '${animal.height} cm'),
            _infoRow('Weight', '${animal.weight} kg'),
            const SizedBox(height: 16),
            _sectionTitle('Habitat'),
            // Tampilkan setiap habitat sebagai TagChip
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: animal.habitat.map((h) => TagChip(h)).toList(),
            ),
            const SizedBox(height: 16),
            _sectionTitle('Animal Activities'),
            // Tampilkan setiap aktivitas sebagai TagChip
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: animal.activities.map((a) => TagChip(a)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi bantu: judul bagian (teks tebal dengan jarak di bawahnya)
  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );

  // Fungsi bantu: satu baris informasi berbentuk "Label : Nilai"
  Widget _infoRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            // Lebar label dikunci 80 agar tanda ":" sejajar di setiap baris
            SizedBox(
                width: 80,
                child: Text(label,
                    style: TextStyle(color: Colors.grey.shade700))),
            Text(': $value'),
          ],
        ),
      );
}
