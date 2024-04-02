import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/widget/all_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Statistics extends ConsumerWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var currentQlist = ref.watch(questionsNotifierNotifierProvider).qList;
    var currentAnswer = ref.watch(selectedAnswersNotifierProvider);


    int totalNum = ref.watch(quizChangeNotifierProvider);
    int t = 0;
    int correctNum = 0;

    for (t; t < (totalNum+1) ; t++) {
      if (currentQlist[t].Answer == currentAnswer[t]) {
        correctNum++;
      }
    }
    double correctRate = (correctNum / 10 );
    String correctRateT = (correctNum * 100 / 10 ).toStringAsFixed(1) + "%";

    bool showDisable = ref.watch(submitEnableNotifierProvider);
    double widthOFScreen = MediaQuery.of(context).size.width;
    double heightOFScreen = MediaQuery.of(context).size.height;

    if ( showDisable == false) {
      if (heightOFScreen > 1.1 * widthOFScreen) {
        return ListView(
          children: [
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: correctRate,
              center: Text(
                correctRateT,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: const Text(
                "Your current correct rate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
            const Divider(),
            QuestionTable(),
          ],
        );
      } else {
        return ListView(
          children: const [
            Divider(),
            QuestionTable(),
          ],
        );
      }
    } else {
      return const Center(
          child: Text(
              "Please Finish All Task and Submit, then You can See Statistics here"));
    }
  }
}
