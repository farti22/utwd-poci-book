import 'dart:math';

/// Возвращает список натуральных чисел до указанного числа
List<int> primeList(int n) {
  var primes = <int>[2];
  for (int i = 3; i < n + 1; i += 2) {
    if (i > 10 && (i % 10 == 5)) continue;
    Iterator j = primes.iterator;
    while (j.moveNext()) {
      if (j.current * j.current - 1 > 1) {
        primes.add(i);
        break;
      }
      if (i % j.current == 0) {
        break;
      } else {
        primes.add(i);
      }
    }
  }
  return primes;
}

/// Преобразует двумерный массив в строку
String matrixToString(List<List> matrix) {
  String str = "";
  matrix.forEach((_) {
    _.forEach((ch) {
      str += ch;
    });
  });
  return str;
}

/// Транспонирует матрицу строк
List<List<String>> matrixTransp(List<List<String>> matrix) {
  var transpMatrix = List.generate(
      matrix[0].length, (index) => List.filled(matrix.length, ""));

  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[0].length; j++) {
      transpMatrix[j][i] = matrix[i][j];
    }
  }
  return transpMatrix;
}

bool isPrime(int value) {
  for (int i = 2; i < sqrt(value); i++) {
    if (value % i == 0) return false;
  }
  return true;
}
