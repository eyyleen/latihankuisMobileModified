import 'package:flutter/material.dart';
import '../data/animals_data.dart'; // sumber data dummyAnimals
import '../models/animal.dart'; // tipe data Animal
import '../widgets/tag_chip.dart'; // widget chip untuk habitat
import 'animal_detail_page.dart'; // halaman tujuan saat kartu ditekan
import 'login_page.dart'; // halaman tujuan saat logout

// Halaman utama: menampilkan daftar hewan dalam bentuk grid
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bilah judul di bagian atas
      appBar: AppBar(
        title: const Text('Animals List',
            style: TextStyle(fontWeight: FontWeight.bold)),
        // actions = tombol-tombol di sisi kanan AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout', // teks bantuan saat ikon ditahan
            // Kembali ke LoginPage (halaman ini diganti, bukan ditumpuk)
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            ),
          ),
        ],
      ),
      // GridView.builder membuat item hanya saat dibutuhkan (lebih hemat memori)
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyAnimals.length, // jumlah item = jumlah data hewan
        // Pengaturan tata letak grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 12, // jarak horizontal antar kartu
          mainAxisSpacing: 12, // jarak vertikal antar kartu
          mainAxisExtent: 270, // tinggi tetap tiap kartu
        ),
        // Dipanggil untuk setiap item; index = urutan item (mulai dari 0)
        itemBuilder: (context, index) =>
            _AnimalCard(animal: dummyAnimals[index]),
      ),
    );
  }
}

// Kartu untuk satu hewan. Awalan "_" = private, hanya dipakai di file ini.
class _AnimalCard extends StatelessWidget {
  final Animal animal; // data hewan yang ditampilkan
  const _AnimalCard({required this.animal});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // potong isi mengikuti sudut kartu
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // InkWell = area yang bisa ditekan dengan efek riak
      child: InkWell(
        // push = buka halaman detail di atas halaman ini (bisa kembali dengan Back)
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AnimalDetailPage(animal: animal)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // rata kiri
          children: [
            // Hero = animasi perpindahan gambar ke halaman detail.
            // Tag harus sama dengan Hero di halaman detail.
            Hero(
              tag: animal.name,
              child: Image.network(
                animal.image, // URL gambar dari internet
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover, // penuhi area, bagian berlebih dipotong
                // Saat gambar sedang dimuat
                loadingBuilder: (c, child, progress) => progress == null
                    ? child // progress null = gambar selesai, tampilkan gambar
                    : const SizedBox(
                        height: 140,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                // Jika gambar gagal dimuat, tampilkan ikon rusak
                errorBuilder: (c, e, s) => const SizedBox(
                  height: 140,
                  child: Center(child: Icon(Icons.broken_image, size: 40)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama hewan, maksimal 1 baris, kelebihan dipotong dengan "..."
                  Text(
                    animal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  // Jenis hewan, warna abu-abu
                  Text(animal.type,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 8),
                  // Wrap = susun ke samping, otomatis turun baris jika tidak muat
                  Wrap(
                    spacing: 6, // jarak horizontal antar chip
                    runSpacing: 6, // jarak vertikal antar baris chip
                    // map() mengubah setiap String habitat menjadi widget TagChip,
                    // toList() mengubah hasilnya menjadi List
                    children: animal.habitat.map((h) => TagChip(h)).toList(),
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
