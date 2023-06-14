import 'package:flutter/material.dart';

class BarangPage extends StatefulWidget {
  @override
  _BarangPageState createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  List<Map<String, dynamic>> daftarBarang = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Barang:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (daftarBarang.isEmpty)
              Text('Barang masih kosong')
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
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editBarang(barang);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _tambahBarang();
              },
              child: Text('Tambah Barang'),
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
          title: Text('Tambah Barang'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    namaBarang = value;
                  },
                  decoration: InputDecoration(hintText: 'Nama Barang'),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    jumlahBarang = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Jumlah Barang'),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    deskripsiBarang = value;
                  },
                  decoration: InputDecoration(hintText: 'Deskripsi Barang'),
                ),
                SizedBox(height: 8),
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
                  decoration: InputDecoration(
                    hintText: 'Kondisi Barang',
                    isDense: true,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    lokasiRuangan = value;
                  },
                  decoration: InputDecoration(hintText: 'Lokasi Ruangan'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
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
              child: Text('Simpan'),
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
          title: Text('Edit Barang'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    namaBarang = value;
                  },
                  decoration: InputDecoration(hintText: 'Nama Barang'),
                  controller: TextEditingController(text: namaBarang),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    jumlahBarang = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Jumlah Barang'),
                  controller:
                      TextEditingController(text: jumlahBarang.toString()),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    deskripsiBarang = value;
                  },
                  decoration: InputDecoration(hintText: 'Deskripsi Barang'),
                  controller: TextEditingController(text: deskripsiBarang),
                ),
                SizedBox(height: 8),
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
                  decoration: InputDecoration(
                    hintText: 'Kondisi Barang',
                    isDense: true,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    lokasiRuangan = value;
                  },
                  decoration: InputDecoration(hintText: 'Lokasi Ruangan'),
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
              child: Text('Batal'),
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
              child: Text('Simpan'),
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
          title: Text('Hapus Barang'),
          content: Text('Apakah Anda yakin ingin menghapus barang ini?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  daftarBarang.remove(barang);
                });
                Navigator.pop(context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
