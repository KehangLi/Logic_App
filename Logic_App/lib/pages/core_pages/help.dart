import 'package:flutter/material.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.photo,
    required this.icon,
    required this.subtitle,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  String subtitle;
  String photo;
  IconData icon;
}

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final List<Item> _data = [
    Item(
        expandedValue: "",
        headerValue: "1.What is the type of questions?",
        photo: "help_1.png",
        icon: Icons.question_answer_outlined,
        subtitle:
            "The type of tasks in this app is about propositional formal logic."),
    Item(
        expandedValue: "",
        headerValue:
            "2.What are the differences between online model and offline model?",
        photo: "help_2.png",
        icon: Icons.smoking_rooms,
        subtitle:
            "More experience are in online model, some functions are not provided in the offline model."),
    Item(
        expandedValue: "",
        headerValue: "3.Can I choose turn off the timer? ",
        photo: "help_3.png",
        icon: Icons.smoking_rooms,
        subtitle:
            "Yes, you can turn off the timer, if you are under big pressure when there is timer in the quiz page"),
    Item(
        expandedValue: "",
        headerValue: "4.Can i choose dark Model?",
        photo: "help_4.png",
        icon: Icons.smoking_rooms,
        subtitle: "Yes! This app provides dark and light model."),
    Item(
        expandedValue: "",
        headerValue:
            "5.What are differences between Level Easy, Medium and Hard?",
        photo: "help_5.jpg",
        icon: Icons.smoking_rooms,
        subtitle:
            "In the easy level, the tasks are about basic knowledge. In the medium level, you should decide which formula"
            "in the A,B,C,D choices are equal to the formula in the question. In the Hard Level, in the questions given that truth value of two atomic"
            "formula and a truth value. You should decide which formula has the same truth value based on the info given in the questions."),
    Item(
        expandedValue: "",
        headerValue: "6.What is high score table?",
        photo: "help_6.png",
        icon: Icons.smoking_rooms,
        subtitle:
            "High score table is only provided for users who have already registered, it shows total scores for all registered users."
            " Users can find their location in the high score table."),
    Item(
        expandedValue: "",
        headerValue: "7.What is rule of calculating total scores? ",
        photo: "help_7.jpg",
        icon: Icons.smoking_rooms,
        subtitle:
            "If you correctly answer one question of Easy level, you can get one point; if you correctly answer one question of Medium level,"
            "you can get two points; if you correctly answer one question of Hard level, you can get three points."),
    Item(
        expandedValue: "",
        headerValue: "Good Luck!",
        photo: "goodLuck.jpeg",
        icon: Icons.adb,
        subtitle: "Hope you have a good experience with this logic app!"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Column(
            children: [
              Image.asset(item.photo),
              const Divider(),
              ListTile(
                subtitle: Text(item.subtitle),
                trailing: Icon(item.icon),
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
