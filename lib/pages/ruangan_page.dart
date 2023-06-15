import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RuanganPage extends StatefulWidget {
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
        title: Text('Ruangan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Ruangan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (daftarRuangan.isEmpty)
              Text('Ruangan masih kosong')
            else
              Column(
                children: daftarRuangan
                    .map(
                      (ruangan) => ListTile(
                        title: Text(ruangan),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editRuangan(ruangan);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _tambahRuangan();
              },
              child: Text('Tambah Ruangan'),
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
          title: Text('Tambah Ruangan'),
          content: TextField(
            onChanged: (value) {
              namaRuangan = value;
            },
            decoration: InputDecoration(hintText: 'Nama Ruangan'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  daftarRuangan.add(namaRuangan);
                });
                Navigator.pop(context);
              },
              child: Text('Tambah'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
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
          title: Text('Edit Ruangan'),
          content: TextField(
            onChanged: (value) {
              namaRuangan = value;
            },
            decoration: InputDecoration(hintText: 'Nama Ruangan'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  daftarRuangan[daftarRuangan.indexOf(ruangan)] = namaRuangan;
                });
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
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
          title: Text('Hapus Ruangan'),
          content: Text('Apakah Anda yakin ingin menghapus ruangan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  daftarRuangan.remove(ruangan);
                });
                Navigator.pop(context);
              },
              child: Text('Hapus'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
