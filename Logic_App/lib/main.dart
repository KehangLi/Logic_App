import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/pages/all_pages.dart';
import 'package:logic_app/providers/providers.dart';

void main() {
  runApp( ProviderScope(
    child: MyApp(),
  )
  );
}

class MyApp extends ConsumerWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context,ref) {

    var globalModel = ref.watch(lightDarkModelNotifierProvider)[0];

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      themeMode: globalModel ? ThemeMode.light : ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      title: 'Logic_App',
      routes: {
        'registration': (context)=>Registration(),
        'navigation': (context)=>Navigation(),
        'statistics': (context)=>Statistics(),
        'quizFinish': (context)=>QuizFinish(),
        'login': (context)=>Login(),
        'selectDifficulty': (context)=>SelectDifficulty(),
        'selectDifficultyOffline': (contex)=>SelectDifficultyOffline(),
        'HighScoreTable': (contex)=>HighScoreTable(),
      },
      initialRoute: 'registration',
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}