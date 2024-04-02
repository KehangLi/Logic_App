import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';

class QuizFinish extends ConsumerWidget {
  const QuizFinish({super.key});

  @override
  Widget build(BuildContext context, ref) {
    double heightOFScreen = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Congratulations, You have finished all the Task."
            "To see all the detailed Info, please go to the Page Statistics",
            style: TextStyle(
              fontSize: 15,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        SizedBox(
          height: 0.08 * heightOFScreen,
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(pageChangeNotifierProvider.notifier).goToStatistics();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('navigation', (route) => false);
          },
          child: const Text("Show Statistics"),
        ),
      ],
    );
  }
}
