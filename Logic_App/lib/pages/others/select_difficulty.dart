import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/http_request/all_requests.dart';

const List<Widget> Difficulty = <Widget>[
  Text('Easy'),
  Text('Medium'),
  Text('Hard')
];

class SelectDifficulty extends ConsumerWidget {
  const SelectDifficulty({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var _seletedLevel = ref.watch(selectedDifficultyNotifierProvider);
    String currentDifficulty =
        ref.read(selectedDifficultyNotifierProvider.notifier).getCurrentLevel();

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
            const Text(
              "Please Select Difficulty",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            ToggleButtons(
                onPressed: (int index) {
                  ref
                      .read(selectedDifficultyNotifierProvider.notifier)
                      .select(index);
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
                children: Difficulty,
                isSelected: _seletedLevel),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  // getAllQuestions
                  var dbResponse = await getAllQuestions(currentDifficulty);
                  ref
                      .read(questionsNotifierNotifierProvider.notifier)
                      .saveQuestion(dbResponse);
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
