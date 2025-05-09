import 'package:flutter/material.dart';
import 'package:data_compression/delta_compression.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _inputController = TextEditingController();

  bool _isProcessed = false;
  int _originalSize = 0;
  int _compressedSize = 0;
  String _compressedData = '';

  void _compressText() {
    String input = _inputController.text;
    if (input.isEmpty) return;

    String compressed = compressDelta(input);

    setState(() {
      _isProcessed = true;
      _compressedData = compressed;
      _originalSize = input.length * 8; // 8 bits per ASCII character
      _compressedSize = compressed.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delta Compression'),
        backgroundColor: const Color(0xffA72222),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter text to compress:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 500,
                height: 150,
                child: TextField(
                  controller: _inputController,
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
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _compressText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffA72222),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Compress Text'),
                ),
              ),
              if (_isProcessed) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                const Text(
                  'Compression Results:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: _originalSize,
                        child: Container(
                          height: 30,
                          color: Color(0xffA72222),
                          alignment: Alignment.center,
                          child: Text(
                            'Original: $_originalSize bits',
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: _compressedSize,
                        child: Container(
                          height: 30,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Text(
                            'Compressed: $_compressedSize bits',
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Space Saved: ${_originalSize - _compressedSize} bits',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Compressed Binary Output:',
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
                  child: Text(
                    _compressedData,
                    style: const TextStyle(color: Color(0xff161616)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
