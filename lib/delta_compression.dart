String compressDelta(String input) {
  if (input.isEmpty) return '';

  List<String> outputList = [];

  outputList.add(letterToAsciiBinary(input[0]));

  for (int i = 1; i < input.length; i++) {
    var diff = input[i].codeUnitAt(0) - input[i - 1].codeUnitAt(0);
    var binary = diff.abs().toRadixString(2);
    if (diff < 0) {
      outputList.add("1${twosComplement(binary)}");
    } else {
      outputList.add("0$binary");
    }
  }

  int maxLength = outputList
      .sublist(1)
      .map((s) => s.length)
      .reduce((a, b) => a > b ? a : b);

  for (int i = 1; i < outputList.length; i++) {
    if (outputList[i][0] == '1') {
      outputList[i] =
          "1${outputList[i].substring(1).padLeft(maxLength - 1, '0')}";
    } else {
      outputList[i] = outputList[i].padLeft(maxLength, '0');
    }
  }

  return outputList.join();
}

String letterToAsciiBinary(String letter) {
  if (letter.length != 1) {
    throw ArgumentError('Input must be a single character');
  }

  int asciiValue = letter.codeUnitAt(0);
  return asciiValue.toRadixString(2).padLeft(8, '0');
}

String twosComplement(String binary) {
  String inverted =
      binary.split('').map((bit) => bit == '0' ? '1' : '0').join();
  int twosCompInt = int.parse(inverted, radix: 2) + 1;
  return twosCompInt.toRadixString(2);
}
