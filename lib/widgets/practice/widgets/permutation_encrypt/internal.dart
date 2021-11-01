import 'package:flutter_poci_book/helpers/pair.dart';
import 'package:flutter_poci_book/helpers/math.dart';
// for testing
/// if used more than 1 задача then create ext_math.dart file

// refactor in future ^-^ || remove selectKeys || remove 2 arg in decrypt func
class EncryptionTable {
  Pair<int, int> keys = Pair(0, 0);
  List<Pair<int, int>> availableKeys = [Pair(0, 0)];

  bool checkEmptyKeys() {
    if (keys.first == 0 && keys.second == 0) return true;
    return false;
  }

  void setAvailableKeys(int value) {
    List<Pair<int, int>> dividers = [];
    for (int i = 2; i < value; i++) {
      print("i-$i");
      if (value % i == 0) {
        dividers.add(Pair(i, value ~/ i));
      }
    }
    if (dividers.isEmpty) {
      availableKeys = [Pair(0, 0)];
    } else {
      availableKeys = dividers;
    }
    print(availableKeys);
  }

  String encrypt(String str) {
    print(keys);

    var matrix = List.generate(keys.first, (i) => List.filled(keys.second, ''),
        growable: false);

    for (int i = 0; i < matrix[0].length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        matrix[j][i] = str[(i * matrix.length) + j];
      }
    }
    return matrixToString(matrix);
  }

  String decrypt(String str) {
    var matrix = List.generate(keys.second, (i) => List.filled(keys.first, ''),
        growable: false);

    for (int i = 0; i < keys.first; i++) {
      for (int j = 0; j < keys.second; j++) {
        //print(i + j * keys.second - j);
        matrix[j][i] = str[(i * matrix.length) + j];
      }
    }
    return matrixToString(matrix);
  }
}

class MagicSquare {
  static Map<int, dynamic> squares = {
    5: [
      [
        [21, 24, 2, 3, 15],
        [1, 6, 16, 22, 20],
        [14, 12, 19, 7, 13],
        [25, 5, 17, 10, 8],
        [4, 18, 11, 23, 9],
      ],
      [
        [2, 18, 1, 23, 21],
        [12, 25, 5, 4, 19],
        [16, 9, 15, 14, 11],
        [13, 3, 24, 17, 8],
        [22, 10, 20, 7, 6],
      ],
      [
        [4, 24, 10, 15, 12],
        [25, 13, 14, 6, 7],
        [3, 18, 22, 20, 2],
        [17, 9, 11, 5, 23],
        [16, 1, 8, 19, 21],
      ]
    ],
    6: [
      [
        [22, 36, 7, 2, 9, 35],
        [26, 18, 31, 10, 5, 21],
        [13, 23, 15, 24, 28, 8],
        [12, 4, 14, 34, 30, 17],
        [6, 1, 33, 25, 19, 27],
        [32, 29, 11, 16, 20, 3],
      ],
      [
        [18, 28, 3, 12, 15, 35],
        [32, 11, 14, 17, 4, 33],
        [20, 9, 24, 13, 16, 29],
        [21, 27, 10, 25, 23, 5],
        [1, 30, 34, 8, 31, 7],
        [19, 6, 26, 36, 22, 2],
      ],
      [
        [8, 10, 24, 4, 32, 33],
        [29, 20, 28, 21, 1, 12],
        [36, 5, 22, 14, 3, 31],
        [2, 27, 18, 30, 25, 9],
        [17, 26, 6, 35, 16, 11],
        [19, 23, 13, 7, 34, 15],
      ],
    ],
  };

  int size = 5;
  int key = 1;
  String encrypt(String str) {
    var enStr = "";
    // split to chunks
    var regex = RegExp(".{1,${size * size}}");
    Iterable<String> chunks = regex.allMatches(str).map((m) => m.group(0)!);

    for (var chunk in chunks) {
      var temp = chunk;
      if (chunk.length < size * size) {
        temp = chunk.padRight(size * size, " ");
      }

      var matrix =
          List.generate(size, (i) => List.filled(size, ''), growable: false);

      for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
          matrix[i][j] = temp[squares[size][key - 1][i][j] - 1];
        }
      }
      print(matrix);
      print("ENC: ${matrixToString(matrix)}");
      enStr += matrixToString(matrix);
    }
    print("Final ENC: ${enStr}");
    return enStr;
  }

  String decrypt(String str) {
    var deStr = "";
    // split to chunks
    var regex = RegExp(".{1,${size * size}}");
    Iterable<String> chunks = regex.allMatches(str).map((m) => m.group(0)!);

    for (var chunk in chunks) {
      var matrix =
          List.generate(size, (i) => List.filled(size, ''), growable: false);

      int k = 0;
      for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
          matrix[i][j] = chunk[k++];
        }
      }
      // Определение квадрата
      k = 0;
      var temp = List.filled(chunk.length, "0");
      for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
          temp[squares[size][key - 1][i][j] - 1] = matrix[i][j];
        }
      }

      print("DEC: ${temp.join('').trimRight()}");
      deStr += temp.join("").trimRight();
    }
    print("Final DEC: ${deStr}");
    return deStr;
  }

  void setSize(int size) {
    this.size = size;
  }

  void setKey(int key) {
    this.key = key;
  }
}

void main() {
  //Task 1
  // String str1 =
  //     "Привет я из будущего, как ты, все хорошо? Ты уже и забыл что такое ЗКИ. Знаю, это нормально.";
  // String str2 =
  //     "Не забываешь ли ты, в чем истинная сила? Истинная сила в небольшой груди!!! =^~^=";

  // var enTable = EncryptionTable();
  // enTable.setAvailableKeys(str1.length);
  // enTable.selectKeys(1);
  // String crStr = enTable.encrypt(str1);
  // String deStr = enTable.decrypt(crStr, Pair(4, 23));
  // print(crStr);
  // print(deStr);
  //print(str2.length);
  //print(primeList(107));

  //Task 2
  var ms = MagicSquare();
//  ms.selectSquareSize();
  String t2str1 =
      "Это строка для магического квадрата. С использованием частей которые нужно писать ручками и это странно";
  ms.setSize(5);
  ms.setKey(2);
  String enc = ms.encrypt(t2str1);
  ms.decrypt(enc);
  print(t2str1.length);
}
