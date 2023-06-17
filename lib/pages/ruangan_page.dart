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

  Color backgroundColor = const Color(0xFFf7ebe1);
  Color appBarColor = const Color(0xff132137);

  Future _getData() async {
    try {
      final response = await http.get(
          Uri.parse('https://10.0.2.2/api_inventaris/ruangan_read.php'));

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
        backgroundColor: appBarColor,
        title: const Text('Ruangan'),
      ),
      backgroundColor: backgroundColor,
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
                                _editRuangan(daftarRuangan[daftarRuangan.indexOf(ruangan)]['id'].toString());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _hapusRuangan(daftarRuangan[daftarRuangan.indexOf(ruangan)]['id'].toString());
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
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
          ],
        ),
      ),
    );
  }

  void _tambahRuangan() {
    TextEditingController nama_ruangan = TextEditingController();

    Future _add() async {
      final response = await http.post(
          Uri.parse('https://10.0.2.2/api_inventaris/create_ruang.php'),
          body: {
            "nama_ruangan" : nama_ruangan.text.toString(),
          });

      if (response.statusCode == 200) {
        print("Sukses");
        return true;
      }
      print("Gagal");
      return false;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Ruangan'),
          content: TextField(
            controller: nama_ruangan,
            decoration: const InputDecoration(hintText: 'Nama Ruangan'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _add().then((value) {
                  if(value) {
                    print("Sukses");
                  } else {
                    SnackBar(
                      content: const Text("Data Gagal di Tambahkan"),
                    );
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Tambah'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
          ],
        );
      },
    );
  }

  void _editRuangan(String id) {
    TextEditingController namaRuangan = TextEditingController();
    String idR = id;

    Future _edit() async {
      final response = await http.post(
          Uri.parse('https://10.0.2.2/api_inventaris/edit_ruang.php'),
          body: {
            "id" : idR,
            "nama_ruangan" : namaRuangan.text.toString(),
          });

      if (response.statusCode == 200) {
        print("Sukses");
        return true;
      }
      print("Gagal");
      return false;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Ruangan"),
          content: TextField(
            controller: namaRuangan,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Nama Ruangan',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _edit().then((value) {
                  if(value) {
                    print("Sukses");
                  } else {
                    print("Gagal");
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
          ],
        );
      },
    );
  }

  void _hapusRuangan(String id) {
    String idR = id;

    Future _delete() async {
      final response = await http.post(
          Uri.parse('https://10.0.2.2/api_inventaris/hapus_ruang.php'),
          body: {
            "id" : idR,
          });

      if (response.statusCode == 200) {
        print("Sukses");
        return true;
      } else {

      }
      print("Gagal");
      return false;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Ruangan'),
          content: const Text('Apakah Anda yakin ingin menghapus ruangan ini?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _delete().then((value) {
                  if(value) {
                    print("Sukses");
                  } else {
                    print("Gagal");
                  }

                });
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
          ],
        );
      },
    );
  }
}
