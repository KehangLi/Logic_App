import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortNotifier extends Notifier<bool> {
  @override
  bool build() {
    return state = true;
  }

  changeSort() {
    state = !state;
  }
}
