import 'dart:io';

import '../lib/produk.dart';

class ProdukManager {
  List<Produk> _daftarProduk = [];
  List<Produk> get daftarProduk => _daftarProduk;

  ProdukManager() {
    _daftarProduk.add(Produk(nama: 'Kopi', harga: 25000, stok: 50));
    _daftarProduk.add(Produk(nama: 'Teh', harga: 12000, stok: 70));
    _daftarProduk.add(Produk(nama: 'Aqua', harga: 2000, stok: 200));
    _daftarProduk.add(Produk(nama: 'Susu', harga: 7000, stok: 120));
    _daftarProduk.add(Produk(nama: 'Roti', harga: 3000, stok: 150));
    _daftarProduk.add(Produk(nama: 'Keju', harga: 4000, stok: 80));
    _daftarProduk.add(Produk(nama: 'Gula', harga: 7000, stok: 100));
  }

  void showProduk() {
    print("     =============== DAFTAR PRODUK ==============");
    print("     ============================================ ");
    print("    | Nama Produk               |  Harga  | Stok |");
    print("     -------------------------------------------- ");
    for (var produk in _daftarProduk) {
      print(
          "    | ${produk.nama.padRight(25)} | ${produk.harga.toString().padRight(7)} | ${produk.stok.toString().padRight(3)}  |");
    }
    print("     ============================================ \n");
  }

  void inputProduk() {
    bool run = true;
    while(run) {
      print("\n---------------=== Tambah Produk ===---------------\n");
      stdout.write("Masukkan nama produk : ");
      String? namaProduk = stdin.readLineSync();
      if (namaProduk == null || namaProduk.isEmpty) {
        print("\n     == Nama tidak voleh kosong ! ==\n");
        if (!errorLoop()) break;
        continue;
      }

      stdout.write("Masukkan harga produk : ");
      int? hargaProduk;
      try {
        hargaProduk = int.parse(stdin.readLineSync() ?? '0');
      } catch(e) {
        print("\n   Input harga error ! \n");
        if (!errorLoop()) break;
        continue;
      }

      stdout.write("Masukkan harga produk : ");
      int? stokProduk;
      try {
        stokProduk = int.parse(stdin.readLineSync() ?? '0');
      } catch(e) {
        print("\n   Input stok error ! \n");
        if (!errorLoop()) break;
        continue;
      }

      _daftarProduk.add(Produk(nama: namaProduk, harga: hargaProduk, stok: stokProduk));
      print("\n---------------------------------------------------\n");

      if (!addloop()) break;
    }
  }

  void deleteProduk() {
    bool run = true;
    while(run) {
      showProduk();
      print("\n---------------=== Tambah Produk ===---------------\n");
      stdout.write("Masukkan nama produk : ");
      String? hapusProduk = stdin.readLineSync()?.toLowerCase();
      if (hapusProduk == null || hapusProduk.isEmpty) {
        print("\n     == Nama tidak voleh kosong ! ==\n");
        if (!errorLoop()) break;
        continue;
      }

      var produk = _daftarProduk.firstWhere(
        (p) => p.nama.toLowerCase() == hapusProduk,
        orElse: () => Produk(nama: '', harga: 0, stok: 0),
      );

      if (produk.nama.isEmpty) {
        print("\n     == Produk '$hapusProduk' tidak ditemukan! ==\n");
        if (!errorLoop()) break;
        continue;
      }

      stdout.write("Apakah anda yakin ingin menghapus produk '${produk.nama}'? (Y/N): ");
      String? konfirmasi = stdin.readLineSync()?.toUpperCase();
      if (konfirmasi == 'Y') {
        _daftarProduk.remove(produk);
        print("\n     == Produk '${produk.nama}' berhasil dihapus! ==\n");
      } else {
        print("\n     == Penghapusan produk dibatalkan! ==\n");
      }

      if (!delLoop()) break;
    }
  }

  bool isProdukAvailable(String produk) {
    return _daftarProduk.any((p) => p.nama.toLowerCase() == produk);
  }

  bool cekStok(String namaProduk, int jumlah) {
    var produk = _daftarProduk.firstWhere(
      (p) => p.nama.toLowerCase() == namaProduk.toLowerCase(),
      orElse: () => Produk(nama: '', harga: 0, stok: 0),
    );

    if (produk.nama.isEmpty) {
      print("Produk '$namaProduk' tidak ditemukan!");
      return false;
    }
     if (produk.stok < jumlah) {
      return false;
    }
    return true;
  }

  void stok(String namaProduk, int jumlah) {
    var produk = _daftarProduk.firstWhere(
      (p) => p.nama.toLowerCase() == namaProduk.toLowerCase(),
      orElse: () => Produk(nama: '', harga: 0, stok: 0),
    );

    if (produk.nama.isEmpty) {
      print("Produk '$namaProduk' tidak ditemukan!");
      return;
    }

    if (produk.stok >= jumlah) {
      produk.stok -= jumlah;
    }
  }

  bool errorLoop() {
    stdout.write("Anda ingin mengulang? (Y/N) : ");
    String? errorLoop = stdin.readLineSync()?.toUpperCase();
    return errorLoop == 'Y';
  }

  bool addloop() {
    stdout.write("Apakah anda ingin menambah produk lagi? (Y/N) : ");
      String? loop = stdin.readLineSync()?.toUpperCase();
      return loop == 'Y';
  }

  bool delLoop() {
    stdout.write("Apakah anda ingin menghapus produk lagi? (Y/N) : ");
      String? loop = stdin.readLineSync()?.toUpperCase();
      return loop == 'Y';
  }
}
