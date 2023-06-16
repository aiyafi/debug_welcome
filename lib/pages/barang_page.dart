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

  Color backgroundColor = const Color(0xFFf7ebe1);
  Color appBarColor = const Color(0xff132137);

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
        backgroundColor: appBarColor,
      ),
      backgroundColor: backgroundColor,
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
                        title: Text(barang['nama_barang'] + " (${barang['nama_ruangan']})"),
                        subtitle: Text('Jumlah: ${barang['jumlah_barang']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editBarang(barang['id']);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _hapusBarang(barang['id']);
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
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
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
        TextEditingController namaBarang = TextEditingController();
        TextEditingController jumlahBarang = TextEditingController();
        TextEditingController deskripsiBarang = TextEditingController();
        String kondisiBarang = 'Layak';
        int? lokasiRuangan;
        List<int> listRuangan = [];

        for (var i=0; i<daftarRuangan.length;i++) {
          listRuangan.add(int.parse(daftarRuangan[i]['id']));
        }

        Future _add() async {
          final response = await http.post(
            Uri.parse('https://192.168.1.7/api_inventaris/create.php'),
            body: {
              "id_ruang" : lokasiRuangan.toString(),
              "nama_barang" : namaBarang.text.toString(),
              "jumlah_barang" : jumlahBarang.text.toString(),
              "deskripsi_barang" : deskripsiBarang.text.toString(),
              "kondisi_barang" : kondisiBarang.toString(),
              "image_url" : ""
            });

          if (response.statusCode == 200) {
            print("Sukses");
            return true;
          }
          print("Gagal");
          return false;
        }



        return AlertDialog(
          title: const Text('Tambah Barang'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: namaBarang,
                  decoration: const InputDecoration(hintText: 'Nama Barang'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: jumlahBarang,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Jumlah Barang'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: deskripsiBarang,
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
                DropdownButton<int>(
                  items: listRuangan.map((int option) {
                    return DropdownMenuItem<int>(
                      value: option,
                      child: Text(option.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    lokasiRuangan = value!;
                  },
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
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
            ElevatedButton(
              onPressed: () {
                _add().then((value) {
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
          ],
        );
      },
    );
  }

  void _editBarang(String id) {
    String idB = id;
    TextEditingController namaBarang = TextEditingController();
    TextEditingController jumlahBarang = TextEditingController();
    TextEditingController deskripsiBarang = TextEditingController();
    String kondisiBarang = 'Layak';
    int? lokasiRuangan;
    List<int> listRuangan = [];

    for (var i=0; i<daftarRuangan.length;i++) {
      listRuangan.add(int.parse(daftarRuangan[i]['id']));
    }

    Future _edit() async {
      final response = await http.post(
          Uri.parse('https://192.168.1.7/api_inventaris/edit_barang.php'),
          body: {
            "id" : idB,
            "id_ruang" : lokasiRuangan.toString(),
            "nama_barang" : namaBarang.text.toString(),
            "jumlah_barang" : jumlahBarang.text.toString(),
            "deskripsi_barang" : deskripsiBarang.text.toString(),
            "kondisi_barang" : kondisiBarang.toString(),
            "image_url" : ""
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
          title: const Text('Edit Barang'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: namaBarang,
                  decoration: const InputDecoration(hintText: 'Nama Barang'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: jumlahBarang,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Jumlah Barang'),
                ),
                const SizedBox(height: 8),
                TextField(
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
                DropdownButton<int>(
                  items: listRuangan.map((int option) {
                    return DropdownMenuItem<int>(
                      value: option,
                      child: Text(option.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    lokasiRuangan = value!;
                  },
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
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
            ElevatedButton(
              onPressed: () {
                _edit().then((value) {
                  if(value) {
                    print("sukses");
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
          ],
        );
      },
    );
  }

  void _hapusBarang(String id) {
    String idB = id;

    Future _delete() async {
      final response = await http.post(
          Uri.parse('https://192.168.1.7/api_inventaris/hapus_barang.php'),
          body: {
            "id" : idB,
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
          title: const Text('Hapus Barang'),
          content: const Text('Apakah Anda yakin ingin menghapus barang ini?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
            ElevatedButton(
              onPressed: () {
                _delete().then((value) {
                  if(value) {
                    print("SUkses");
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
            ),
          ],
        );
      },
    );
  }
}
