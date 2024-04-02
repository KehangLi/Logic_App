import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedDifficultyNotifier extends Notifier<List<bool>> {
  @override
  List<bool> build() {
    return state = [true, false, false];
  }

  select(int index) {
    if (index == 0) {
      state = [true, false, false];
    } else if (index == 1) {
      state = [false, true, false];
    } else {
      state = [false, false, true];
    }
  }

  reset() {
    return state = [true, false, false];
  }

  String getCurrentLevel(){

    var level = "Easy";

    if (state[0] == true) {
      level = "Easy";
    } else if (state[1] == true) {
      level = "Medium";
    } else {
      level = "Hard";
    }

    return level;

  }


}
