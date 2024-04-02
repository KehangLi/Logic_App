import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';

class Time extends ConsumerWidget {
  const Time({super.key});

  @override
  Widget build(BuildContext context, ref) {
    int eMilliseconds = ref.watch(timerNotifierProvider);

    String formatMilliseconds(int milliseconds) {
      final int minutes = (milliseconds ~/ (1000 * 60)) % 60;
      final int seconds = (milliseconds ~/ 1000) % 60;
      final int tenths = (milliseconds ~/ 100) % 10;
      return '$minutes:${seconds.toString().padLeft(2, '0')}.${tenths}';
    }

    bool showEnable = ref.watch(timeCountNotifierProvider)[0];

    if (showEnable == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Consuming Time : ${formatMilliseconds(eMilliseconds)}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      );
    } else {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Consuming time is not provided in this model',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      );
    }
  }
}
