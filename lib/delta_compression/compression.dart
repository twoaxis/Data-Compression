Map compressDelta(String input) {

  input = input.replaceAll(" ", "`");
  String output = "";
  output += letterToAsciiBinary(input[0]);

  List<Map<String, dynamic>> characters = [];

  int maxLength = 0;

  for (int i = 1; i < input.length; i++) {
    var diff = input[i].codeUnitAt(0) - input[i - 1].codeUnitAt(0);
    var binary = diff.abs().toRadixString(2);

    if (binary.length > maxLength) maxLength = binary.length;
    characters.add({"binary": binary, "negative": diff < 0});
  }

  for (int i = 0; i < characters.length; i++) {
    output += characters[i]["negative"] ? "1" : "0";
    output += characters[i]["binary"].padLeft(maxLength, "0");
  }

  return {"bitWidth": maxLength + 1, "output": output};
}

String letterToAsciiBinary(String letter) {
  int asciiValue = letter.codeUnitAt(0);
  return asciiValue.toRadixString(2).padLeft(8, '0');
}
