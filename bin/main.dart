import 'dart:io';
import '../services/keranjangItem.dart';
import '../services/produkManager.dart';
import '../services/transaksiManager.dart';

void clearScreen() {
  print("\x1B[2J\x1B[3J\x1B[H");
}

final ProdukManager produkManager = ProdukManager();
final KeranjangManager keranjangManager = KeranjangManager(produkManager);
final TransaksiManager transaksiManager = TransaksiManager(keranjangManager, produkManager);


void produk() {
  int menu2 = 0;
  while(menu2 != 4) {
    clearScreen();
    print("\n     --== Produk ==--\n");

    print(" ====================== ");
    print("| Menu | Keterangan    |");
    print(" ---------------------- ");
    print("|  01  | Daftar Produk |");
    print("|  02  | Tambah Produk  |");
    print("|  03  | Hapus Produk  |");
    print("|  04  | Keluar        |");
    print(" ====================== ");

    stdout.write("Pilih Menu : ");
    String? input = stdin.readLineSync();
    menu2 = int.parse(input?.isEmpty ?? true ? '0' : input!);

    switch (menu2) {
      case 1 :
        produkManager.showProduk();
        stdin.readLineSync();
        break;
      case 2 :
        produkManager.inputProduk();
        break;
      case 3 :
        produkManager.deleteProduk();
        break;
      case 4 :
        print("\n   Anda Keluar Dari Program . . .\n");
        break;
      default:
        print("\n== Pilihan Anda Tidak Tersedia ! ==\n");
        stdin.readLineSync();
        break;
    }
  }
}

void Transaksi() {
  clearScreen();
  transaksiManager.addTransaksi();
}

void laporan() {
  int menu4 = 0;
  while(menu4 != 3) {
    clearScreen();
    print("\n     --== Laporan Transaksi ==--\n");

    print(" ==================================== ");
    print("| Menu | Keterangan                  |");
    print(" ------------------------------------ ");
    print("|  01  | Semua Transaksi             |");
    print("|  02  | Transaksi Berdasarkan Kasir |");
    print("|  03  | Keluar                      |");
    print(" ==================================== ");

    stdout.write("Pilih Menu : ");
    String? input = stdin.readLineSync();
    menu4 = int.parse(input?.isEmpty ?? true ? '0' : input!);

    switch (menu4) {
      case 1 :
        clearScreen();
        transaksiManager.showAllTransaksi();
        stdin.readLineSync();
        break;
      case 2 :
        clearScreen();
        transaksiManager.pilihTransaksiBerdasarkanKasir();
        stdin.readLineSync();
        break;
      case 3 :
        print("\n   Anda Keluar Dari Program . . .\n");
        break;
      default:
        print("\n== Pilihan Anda Tidak Tersedia ! ==\n");
        stdin.readLineSync();
        break;
    }
  }
}

void main() {


  int? menu1 = 0;
  do {
    clearScreen();
    print("\n     --== Program Toko ==--\n\n");
    print(" ===================== ");
    print("| Menu | Keterangan   |");
    print(" --------------------- ");
    print("|  01  | Produk       |");
    print("|  02  | Transaksi    |");
    print("|  03  | Laporan      |");
    print("|  04  | Keluar       |");
    print(" ===================== ");

    stdout.write("\nPilih Menu : ");
    String? input = stdin.readLineSync();
    menu1 = int.parse(input?.isEmpty ?? true ? '0' : input!);

    switch (menu1) {
      case 1 :
        produk();
        break;
      case 2 :
        // Transaksi();
        keranjangManager.rule();
        break;
      case 3 :
        laporan();
        break;
      case 4 :
        print("\n   Anda Keluar Dari Program . . .\n");
        break;
      default:
        print("\n== Pilihan Anda Tidak Tersedia ! ==\n");
        stdin.readLineSync();
        break;
    }
  } while (menu1 != 4);
}
