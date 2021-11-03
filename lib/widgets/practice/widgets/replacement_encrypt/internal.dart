import 'package:flutter_poci_book/helpers/pair.dart';

class CaesarSystem {
  static const alph = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";

  static String encrypt(String str, int factor) {
    String temp = "";
    print(factor);

    for (int i = 0; i < str.length; i++) {
      var index = alph.indexOf(str[i].toUpperCase());
      var ch = alph[(index + factor) % alph.length];
      temp += alph[index] == str[i] ? ch : ch.toLowerCase();
    }

    return temp;
  }

  static String decrypt(String str, int factor) {
    String temp = "";
    print(factor);

    for (int i = 0; i < str.length; i++) {
      var index = alph.indexOf(str[i].toUpperCase());
      var ch = alph[(index - factor) % alph.length];
      temp += alph[index] == str[i] ? ch : ch.toLowerCase();
    }

    return temp;
  }
}

class TrisemusSystem {
  static const alph = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ ,.";
  static String encrypt(String str, List keys) {
    String temp = "";

    for (int i = 0; i < str.length; i++) {
      var index = alph.indexOf(str[i].toUpperCase());
      int k = (keys[0] * i * i) + (keys[1] * i) + keys[2];

      temp += alph[(index + k) % alph.length];
    }

    return temp;
  }

  static String decrypt(String str, List keys) {
    String temp = "";

    for (int i = 0; i < str.length; i++) {
      var index = alph.indexOf(str[i].toUpperCase());
      int k = (keys[0] * i * i) + (keys[1] * i) + keys[2];

      temp += alph[(index - k) % alph.length];
    }

    return temp;
  }
}

class PlayfairAlgoritm {
  static const alph = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"; // removed Ё

  static List<List<String>> _initMatrix(key) {
    var keyList = key.toUpperCase().split('').toSet().toList();
    var avaiable = alph.split('');
    var matrix = List.generate(4, (i) => List.filled(8, ''));

    int k = 0;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 8; j++, k++) {
        if (keyList.length > k) {
          if (avaiable.contains(keyList[k])) {
            matrix[i][j] = keyList[k];
            avaiable.remove(keyList[k]);
          }
        } else {
          matrix[i][j] = avaiable[0];
          avaiable.removeAt(0);
        }
      }
    }
    return matrix;
  }

  static String _createBigram(str) {
    int k = 0;
    String bigram = "";
    for (int i = 0; i < str.length; i++) {
      if (str[i] == " ") continue;
      bigram += str[i].toUpperCase();
      if ((++k) % 2 == 0) {
        bigram += " ";
      }
    }
    return bigram.trimRight();
  }

  static String encrypt(String str, String key) {
    //init matrix
    var matrix = _initMatrix(key);
    //Create bigram -- Ё
    String bigrams = _createBigram(str);

    //check
    for (var arr in matrix) {
      print(arr);
    }

    // add if tow same symbols

    if (bigrams[bigrams.length - 2] == " ") bigrams += "Ё";
    var bigramList = bigrams.split(" ");

    var k = 0;
    for (var bigram in bigramList) {
      // skip ё
      if (bigram[0] == "Ё" || bigram[1] == "Ё") {
        continue;
      }
      //find pos
      var p1 = Pair(0, 0), p2 = Pair(0, 0);
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 8; j++) {
          if (matrix[i][j] == bigram[0]) {
            p1.set(i, j);
          }
          if (matrix[i][j] == bigram[1]) {
            p2.set(i, j);
          }
        }
      }
      //print("${bigram} | ${p1} | ${p2}");
      //2
      if (p1.first == p2.first) {
        String v1 = p1.second == 7
            ? matrix[p1.first][0]
            : matrix[p1.first][p1.second + 1];
        String v2 = p2.second == 7
            ? matrix[p2.first][0]
            : matrix[p2.first][p2.second + 1];

        bigramList[k] = v1 + v2;
      } //3
      else if (p1.second == p2.second) {
        String v1 = p1.first == 3
            ? matrix[0][p1.second]
            : matrix[p1.first + 1][p1.second];
        String v2 = p2.first == 3
            ? matrix[0][p1.second]
            : matrix[p2.first + 1][p2.second];

        bigramList[k] = v1 + v2;
      } else {
        bigramList[k] =
            matrix[p1.first][p2.second] + matrix[p2.first][p1.second];
      }

      k++;
    }
    print(bigrams);
    return bigramList.join();
  }

  static String decrypt(String str, String key) {
    var matrix = _initMatrix(key);
    var bigrams = _createBigram(str);
    var bigramList = bigrams.split(" ");

    print(bigramList);

    var k = 0;

    for (var bigram in bigramList) {
      // skip ё
      if (bigram[0] == "Ё" || bigram[1] == "Ё") {
        continue;
      }
      //find pos
      var p1 = Pair(0, 0), p2 = Pair(0, 0);
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 8; j++) {
          if (matrix[i][j] == bigram[0]) {
            p1.set(i, j);
          }
          if (matrix[i][j] == bigram[1]) {
            p2.set(i, j);
          }
        }
      }
      if (p1.first == p2.first) {
        String v1 = p1.second == 0
            ? matrix[p1.first][7]
            : matrix[p1.first][p1.second - 1];
        String v2 = p2.second == 0
            ? matrix[p2.first][7]
            : matrix[p2.first][p2.second - 1];

        bigramList[k] = v1 + v2;
      } else if (p1.second == p2.second) {
        String v1 = p1.first == 0
            ? matrix[3][p1.second]
            : matrix[p1.first - 1][p1.second];
        String v2 = p2.first == 0
            ? matrix[3][p1.second]
            : matrix[p2.first - 1][p2.second];

        bigramList[k] = v1 + v2;
      } else {
        bigramList[k] =
            matrix[p1.first][p2.second] + matrix[p2.first][p1.second];
      }
      k++;
    }
    print(bigramList);
    return bigramList.join().replaceAll('Ё', '');
  }
}

void main() {
  //Task 1
  // print(CaesarSystem.encrypt("Марина", 33));
  // print(CaesarSystem.decrypt("Тёцоуё", 666));

  //Task 2
  // print(TrisemusSystem.encrypt(
  //     "Съешь же ещё этих мягких французских булок, да выпей чаю.", [2, 5, 3]));
  // print(TrisemusSystem.decrypt(
  //     "ФБЩШЛГД Ч.ЪСЧДП ЕО,ЧЁЬЙЙЛЮЩЛ РЬА РЙХАКЕЛ,РЮШЮЭ,НТЩВ,ПЁФЦВ", [2, 5, 3]));

  //Task 3
  print(
    PlayfairAlgoritm.encrypt(
        "Название любимой книги кенни и ее автора", "призыв"),
  );
  print(
    PlayfairAlgoritm.decrypt("ХПЫАПХЕСХАПЗДЦКЛСПЕПЛЖООЗЗЖЖБАУСИБАЁ", "призыв"),
  );
}
