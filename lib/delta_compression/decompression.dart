String decompressDelta(String input, int bitWidth) {
  List<int> characterCodes = [int.parse(input.substring(0, 8), radix: 2)];
  String output = String.fromCharCode(characterCodes[0]);

  String characters = input.substring(8);
  List<String> bitCodes = [];

  for (int i = 0; i < characters.length; i += bitWidth) {
    bitCodes.add(characters.substring(i, i + bitWidth));
  }
  for (int i = 0; i < bitCodes.length; i++) {
    int code = characterCodes[i];

    if (bitCodes[i][0] == "1") {
      code -= int.parse(bitCodes[i].substring(1, bitWidth), radix: 2);
    } else {
      code += int.parse(bitCodes[i].substring(1, bitWidth), radix: 2);
    }
    characterCodes.add(code);
    output += String.fromCharCode(code);
  }

  return output;
}
