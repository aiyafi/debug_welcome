import 'package:flutter/material.dart';
import 'barang_page.dart';
import 'ruangan_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  final String user;

  const DashboardPage({
    // Key? key,
    super.key,
    required this.user
  });


  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EBE1),
      appBar: AppBar(
        backgroundColor: Color(0xFF132137),
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Log Out"),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF132137)),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BarangPage()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xff132137),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.inventory, size: 50.0, color: Colors.white),
                          SizedBox(height: 8),
                          Text('Barang', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RuanganPage()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xff132137),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.meeting_room_rounded, size: 50.0, color: Colors.white),
                          SizedBox(height: 8),
                          Text('Ruangan', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
