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
