import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RuanganPage extends StatefulWidget {
  const RuanganPage({super.key});

  @override
  _RuanganPageState createState() => _RuanganPageState();
}

class _RuanganPageState extends State<RuanganPage> {
  List daftarRuangan = [];
  String selectedRuangan = '';

  Future _getData() async {
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

  @override
  void initState() {
    _getData();
    print(daftarRuangan);
    // print(daftarBarang.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Ruangan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (daftarRuangan.isEmpty)
              const Text('Ruangan masih kosong')
            else
              Column(
                children: daftarRuangan
                    .map(
                      (ruangan) => ListTile(
                        title: Text(
                            daftarRuangan[daftarRuangan.indexOf(ruangan)]
                                    ['nama_ruangan']
                                .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editRuangan(ruangan);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _hapusRuangan(ruangan);
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
                _tambahRuangan();
              },
              child: const Text('Tambah Ruangan'),
            ),
          ],
        ),
      ),
    );
  }

  void _tambahRuangan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String namaRuangan = '';
        return AlertDialog(
          title: const Text('Tambah Ruangan'),
          content: TextField(
            onChanged: (value) {
              namaRuangan = value;
            },
            decoration: const InputDecoration(hintText: 'Nama Ruangan'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  daftarRuangan.add(namaRuangan);
                });
                Navigator.pop(context);
              },
              child: const Text('Tambah'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _editRuangan(String ruangan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String namaRuangan = ruangan;
        return AlertDialog(
          title: const Text('Edit Ruangan'),
          content: TextField(
            onChanged: (value) {
              namaRuangan = value;
            },
            decoration: const InputDecoration(hintText: 'Nama Ruangan'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  daftarRuangan[daftarRuangan.indexOf(ruangan)] = namaRuangan;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _hapusRuangan(String ruangan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Ruangan'),
          content: const Text('Apakah Anda yakin ingin menghapus ruangan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  daftarRuangan.remove(ruangan);
                });
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
