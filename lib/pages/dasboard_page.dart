import 'package:flutter/material.dart';
import 'barang_page.dart';
import 'ruangan_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Barang'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BarangPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.room),
            title: const Text('Ruangan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RuanganPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
