import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends Notifier<int> {
  late StreamController<int> timerController;
  late Stream<int> timerStream;
  int lastThrowTime = 0;
  late var timerSubscription;

  @override
  int build() {
    timerController = StreamController<int>();
    timerStream = timerController.stream;
    startTimer();
    return state = 0;
  }

  void startTimer() {
    timerStream = Stream.periodic(const Duration(milliseconds: 100), (i) => i);
    timerSubscription = timerStream.listen((int elapsed) {
      state = elapsed * 100;
    });
  }

  void stopTimer() {
    timerSubscription.cancel();
  }

  void resetTimer() {
    timerController.close();
    timerController = StreamController<int>();
    timerStream = timerController.stream;
    stopTimer();
    startTimer();
  }

  void recordThrow() {
    final int currentTime = state;
    lastThrowTime = currentTime;
  }
}
