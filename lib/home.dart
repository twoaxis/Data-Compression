import 'package:data_compression/screens/compression.dart';
import 'package:data_compression/screens/decompression.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  static List<String> screens = ["Delta Compression", "Delta Decompression"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[selectedIndex]),
        backgroundColor: const Color(0xffA72222),
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [CompressionScreen(), DecompressionScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.compress),
            label: "Compression",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.unarchive),
            label: "Decompression",
          ),
        ],
        onTap: (index) => setState(() => selectedIndex = index),
      ),
    );
  }
}
