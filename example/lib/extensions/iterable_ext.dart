import 'package:collection/collection.dart';

extension IterableExt<T> on Iterable<T> {
  List<T> divide(
    T divider, {
    bool addBefore = false,
    bool addAfter = false,
  }) {
    final List<T> list = <T>[];

    forEachIndexed((int index, T child) {
      if (addBefore || index > 0) {
        list.add(divider);
      }
      list.add(child);
    });
    if (addAfter) {
      list.add(divider);
    }

    return list;
  }

  List<T> buildDivider(T Function(int index) builder) {
    return List<T>.generate(length * 2 - 1, (int index) {
      final int actualIndex = index ~/ 2;
      if (index.isEven) {
        return elementAt(actualIndex);
      } else {
        return builder(actualIndex);
      }
    });
  }
}

extension ListExt<T> on List<T?> {
  List<T?> removeNull() {
    removeWhere((T? element) => element == null);
    return this;
  }
}
