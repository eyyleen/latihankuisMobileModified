import 'package:flutter/material.dart';

import 'home_page.dart'; // halaman tujuan setelah login berhasil

// StatefulWidget dipakai karena halaman ini punya controller
// yang perlu dibuat dan dibuang (siklus hidup / lifecycle).
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // Menghubungkan widget ini dengan class State-nya
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Awalan "_" berarti private (hanya bisa diakses di file ini)
class _LoginPageState extends State<LoginPage> {
  // "static const" = konstanta milik class, nilainya tetap
  static const String _validUsername = '124240023'; // NIM
  static const String _validPassword = 'Sistem Informasi'; // nama prodi

  // Controller untuk membaca teks yang diketik di TextField
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // dispose() dipanggil saat halaman dihancurkan.
  // Controller harus dilepas agar tidak terjadi kebocoran memori.
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose(); // wajib dipanggil, letakkan paling akhir
  }

  // Fungsi yang dijalankan saat tombol Login ditekan / Enter di kolom password
  void _login() {
    // Ambil teks dari field, trim() membuang spasi di awal dan akhir
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Cocokkan input dengan kredensial yang benar
    if (username == _validUsername && password == _validPassword) {
      // pushReplacement = ganti halaman ini dengan HomePage,
      // jadi tombol Back tidak akan kembali ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      // Tutup snackbar lama dulu supaya pesan tidak menumpuk
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Tampilkan pesan error berlatar merah di bagian bawah layar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal! Username atau password salah.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Center = letakkan isinya di tengah layar
      body: Center(
        // Agar bisa di-scroll (mencegah overflow saat keyboard muncul)
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          // Card = kotak dengan bayangan (elevation) dan sudut membulat
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              // Column = susun widget dari atas ke bawah
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // tinggi kolom sesuai isinya saja
                children: [
                  // Judul halaman
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24), // jarak vertikal 24
                  // Kolom input username
                  TextField(
                    controller: _usernameController, // hubungkan ke controller
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(), // garis tepi kotak
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Kolom input password
                  TextField(
                    controller: _passwordController,
                    obscureText: true, // samarkan teks menjadi titik-titik
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    // Saat tekan Enter di keyboard, langsung jalankan _login
                    onSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: 24),
                  // SizedBox dengan lebar tak hingga agar tombol selebar kartu
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _login, // fungsi yang dipanggil saat ditekan
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
