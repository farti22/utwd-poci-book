import 'package:flutter_poci_book/helpers/pair.dart';
import 'package:flutter_poci_book/helpers/math.dart';
// for testing
/// if used more than 1 задача then create ext_math.dart file

class EncryptionTable {
  Pair<int, int> keys = Pair(0, 0);
  List<Pair<int, int>> availableKeys = [];

  void selectKeys(int index) {
    keys = availableKeys[index];
  }

  void setAvailableKeys(int value) {
    List<Pair<int, int>> dividers = [];
    for (int i = 2; i < value ~/ i; i++) {
      if (value % i == 0) {
        //print('${i} | ${value ~/ i}');
        dividers.add(Pair(i, value ~/ i));
      }
    }
    availableKeys = dividers;
  }

  String encrypt(String str) {
    assert(keys.first == 0 && keys.second == 0, "Keys not select");

    var matrix = List.generate(keys.first, (i) => List.filled(keys.second, ''),
        growable: false);

    for (int i = 0; i < matrix[0].length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        matrix[j][i] = str[(i * matrix.length) + j];
      }
    }
    return matrixToString(matrix);
  }

  String decrypt(String str, Pair<int, int> keys) {
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

void main() {
  String str1 =
      "Привет я из будущего, как ты, все хорошо? Ты уже и забыл что такое ЗКИ. Знаю, это нормально.";
  String str2 =
      "Не забываешь ли ты, в чем истинная сила? Истинная сила в небольшой груди!!! =^~^=";

  var enTable = EncryptionTable();
  enTable.setAvailableKeys(str1.length);
  enTable.selectKeys(1);
  String crStr = enTable.encrypt(str1);
  String deStr = enTable.decrypt(crStr, Pair(4, 23));
  print(crStr);
  print(deStr);
  //print(str2.length);
  //print(primeList(107));
}
