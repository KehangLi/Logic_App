import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/util/all_utils.dart';

const List<Widget> _difficulty = <Widget>[
  Text('Easy'),
  Text('Medium'),
  Text('Hard')
];

class SelectDifficultyOffline extends ConsumerWidget {
  const SelectDifficultyOffline({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var _seletedLevel = ref.watch(selectedDifficultyNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logic App'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 先打字
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  text:
                      TextSpan(style: const TextStyle(fontSize: 18), children: [
                    const TextSpan(
                        text: "This off-line model, more experience in",
                        style: TextStyle(color: Colors.black87)),
                    TextSpan(
                      text: " Online Model",
                      style: const TextStyle(color: Colors.redAccent),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'registration', (route) => false);
                        }, // cascade notation
                    ),
                  ]),
                ),
              ),
            ),
            const Text(
              "Please Select Difficulty",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            ToggleButtons(
                onPressed: (int index) {
                  showSnackBar(
                      context, "More experience, please go to online model");
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                  minWidth: 80.0,
                ),
                children: _difficulty,
                isSelected: _seletedLevel),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(timerNotifierProvider.notifier).resetTimer();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('navigation', (route) => false);
                },
                child: Text("Let's Go"))
          ],
        ),
      ),
    );
  }
}
