import 'dart:io';
import '../bin/main.dart';
import '../lib/produk.dart';
import '../lib/keranjang_item.dart';
import 'produkManager.dart';

class KeranjangManager {
  List<KeranjangItem> _items = [];
  ProdukManager produkManager;
  KeranjangManager(this.produkManager);

  List<KeranjangItem> get item => _items;

  void rule() {
    clearScreen();
    bool run = true; 
    int menu = 0;
    while(run) {
      showKeranjang();

      print("\n|01| => Tambah barang ke keranjang");
      print("|02| => Hapus barang ke keranjang");
      print("|03| => Kosongkan keranjang");
      print("|04| => Lanjut membayar");
      print("|05| => Keluar");

      stdout.write("\nPilih Menu : ");
      String? input = stdin.readLineSync();
      menu = int.parse(input?.isEmpty ?? true ? '0' : input!);

      switch (menu) {
        case 1 :
          addKeranjang();
          break;
        case 2 :
          deleteProduk();
          break;
        case 3 :
          deleteAll();
          break;
        case 4 :
          transaksiManager.addTransaksi();
          run = false;
          break;
        case 5 :
          run = false;
          break;
        default:
          print("\n== Pilihan Anda Tidak Tersedia ! ==\n");
          stdin.readLineSync();
          break;
      }
    }
  }

  void addKeranjang() {
    bool run = true;
    while(run) {
      clearScreen();
      produkManager.showProduk();

      print("\n----------=== Tambah Produk Keranjang ===----------\n");
      stdout.write("Masukkan nama produk yang ingin dipesan : ");
      String? inputProduk = stdin.readLineSync()?.toLowerCase();
      if (inputProduk == null || inputProduk.isEmpty) {
        print("\n     Produk tidak ditemukan ! \n");
        if(!addloop()) break;
        continue;
      } else if (!produkManager.isProdukAvailable(inputProduk)) {
        print("\n     Barang yang anda pilih tidak tersedia! \n");
        if(!addloop()) break;
        continue;
      }

      stdout.write("Masukkan jumlah produk yang ingin dipesan : ");
      int? inputJumlah;
      try {
        inputJumlah = int.parse(stdin.readLineSync() ?? '0');
      } catch(e) {
        print("\n   Input jumlah error ! \n");
        if (!errorLoop()) break;
        continue;
      }
      print("\n---------------------------------------------------\n");

      var produk = produkManager.daftarProduk.firstWhere(
        (p) => p.nama.toLowerCase() == inputProduk.toLowerCase(),
        orElse: () => Produk(nama: '', harga: 0, stok: 0),
      );

      if (!produkManager.cekStok(inputProduk, inputJumlah)) {
        print("\nStok produk '${inputProduk}' tidak mencukupi. Stok saat ini: ${produk.stok}\n");
        if (!errorLoop()) break;
        continue;
      }

      _items.add(KeranjangItem(produk: produk, jumlah: inputJumlah));
      
      if(!addloop()) break;
    }
  }

  void showKeranjang() {
    if (_items.isEmpty) {

      print("\n    =========================== ");
      print("   |  Item Keranjang Kosong !  |");
      print("    =========================== \n");
      return;
    }

    print("\n     ============== Item Keranjang ============== ");
    print("     ============================================ ");
    print("    | Nama Produk               |  Harga  | Stok |");
    print("     -------------------------------------------- ");
    for (var item in _items) {
      print("    | ${item.produk.nama.toString().padRight(25)} | ${item.produk.harga.toString().padRight(7)} |  ${item.jumlah.toString().padRight(3)} |");
    }
    print("     ============================================ ");
  }

  void deleteProduk () {
    clearScreen();
    if (_items.isEmpty) {
      print("\n    Item Kosong !   \n");
      return;
    }

    showKeranjang();
    stdout.write("\nMasukkan nama produk yang ingin dihapus: ");
    String? namaProduk = stdin.readLineSync();
    if (namaProduk == null || namaProduk.isEmpty) {
      print("\n    Nama produk tidak boleh kosong! \n");
      return;
    }

    var itemToRemove = _items.firstWhere(
      (item) => item.produk.nama.toLowerCase() == namaProduk.toLowerCase(),
      orElse: () => KeranjangItem(produk: Produk(nama: '', harga: 0, stok: 0), jumlah: 0),
    );

    if (itemToRemove.produk.nama.isEmpty) {
      print("\n    Produk dengan nama '$namaProduk' tidak ditemukan di keranjang! \n");
      return;
    }

    _items.remove(itemToRemove);
  }

  void deleteAll() {
    clearScreen();
    _items.clear();
  }

  void clearScreen() {
    print("\x1B[2J\x1B[3J\x1B[H");
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
}