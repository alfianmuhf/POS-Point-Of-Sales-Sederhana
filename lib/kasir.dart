import 'transaksi.dart';

class Kasir {
  final String nama;
  final List<Transaksi> daftarTransaksi;

  Kasir({required this.nama, required this.daftarTransaksi});

  void showTransaksi(Transaksi transaksi) {
    if (daftarTransaksi.isEmpty) {
      print("\nBelum ada transaksi yang dilakukan.\n");
      return;
    }

    print("     ================== Transaksi ID: ${transaksi.idTransaksi} ==================");
    print("     ========================================================");
    print("    | Nama Produk                         | Jumlah |  Harga  |");
    print("     --------------------------------------------------------");
    for (var item in transaksi.items) {
      print(
          "    | ${item.produk.nama.toString().padRight(35)} |   ${item.jumlah.toString().padRight(3)}  | ${item.produk.harga.toString().padRight(7)} |");
    }
    int totalHarga = transaksi.items.fold(0, (sum, item) => sum + (item.produk.harga * item.jumlah));
    print("     ========================================================");
    print("    | Total Harga                         |  Rp.${totalHarga.toString().padRight(11)}  |");
    print("     ========================================================");
    print("    | Tanggal : ${transaksi.tanggal.toString().padRight(15)} | Kasir : ${nama.toString().padRight(7)} |");
    print("     ========================================================\n\n\n");
  }

  void showAllTransaksi() {
    if (daftarTransaksi.isEmpty) {
      print("\nBelum ada transaksi yang dilakukan oleh $nama.\n");
      return;
    }

    for (var transaksi in daftarTransaksi) {
      showTransaksi(transaksi);
    }
  }
}