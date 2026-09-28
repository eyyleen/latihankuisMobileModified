// Model = cetakan data. Class Animal mewakili satu data hewan.
class Animal {
  // "final" = nilainya tidak bisa diubah setelah objek dibuat
  final String name; // nama hewan
  final String type; // jenis hewan (Mammal, Reptile, dst.)
  final double weight; // berat dalam kg (double = bilangan desimal)
  final List<String> habitat; // daftar habitat (bisa lebih dari satu)
  final int height; // tinggi dalam cm (int = bilangan bulat)
  final List<String> activities; // daftar aktivitas hewan
  final String image; // URL gambar hewan

  // Constructor dengan named parameter (tanda kurung kurawal {}).
  // "required" = parameter wajib diisi saat membuat objek Animal.
  Animal({
    required this.name,
    required this.type,
    required this.weight,
    required this.habitat,
    required this.height,
    required this.activities,
    required this.image,
  });
}
