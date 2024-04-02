import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeCountNotifier extends Notifier <List<bool>> {
  @override
  List<bool> build() {
    return state = [true, false];
  }

  selectTimer(int index) {
    if (index == 0) {
      state = [true, false];
    } else {
      state = [false, true];
    }
  }
}
