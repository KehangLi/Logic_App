import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizChangeNotifier extends Notifier<int> {
  @override
  int build() {
    return state = 0;
  }

  void next() {
    if (state < 9) {
      state = state + 1;
    } else {
      state = 0;
    }
  }

  void reset() {
    state = 0;
  }
}
