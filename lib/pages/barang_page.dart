import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  _BarangPageState createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  List daftarBarang = [];
  List daftarRuangan = [];

  Future _getRuangan() async {
    try {
      final response = await http.get(
          Uri.parse('https://192.168.1.7/api_inventaris/ruangan_read.php'));

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          daftarRuangan = data;
        });
      }
    } catch (e) {
      // print("Coba");
      print(e);
    }
  }

  Future _getData() async {
    try {
      final response = await http
          .get(Uri.parse('https://192.168.1.7/api_inventaris/getdata.php'));

      if (response.statusCode == 200) {
        // print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          daftarBarang = data;
        });
      }
    } catch (e) {
      // print("Coba");
      print(e);
    }
  }

  @override
  void initState() {
    _getRuangan();
    _getData();
    print(daftarRuangan);
    // print(daftarBarang.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Barang:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (daftarBarang.isEmpty)
              const Text('Barang masih kosong')
            else
              Column(
                children: daftarBarang
                    .map(
                      (barang) => ListTile(
                        title: Text(barang['nama_barang']),
                        subtitle: Text('Jumlah: ${barang['jumlah_barang']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editBarang(barang);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _hapusBarang(barang);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _tambahBarang();
              },
              child: const Text('Tambah Barang'),
            ),
          ],
        ),
      ),
    );
  }

  void _tambahBarang() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String namaBarang = '';
        int jumlahBarang = 0;
        String deskripsiBarang = '';
        String kondisiBarang = 'Layak';
        String lokasiRuangan = '';

        return AlertDialog(
          title: const Text('Tambah Barang'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    namaBarang = value;
                  },
                  decoration: const InputDecoration(hintText: 'Nama Barang'),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    jumlahBarang = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Jumlah Barang'),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    deskripsiBarang = value;
                  },
                  decoration: const InputDecoration(hintText: 'Deskripsi Barang'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: kondisiBarang,
                  onChanged: (value) {
                    kondisiBarang = value!;
                  },
                  items: ['Layak', 'Tidak Layak']
                      .map((kondisi) => DropdownMenuItem<String>(
                            value: kondisi,
                            child: Text(kondisi),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                    hintText: 'Kondisi Barang',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    lokasiRuangan = value;
                  },
                  decoration: const InputDecoration(hintText: 'Lokasi Ruangan'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  daftarBarang.add({
                    'nama_barang': namaBarang,
                    'jumlah_barang': jumlahBarang,
                    'deskripsi_barang': deskripsiBarang,
                    'kondisi_barang': kondisiBarang,
                    'lokasi_ruangan': lokasiRuangan,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _editBarang(Map<String, dynamic> barang) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String namaBarang = barang['nama_barang'];
        int jumlahBarang = barang['jumlah_barang'];
        String deskripsiBarang = barang['deskripsi_barang'];
        String kondisiBarang = barang['kondisi_barang'];
        String lokasiRuangan = barang['lokasi_ruangan'];

        return AlertDialog(
          title: const Text('Edit Barang'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    namaBarang = value;
                  },
                  decoration: const InputDecoration(hintText: 'Nama Barang'),
                  controller: TextEditingController(text: namaBarang),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    jumlahBarang = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Jumlah Barang'),
                  controller:
                      TextEditingController(text: jumlahBarang.toString()),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    deskripsiBarang = value;
                  },
                  decoration: const InputDecoration(hintText: 'Deskripsi Barang'),
                  controller: TextEditingController(text: deskripsiBarang),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: kondisiBarang,
                  onChanged: (value) {
                    kondisiBarang = value!;
                  },
                  items: ['Layak', 'Tidak Layak']
                      .map((kondisi) => DropdownMenuItem<String>(
                            value: kondisi,
                            child: Text(kondisi),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                    hintText: 'Kondisi Barang',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    lokasiRuangan = value;
                  },
                  decoration: const InputDecoration(hintText: 'Lokasi Ruangan'),
                  controller: TextEditingController(text: lokasiRuangan),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  barang['nama_barang'] = namaBarang;
                  barang['jumlah_barang'] = jumlahBarang;
                  barang['deskripsi_barang'] = deskripsiBarang;
                  barang['kondisi_barang'] = kondisiBarang;
                  barang['lokasi_ruangan'] = lokasiRuangan;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _hapusBarang(Map<String, dynamic> barang) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Barang'),
          content: const Text('Apakah Anda yakin ingin menghapus barang ini?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  daftarBarang.remove(barang);
                });
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
