import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';
import 'help.dart';
import 'quiz.dart';
import 'settings.dart';
import 'statistics.dart';

class Navigation extends ConsumerWidget {
  Navigation({super.key});

  final List<BottomNavigationBarItem> bottomNaItems = [
    const BottomNavigationBarItem(
        backgroundColor: Colors.greenAccent,
        icon: Icon(Icons.article_rounded),
        label: 'quiz'),
    const BottomNavigationBarItem(
        backgroundColor: Colors.redAccent,
        icon: Icon(Icons.assessment_outlined),
        label: 'statistics'),
    const BottomNavigationBarItem(
        backgroundColor: Colors.orangeAccent,
        icon: Icon(Icons.settings),
        label: 'settings'),
    const BottomNavigationBarItem(
        backgroundColor: Colors.cyanAccent,
        icon: Icon(Icons.help_outline),
        label: 'help'),
  ];

  final List<Widget> allpages = [
    Quiz(),
    Statistics(),
    Settings(),
    Help(),
  ];

  final List<Text> allTitle = [
    const Text("Logic App"),
    const Text("Statistics"),
    const Text("Settings"),
    const Text("Frequently Asked Question"),
  ];

  @override
  Widget build(BuildContext context, ref) {
    int currentIndex = ref.watch(pageChangeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: allTitle[currentIndex],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: allpages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNaItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          ref.read(pageChangeNotifierProvider.notifier).changePage(index);
        },
      ),
    );
  }
}
