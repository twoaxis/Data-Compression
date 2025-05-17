import 'dart:math';

Map<String, dynamic> compressDelta(String input) {
  input = input.replaceAll(" ", "`");
  String output = input[0].codeUnitAt(0).toRadixString(2).padLeft(8, '0');

  List<Map<String, dynamic>> characters = [];
  int maxLength = 0;

  for (int i = 1; i < input.length; i++) {
    int diff = input[i].codeUnitAt(0) - input[i - 1].codeUnitAt(0);
    String binary = diff.abs().toRadixString(2);
    if (binary.length > maxLength) maxLength = binary.length;
    characters.add({"binary": binary, "negative": diff < 0});
  }

  for (var char in characters) {
    output += char["negative"] ? '1' : '0';
    output += char["binary"].padLeft(maxLength, '0');
  }

  return {
    "output": output,
    "bitWidth": maxLength + 1,
  };
}
String encryptBinaryOutput(String binaryOutput, int seed) {
  final rng = Random(seed);
  final generatedKey = List.generate(binaryOutput.length, (_) => rng.nextInt(10));

  final encrypted = StringBuffer();
  for (int i = 0; i < binaryOutput.length; i++) {
    int keyDigit = generatedKey[i];
    String bit = binaryOutput[i];
    encrypted.write(keyDigit % 2 == 0 ? (bit == '1' ? '0' : '1') : bit);
  }

  return encrypted.toString();
}
