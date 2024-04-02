import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/notifier/all_notifiers.dart';
import '../entity/question_list.dart';
import '../entity/user_score_list.dart';

var currentModelNotifierProvider =
    NotifierProvider<CurrentModelNotifier, bool>(CurrentModelNotifier.new);

var currentUserNotifierProvider =
    NotifierProvider<CurrentUserNotifier, String>(CurrentUserNotifier.new);

var lightDarkModelNotifierProvider =
    NotifierProvider<LightDarkModelNotifier, List<bool>>(
        LightDarkModelNotifier.new);

var timeCountNotifierProvider =
    NotifierProvider<TimeCountNotifier, List<bool>>(TimeCountNotifier.new);

var choiceChangeNotifierProvider =
    NotifierProvider<ChoiceChangeNotifier, List<MaterialAccentColor>>(
        ChoiceChangeNotifier.new);

var pageChangeNotifierProvider =
    NotifierProvider<PageChangeNotifier, int>(PageChangeNotifier.new);

var registrationEnableNotifierProvider =
    NotifierProvider<RegistrationEnableNotifier, bool>(
        RegistrationEnableNotifier.new);

var questionsNotifierNotifierProvider =
    NotifierProvider<QuestionsNotifier, QuestionsList>(QuestionsNotifier.new);

var quizChangeNotifierProvider =
    NotifierProvider<QuizChangeNotifier, int>(QuizChangeNotifier.new);

var selectedAnswersNotifierProvider =
    NotifierProvider<SelectedAnswersNotifier, List<String>>(
        SelectedAnswersNotifier.new);

var selectedDifficultyNotifierProvider =
    NotifierProvider<SelectedDifficultyNotifier, List<bool>>(
        SelectedDifficultyNotifier.new);

var submitEnableNotifierProvider =
    NotifierProvider<SubmitEnableNotifier, bool>(SubmitEnableNotifier.new);

var timerNotifierProvider =
    NotifierProvider<TimerNotifier, int>(TimerNotifier.new);

var highScoreTableNotifierProvider =
    NotifierProvider<HighScoreTableNotifier, UserScoreList>(
        HighScoreTableNotifier.new);

var sortNotifierProvider =
    NotifierProvider<SortNotifier, bool>(SortNotifier.new);
