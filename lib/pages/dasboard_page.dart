import 'package:flutter/material.dart';
import 'barang_page.dart';
import 'ruangan_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Barang'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarangPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.room),
            title: Text('Ruangan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RuanganPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
