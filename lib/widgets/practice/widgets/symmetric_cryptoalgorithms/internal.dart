import 'package:flutter_poci_book/helpers/math.dart';
import 'package:flutter_poci_book/helpers/pair.dart';

class DoubleSwapEncryption {
  List<int> keyRow = [];
  List<int> keyColumn = [];
  int _size = 4;

  void setSize(int size) {
    _size = size;
  }

  void setKeys(List<int> row, List<int> column) {
    keyRow = row;
    keyColumn = column;
  }

  String encrypt(String text) {
    var matrix =
        List.generate(_size, (i) => List.filled(_size, ''), growable: false);

    int k = 0;
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        if (k >= text.length) {
          matrix[i][j] = " ";
        } else {
          matrix[i][j] = text[k++];
        }
      }
    }

    var tempRow = List.from(keyRow);
    print(tempRow);
    matrix.forEach((arr) => print(arr));
    bool swap;
    do {
      swap = false;
      for (int i = 1; i < _size; i++) {
        if (tempRow[i - 1].compareTo(tempRow[i]) > 0) {
          swap = true;
          //swap
          var temp = tempRow[i - 1];
          tempRow[i - 1] = tempRow[i];
          tempRow[i] = temp;

          //swap row
          for (int j = 0; j < _size; j++) {
            var temp = matrix[j][i - 1];
            matrix[j][i - 1] = matrix[j][i];
            matrix[j][i] = temp;
          }
        }
      }
    } while (swap);

    print(tempRow);
    matrix.forEach((arr) => print(arr));

    var tempColumn = List.from(keyColumn);
    print(tempColumn);
    matrix.forEach((arr) => print(arr));
    do {
      swap = false;
      for (int i = 1; i < _size; i++) {
        if (tempColumn[i - 1].compareTo(tempColumn[i]) > 0) {
          swap = true;
          //swap
          var temp = tempColumn[i - 1];
          tempColumn[i - 1] = tempColumn[i];
          tempColumn[i] = temp;

          //swap column
          for (int j = 0; j < _size; j++) {
            var temp = matrix[i - 1][j];
            matrix[i - 1][j] = matrix[i][j];
            matrix[i][j] = temp;
          }
          //print("${tempColumn[i]} | ${matrix[i]}");
        }
      }
    } while (swap);
    print(tempColumn);
    print(keyColumn);
    matrix.forEach((arr) => print(arr));
    print(matrix);

    //return matrixToString(matrix);
    return matrixToString(matrix);
  }

  String decrypt(String text) {
    var matrix =
        List.generate(_size, (i) => List.filled(_size, ''), growable: false);

    int k = 0;
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        matrix[i][j] = text[k++];
      }
    }
    // Column decrypt
    var tempMatrix = List.from(matrix);
    print(keyColumn);
    for (int i = 0; i < _size; i++) {
      matrix[i] = tempMatrix[keyColumn[i] - 1];
    }

    matrix.forEach((v) => print(v));
    var transp = matrixTransp(matrix);
    print("\n");
    tempMatrix = List.from(transp);
    transp.forEach((v) => print(v));
    // Row decrypt
    for (int i = 0; i < _size; i++) {
      transp[i] = tempMatrix[keyRow[i] - 1];
    }
    transp.forEach((v) => print(v));
    matrix = matrixTransp(transp);
    matrix.forEach((v) => print(v));
    return matrixToString(matrix);
  }
}

Pair<int, int> getPos(String char, var map) {
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map.length; j++) {
      if (map[i][j] == char) {
        return Pair(i + 1, j + 1);
      }
    }
  }
  return Pair(0, 0);
}

class BasePolybeyEncryption {
  // Вынести в класс, или в суперкласс
  static const alphMap = [
    ["A", "B", "C", "D", "E"],
    ["F", "G", "H", "I", "K"],
    ["L", "M", "N", "O", "P"],
    ["Q", "R", "S", "T", "U"],
    ["V", "W", "X", "Y", "Z"]
  ];

//
  String encrypt(String text) {
    List<int> listX = [];
    List<int> listY = [];
    for (var char in text.split("")) {
      var pos = getPos(char, alphMap);
      listX.add(pos.second);
      listY.add(pos.first);
    }
    //

    //temp x+y line
    var posLine = listX + listY;
    print(text);
    print(listX);
    print(listY);
    var temp = "";
    for (int i = 1; i < posLine.length; i += 2) {
      int x = posLine[i] - 1;
      int y = posLine[i - 1] - 1;
      temp += alphMap[x][y];
    }
    print(temp);
    return temp;
  }

  String decrypt(String text) {
    print("Dec");
    List<int> listX = [];
    List<int> listY = [];

    int index = 0;
    for (var char in text.split("")) {
      var pos = getPos(char, alphMap);

      if (index++ >= text.length ~/ 2) {
        listX.add(pos.second);
        listX.add(pos.first);
      } else {
        listY.add(pos.second);
        listY.add(pos.first);
      }
    }
    var temp = "";
    for (int i = 0; i < listX.length; i++) {
      int x = listX[i] - 1;
      int y = listY[i] - 1;
      temp += alphMap[x][y];
    }
    return temp;
  }
}

class ComplicatePolybeyEncryption {
  static const alphMap = [
    ["A", "B", "C", "D", "E"],
    ["F", "G", "H", "I", "K"],
    ["L", "M", "N", "O", "P"],
    ["Q", "R", "S", "T", "U"],
    ["V", "W", "X", "Y", "Z"]
  ];

  String encrypt(String text, int shift) {
    List<int> listX = [];
    List<int> listY = [];
    for (var char in text.split("")) {
      var pos = getPos(char, alphMap);
      listX.add(pos.second);
      listY.add(pos.first);
    }
    //

    //temp x+y line
    var posLine = listX + listY;
    //Сдвиг листа
    print(posLine);
    print("shift");
    for (int i = 0; i < shift; i++) {
      posLine = List.from(posLine.reversed);
      var temp = posLine.removeLast();
      posLine = List.from(posLine.reversed);
      posLine.add(temp);
    }

    print(posLine);
    var temp = "";
    for (int i = 1; i < posLine.length; i += 2) {
      int x = posLine[i] - 1;
      int y = posLine[i - 1] - 1;
      temp += alphMap[x][y];
    }
    print(temp);
    return temp;
  }

  String decrypt(String text, int shift) {
    print("Dec");
    List<int> listX = [];
    List<int> listY = [];
    List<int> posLine = [];

    int index = 0;
    //recreate index
    for (var char in text.split("")) {
      var pos = getPos(char, alphMap);
      if (index++ >= text.length ~/ 2) {
        listY.add(pos.second);
        listY.add(pos.first);
      } else {
        listX.add(pos.second);
        listX.add(pos.first);
      }
    }
    posLine = listX + listY;
    print(posLine);
    print("shift");
    for (int i = 0; i < shift; i++) {
      var temp = posLine.removeLast();
      posLine = List.from(posLine.reversed);
      posLine.add(temp);
      posLine = List.from(posLine.reversed);
      print(posLine);
    }

    index = 0;
    listX = [];
    listY = [];
    for (var pos in posLine) {
      if (index++ >= posLine.length ~/ 2) {
        listX.add(pos);
      } else {
        listY.add(pos);
      }
    }
    var temp = "";
    for (int i = 0; i < listX.length; i++) {
      int x = listX[i] - 1;
      int y = listY[i] - 1;
      temp += alphMap[x][y];
    }
    print(temp);
    return temp;
  }
}

class PolybetWithKeyEncryption {
  List<List<String>> _genAlhpMap(String key) {
    var keyList = key.split('').toSet().toList();
    var alph = "ABCDEFGHIKLMNOPQRSTUVWXYZ".split('');
    var map = List.generate(5, (index) => List.filled(5, ""));

    int k = 0;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++, k++) {
        if (keyList.length > k) {
          if (alph.contains(keyList[k])) {
            map[i][j] = keyList[k];
            alph.remove(keyList[k]);
          }
        } else {
          map[i][j] = alph[0];
          alph.removeAt(0);
        }
      }
    }
    map.forEach((element) => print(element));
    return map;
  }

  String encrypt(String text, String key) {
    var alphMap = _genAlhpMap(key);
    List<int> listX = [];
    List<int> listY = [];
    for (var char in text.split("")) {
      var pos = getPos(char, alphMap);
      listX.add(pos.second);
      listY.add(pos.first);
    }
    //

    //temp x+y line
    var posLine = listX + listY;
    print(text);
    print(listX);
    print(listY);
    var temp = "";
    for (int i = 1; i < posLine.length; i += 2) {
      int x = posLine[i] - 1;
      int y = posLine[i - 1] - 1;
      temp += alphMap[x][y];
    }
    print(temp);
    return temp;
  }

  String decrypt(String text, String key) {
    var alphMap = _genAlhpMap(key);
    print("Dec");
    List<int> listX = [];
    List<int> listY = [];

    int index = 0;
    for (var char in text.split("")) {
      var pos = getPos(char, alphMap);

      if (index++ >= text.length ~/ 2) {
        listX.add(pos.second);
        listX.add(pos.first);
      } else {
        listY.add(pos.second);
        listY.add(pos.first);
      }
    }
    var temp = "";
    for (int i = 0; i < listX.length; i++) {
      int x = listX[i] - 1;
      int y = listY[i] - 1;
      temp += alphMap[x][y];
    }
    print(temp);
    return temp;
  }
}

void main() {
  // Task 1
  var dse = DoubleSwapEncryption();
  dse.setSize(6);
  dse.setKeys([4, 2, 1, 3, 5, 6], [2, 5, 6, 1, 3, 4]);
  print(dse.encrypt("двойная перестановка") + "]");
  print(dse.decrypt(" а к  овйдна            п еяреатнсов"));
  print("test");

  // Task 2
  // Method 1
  // var bpe = BasePolybeyEncryption();
  // bpe.encrypt("SOMETEXT");
  // bpe.decrypt("SWYSOCDU");
  // // Method 2
  // var cpe = ComplicatePolybeyEncryption();
  // cpe.encrypt("SOMETEXT", 1);
  // cpe.decrypt("IUPTNQVO", 1);
  // // Method 3
  // var pwke = PolybetWithKeyEncryption();
  // pwke.encrypt("SOMETEXT", "DRAFT");
  // pwke.decrypt("FMNXSEBT", "DRAFT");
}
