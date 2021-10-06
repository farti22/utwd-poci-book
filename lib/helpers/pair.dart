class Pair<T1, T2> {
  T1 first;
  T2 second;

  void set(T1 first, T2 second) {
    this.first = first;
    this.second = second;
  }

  @override
  String toString() {
    return "{$first, $second}";
  }

  Pair(this.first, this.second);
}
