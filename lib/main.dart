import 'package:data_compression/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DeltaCompression());
}

class DeltaCompression extends StatelessWidget {
  const DeltaCompression({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delta Coding',
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
