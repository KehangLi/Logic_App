import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmitEnableNotifier extends Notifier<bool> {
  @override
  bool build() {
    return state = true;
  }

  submit() {
    state = false;
  }

  reset() {
    state = true;
  }
}
