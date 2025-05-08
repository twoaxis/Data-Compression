String compress_delta(String input) {

    List<String> outputList = [];

    outputList.add(letterToAsciiBinary(input[0]));

    for(int i = 1; i < input.length; i++) {
      var diff = input[i].codeUnitAt(0) - input[i-1].codeUnitAt(0);
      print(input[i].codeUnitAt(0).toString() + "-" + input[i-1].codeUnitAt(0).toString() + " = " + diff.toString());
      var binary = diff.toRadixString(2);
      if(diff < 0) {
        outputList.add("1${twosComplement(binary)}");
      }
      else {
        outputList.add("0$binary");
      }
    }

    int maxLength = outputList.sublist(1).map((s) => s.length).reduce((a, b) => a > b ? a : b);

    for(int i = 1; i < input.length; i++) {
      if(outputList[i][0] == '1') {
        var fuckingNumber = outputList[i].substring(1).padLeft(maxLength - 1, '0');
        outputList[i] = "1$fuckingNumber";
      }
      else {
        outputList[i] = outputList[i].padLeft(maxLength, '0');
      }
    }

    return outputList.join();
}

String letterToAsciiBinary(String letter) {
  if (letter.length != 1) {
    throw ArgumentError('Input must be a single character');
  }

  int asciiValue = letter.codeUnitAt(0); // Get ASCII value
  String binary = asciiValue.toRadixString(2).padLeft(8, '0'); // Convert to 8-bit binary
  return binary;
}
String twosComplement(String binary) {
  // Step 1: Invert the bits
  String inverted = binary.split('').map((bit) => bit == '0' ? '1' : '0').join();

  // Step 2: Convert to int, add 1
  int twosCompInt = int.parse(inverted, radix: 2) + 1;

  // Step 3: Convert back to binary (preserve length of original input)
  String result = twosCompInt.toRadixString(2);

  return result;
}
