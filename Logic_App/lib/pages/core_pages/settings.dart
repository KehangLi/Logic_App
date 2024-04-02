import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/http_request/all_requests.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/util/all_utils.dart';


const List<Widget> darkLightModel = <Widget>[
  Icon(Icons.light_mode_sharp),
  Icon(Icons.dark_mode),
];

const List<Widget> timeCountModel = <Widget>[
  Icon(Icons.timer),
  Icon(Icons.timer_off),
];


class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context,ref) {

    var switchLightDark = ref.watch(lightDarkModelNotifierProvider);
    var switchTimecount = ref.watch(timeCountNotifierProvider);

    bool currentModel = ref.watch(currentModelNotifierProvider);
    var pushedName =  currentModel? "selectDifficulty" : "selectDifficultyOffline";

    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text("Dark or Light Model: "),
                    ToggleButtons(
                      onPressed: (int index){
                        ref.read(lightDarkModelNotifierProvider.notifier).selectLightOrDark(index);
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
                      children: darkLightModel,
                      isSelected: switchLightDark,
                    ),
                  ],
                ),
              ),

              Divider(),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text("Timer or Without Timer: "),
                    ToggleButtons(
                      onPressed: (int index){
                        ref.read(timeCountNotifierProvider.notifier).selectTimer(index);
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
                      children: timeCountModel,
                      isSelected: switchTimecount,
                    ),
                  ],
                ),
              ),

              const Divider(),

              ElevatedButton(

                onPressed: () async{

                  if( currentModel == true ){
                    var dbResponse = await getHighScoreTable();
                    ref.read(highScoreTableNotifierProvider.notifier).saveToUserTable(dbResponse);
                    Navigator.pushNamed(context, "HighScoreTable");
                  } else{
                    showSnackBar(context, "More Experience in Online Model");
                  }
                },

                child: const Text("View High Score Table"),
              ),

              const Divider(),

              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(pushedName, (route) => false);
                  ref.read(quizChangeNotifierProvider.notifier).reset();
                  ref.read(choiceChangeNotifierProvider.notifier).reset();
                  ref.read(selectedAnswersNotifierProvider.notifier).reset();
                  ref.read(timerNotifierProvider.notifier).stopTimer();
                  ref.read(pageChangeNotifierProvider.notifier).goToQuiz();
                  ref.read(submitEnableNotifierProvider.notifier).reset();
                  ref.read(selectedDifficultyNotifierProvider.notifier).reset();
                },
                child: const Text("Try Again"),
              ),

              Divider(),

              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
                  ref.read(quizChangeNotifierProvider.notifier).reset();
                  ref.read(choiceChangeNotifierProvider.notifier).reset();
                  ref.read(selectedAnswersNotifierProvider.notifier).reset();
                  ref.read(timerNotifierProvider.notifier).stopTimer();
                  ref.read(pageChangeNotifierProvider.notifier).goToQuiz();
                  ref.read(currentUserNotifierProvider.notifier).reSet();
                  ref.read(currentModelNotifierProvider.notifier).reset();
                  ref.read(submitEnableNotifierProvider.notifier).reset();
                  ref.read(selectedDifficultyNotifierProvider.notifier).reset();
                },
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


