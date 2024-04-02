import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/widget/all_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/util/all_utils.dart';
import 'package:logic_app/http_request/all_requests.dart';

class Quiz extends ConsumerWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var colorList = ref.watch(choiceChangeNotifierProvider);
    var questionList = ref.watch(questionsNotifierNotifierProvider).qList;
    int i = ref.watch(quizChangeNotifierProvider);
    var continueEnable =
        ref.watch(choiceChangeNotifierProvider.notifier).continueEnable;
    var currentUser = ref.watch(currentUserNotifierProvider);
    bool submitEnable = ref.watch(submitEnableNotifierProvider);
    String currentLevel =
        ref.read(selectedDifficultyNotifierProvider.notifier).getCurrentLevel();
    List<String> currentAnswerList = ref
        .read(selectedAnswersNotifierProvider.notifier)
        .getCurrentAnswerList();

    List<int> currentIDList = [
      questionList[0].Id,
      questionList[1].Id,
      questionList[2].Id,
      questionList[3].Id,
      questionList[4].Id,
      questionList[5].Id,
      questionList[6].Id,
      questionList[7].Id,
      questionList[8].Id,
      questionList[9].Id
    ];
    List<int> consumingTime = [
      questionList[0].ConsumingTime,
      questionList[1].ConsumingTime,
      questionList[2].ConsumingTime,
      questionList[3].ConsumingTime,
      questionList[4].ConsumingTime,
      questionList[5].ConsumingTime,
      questionList[6].ConsumingTime,
      questionList[7].ConsumingTime,
      questionList[8].ConsumingTime,
      questionList[9].ConsumingTime
    ];


    double widthOFScreen = MediaQuery.of(context).size.width;
    double heightOFScreen = MediaQuery.of(context).size.height;

    if (heightOFScreen > 1.1 * widthOFScreen) {
      return Scaffold(
        body: Center(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: heightOFScreen * 0.1,
                  ),

                  Text(
                    questionList[i].Text,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: heightOFScreen * 0.03,
                  ),

                  const Divider(),

                  Time(),

                  const Divider(),

                  StepProgressIndicator(
                    totalSteps: 10,
                    currentStep: i + 1,
                    selectedColor: Colors.redAccent,
                    unselectedColor: Colors.amberAccent,
                  ),
                  const Divider(),

                  GestureDetector(
                    child: answerCard(questionList[i].A, colorList[0], context),
                    onTap: () {
                      ref
                          .read(choiceChangeNotifierProvider.notifier)
                          .selectedA();
                      ref
                          .read(selectedAnswersNotifierProvider.notifier)
                          .selectA(i);
                    },
                  ),
                  GestureDetector(
                    child: answerCard(questionList[i].B, colorList[1], context),
                    onTap: () {
                      ref
                          .read(choiceChangeNotifierProvider.notifier)
                          .selectedB();
                      ref
                          .read(selectedAnswersNotifierProvider.notifier)
                          .selectB(i);
                    },
                  ),
                  GestureDetector(
                    child: answerCard(questionList[i].C, colorList[2], context),
                    onTap: () {
                      ref
                          .read(choiceChangeNotifierProvider.notifier)
                          .selectedC();
                      ref
                          .read(selectedAnswersNotifierProvider.notifier)
                          .selectC(i);
                    },
                  ),
                  GestureDetector(
                    child: answerCard(questionList[i].D, colorList[3], context),
                    onTap: () {
                      ref
                          .read(choiceChangeNotifierProvider.notifier)
                          .selectedD();
                      ref
                          .read(selectedAnswersNotifierProvider.notifier)
                          .selectD(i);
                    },
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print(continueEnable);

                            // check enable
                            if (continueEnable == true) {
                              if (i < 9) {
                                ref
                                    .read(quizChangeNotifierProvider.notifier)
                                    .next();
                                ref
                                    .read(choiceChangeNotifierProvider.notifier)
                                    .resetColor();
                                // record time
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .recordThrow();
                                questionList[i].ConsumingTime =
                                    ref.watch(timerNotifierProvider);
                                //print(questionList[i].ConsumingTime);
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .resetTimer();
                                // reset continue
                                ref
                                    .read(choiceChangeNotifierProvider.notifier)
                                    .resetContinue();
                              } else {
                                showSnackBar(context,
                                    "You have finished all Questions, please Submit");
                              }
                            } else {
                              showSnackBar(context, "Please select a choice");
                            }
                          },
                          child: const Text("Next")),
                      ElevatedButton(
                          onPressed: () {
                            if (continueEnable == true) {
                              if (i == 9 && submitEnable == true) {
                                //  stop timer->record timer->send post request->go to other page
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .stopTimer();
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .recordThrow();
                                questionList[i].ConsumingTime =
                                    ref.watch(timerNotifierProvider);
                                //print(questionList[i].ConsumingTime);
                                Navigator.pushNamed(context, "quizFinish");
                                // post answers
                                sendAnswer(currentIDList, currentUser,
                                    currentLevel, currentAnswerList);
                                // post consuming time
                                sendConsumingTime(currentIDList, consumingTime,
                                    currentUser, currentLevel);
                                ref
                                    .read(submitEnableNotifierProvider.notifier)
                                    .submit();
                              } else if (i == 9 && submitEnable == false) {
                                showSnackBar(context,
                                    "Can not submit again, please go to 'try again'");
                              } else {
                                showSnackBar(
                                    context, "Please Finish All the tasks");
                              }
                            } else {
                              showSnackBar(context, "Please select a choice");
                            }
                          },
                          child: const Text("Submit")),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: heightOFScreen * 0.1,
                  ),
                  Text(
                    questionList[i].Text,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: heightOFScreen * 0.03,
                  ),
                  const Divider(),
                  Time(),
                  const Divider(),
                  StepProgressIndicator(
                    totalSteps: 10,
                    currentStep: i + 1,
                    selectedColor: Colors.redAccent,
                    unselectedColor: Colors.amberAccent,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: answerCard(
                              questionList[i].A, colorList[0], context),
                          onTap: () {
                            ref
                                .read(choiceChangeNotifierProvider.notifier)
                                .selectedA();
                            ref
                                .read(selectedAnswersNotifierProvider.notifier)
                                .selectA(i);
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: answerCard(
                              questionList[i].B, colorList[1], context),
                          onTap: () {
                            ref
                                .read(choiceChangeNotifierProvider.notifier)
                                .selectedB();
                            ref
                                .read(selectedAnswersNotifierProvider.notifier)
                                .selectB(i);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: answerCard(
                              questionList[i].C, colorList[2], context),
                          onTap: () {
                            ref
                                .read(choiceChangeNotifierProvider.notifier)
                                .selectedC();
                            ref
                                .read(selectedAnswersNotifierProvider.notifier)
                                .selectC(i);
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: answerCard(
                              questionList[i].D, colorList[3], context),
                          onTap: () {
                            ref
                                .read(choiceChangeNotifierProvider.notifier)
                                .selectedD();
                            ref
                                .read(selectedAnswersNotifierProvider.notifier)
                                .selectD(i);
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print(continueEnable);
                            if (continueEnable == true) {
                              if (i < 9) {
                                ref
                                    .read(quizChangeNotifierProvider.notifier)
                                    .next();
                                ref
                                    .read(choiceChangeNotifierProvider.notifier)
                                    .resetColor();
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .recordThrow();
                                questionList[i].ConsumingTime =
                                    ref.watch(timerNotifierProvider);
                                //print(questionList[i].ConsumingTime);
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .resetTimer();
                                ref
                                    .read(choiceChangeNotifierProvider.notifier)
                                    .resetContinue();
                              } else {
                                showSnackBar(context,
                                    "You have finished all Questions, please Submit");
                              }
                            } else {
                              showSnackBar(context, "Please select a choice");
                            }
                          },
                          child: const Text("Next")),
                      ElevatedButton(
                          onPressed: () {
                            if (continueEnable == true) {
                              if (i == 9 && submitEnable == true) {
                                //  stop time->record time->send post request->go to statistics page
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .stopTimer();
                                ref
                                    .read(timerNotifierProvider.notifier)
                                    .recordThrow();
                                questionList[i].ConsumingTime =
                                    ref.watch(timerNotifierProvider);
                                //print(questionList[i].ConsumingTime);
                                Navigator.pushNamed(context, "quizFinish");
                                // send post request
                                sendAnswer(currentIDList, currentUser,
                                    currentLevel, currentAnswerList);
                                sendConsumingTime(currentIDList, consumingTime,
                                    currentUser, currentLevel);

                                ref
                                    .read(submitEnableNotifierProvider.notifier)
                                    .submit();
                              } else if (i == 9 && submitEnable == false) {
                                showSnackBar(context,
                                    "Can not submit again, please go to 'try again'");
                              } else {
                                showSnackBar(
                                    context, "Please Finish All the tasks");
                              }
                            } else {
                              showSnackBar(context, "Please select a choice");
                            }
                          },
                          child: const Text("Submit")),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    }
  }
}
