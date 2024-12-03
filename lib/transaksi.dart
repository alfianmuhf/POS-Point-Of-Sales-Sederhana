import 'keranjang_item.dart';

class Transaksi {
  final int idTransaksi;
  final DateTime tanggal;
  final List<KeranjangItem> items;

  Transaksi({required this.idTransaksi, required this.tanggal, required this.items});
}
