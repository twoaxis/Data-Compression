import 'package:data_compression/delta_compression/decompression.dart';
import 'package:flutter/material.dart';

class DecompressionScreen extends StatefulWidget {
  const DecompressionScreen({super.key});

  @override
  State<DecompressionScreen> createState() => _DecompressionScreenState();
}

class _DecompressionScreenState extends State<DecompressionScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController bitsController = TextEditingController();

  bool _isProcessed = false;
  late String decompressedData;

  void decompressText() {
    String input = textController.text.trim();
    String bitWidthStr = bitsController.text.trim();

    if (input.isEmpty || bitWidthStr.isEmpty) return;

    try {
      int bitWidth = int.parse(bitWidthStr);
      String decompressed = decompressDelta(input, bitWidth);

      setState(() {
        _isProcessed = true;
        decompressedData = decompressed; // ✅ Just assign directly
      });
    } catch (e) {
      // Optional: handle invalid input
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter code to decompress:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 500,
              height: 150,
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Type your text here...',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff252525)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: const Color(0xff161616),
                ),
                minLines: 3,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Text(
              'Enter bit width:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              height: 90,
              child: TextField(
                controller: bitsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Type the bit width here...',
                  hintStyle: const TextStyle(fontSize: 13),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff252525)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: const Color(0xff161616),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: decompressText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffA72222),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text('deCompress Code'),
              ),
            ),
            if (_isProcessed) ...[
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              const SelectableText(
                'Decompressed String:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  decompressedData,
                  style: const TextStyle(color: Color(0xff161616)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
