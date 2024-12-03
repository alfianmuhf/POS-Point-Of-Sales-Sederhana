import 'dart:io';
import '../lib/keranjang_item.dart';
import '../lib/transaksi.dart';
import '../lib/kasir.dart';
import 'keranjangItem.dart';
import 'produkManager.dart';

class TransaksiManager {
  final List<Transaksi> _daftarTransaksi = [];
  final List<Kasir> _daftarKasir = [];
  final KeranjangManager keranjangManager;
  final ProdukManager produkManager;
  TransaksiManager(this.keranjangManager, this.produkManager,);

  void addTransaksi() {
    stdout.write("\nApakah anda ingin mengkonfirmasi pembelian? (Y/N) : ");
    String? konfirm = stdin.readLineSync();
    if (konfirm == null || konfirm.isEmpty || konfirm.toLowerCase() != 'y') {
      return;
    }

    stdout.write("\nMasukkan Nama Kasir : ");
    String? namaKasir = stdin.readLineSync();
    if (namaKasir == null || namaKasir.isEmpty) {
      return;
    }

    List<KeranjangItem> items = List.from(keranjangManager.item);

    for (var item in items) {
      produkManager.stok(item.produk.nama, item.jumlah);
    }

    DateTime tanggal = DateTime.now();

    int id = _daftarTransaksi.length + 1;
    Transaksi transaksi = Transaksi(idTransaksi: id, tanggal: tanggal, items: items);

    Kasir? kasir = _daftarKasir.firstWhere(
      (k) => k.nama.toLowerCase() == namaKasir.toLowerCase(),
      orElse: () => Kasir(nama: namaKasir, daftarTransaksi: []),
    );

    if (!_daftarKasir.contains(kasir)) {
      _daftarKasir.add(kasir);
    }

    kasir.daftarTransaksi.add(transaksi);
    _daftarTransaksi.add(transaksi);

    keranjangManager.deleteAll();

    kasir.showTransaksi(transaksi);
    stdin.readLineSync();
  }


  void showAllTransaksi() {
    if (_daftarTransaksi.isEmpty) {
      print("\nBelum ada transaksi yang dilakukan.\n");
      return;
    }

    for (var transaksi in _daftarTransaksi) {
      Kasir? kasir = _daftarKasir.firstWhere(
        (k) => k.daftarTransaksi.contains(transaksi),
        orElse: () => Kasir(nama: 'Tidak Diketahui', daftarTransaksi: [])
      );
      kasir.showAllTransaksi();
    }
  }

  void pilihTransaksiBerdasarkanKasir() {
    stdout.write("\nMasukkan Nama Kasir untuk melihat transaksi: ");
    String? namaKasir = stdin.readLineSync();

    if (namaKasir == null || namaKasir.isEmpty) {
      print("\n     == Nama Kasir tidak boleh kosong! ==\n");
      return;
    }

    // Cari kasir dengan nama yang sesuai
    var kasir = _daftarKasir.firstWhere(
      (k) => k.nama.toLowerCase() == namaKasir.toLowerCase(),
      orElse: () => Kasir(nama: '', daftarTransaksi: []),
    );

    if (kasir.nama.isEmpty) {
      print("\n     Kasir dengan nama '$namaKasir' tidak ditemukan.\n");
      return;
    }

    print("\nTransaksi yang dilakukan oleh Kasir ${kasir.nama}:");
    kasir.showAllTransaksi();
  }
}
