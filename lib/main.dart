// Import library Material Design bawaan Flutter (Scaffold, AppBar, dll.)
import 'package:flutter/material.dart';
// Import halaman login, karena ini halaman pertama yang tampil
import 'pages/login_page.dart';

// Titik masuk aplikasi. Fungsi main() selalu dijalankan pertama kali.
// runApp() memasang widget MyApp sebagai widget paling atas (root).
void main() => runApp(const MyApp());

// StatelessWidget = widget yang tampilannya tetap, tidak menyimpan data yang berubah
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build() dipanggil Flutter untuk menyusun tampilan widget ini
  @override
  Widget build(BuildContext context) {
    // MaterialApp = "cangkang" aplikasi bergaya Material Design
    return MaterialApp(
      title: 'Animals App', // nama aplikasi (dipakai oleh sistem operasi)
      debugShowCheckedModeBanner: false, // sembunyikan pita "DEBUG" di pojok kanan atas
      theme: ThemeData(
        useMaterial3: true, // aktifkan gaya Material 3
        // Buat seluruh palet warna otomatis dari satu warna dasar (teal)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const LoginPage(), // halaman pertama yang dibuka
    );
  }
}
