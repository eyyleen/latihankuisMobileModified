import 'package:flutter/material.dart';

// Widget kecil yang bisa dipakai ulang (reusable):
// label kotak untuk menampilkan habitat atau aktivitas.
class TagChip extends StatelessWidget {
  final String label; // teks yang ditampilkan di dalam chip

  // "this.label" tanpa kurung kurawal = parameter positional.
  // Dipanggil seperti: TagChip("Forest")
  const TagChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Jarak antara isi (teks) dan tepi kotak
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      // Dekorasi kotak: warna latar, garis tepi, sudut membulat
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      // Teks label dengan font kecil dan sedikit tebal
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
