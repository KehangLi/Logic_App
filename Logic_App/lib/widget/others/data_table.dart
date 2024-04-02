import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';


class QuestionTable extends ConsumerWidget {
  const QuestionTable({super.key});


  @override
  Widget build(BuildContext context,ref) {

    var questionList = ref.watch(questionsNotifierNotifierProvider).qList;
    var selectedAnswer = ref.watch(selectedAnswersNotifierProvider);

    // inital dataRows
    List<DataRow> dataRows = [];
    for(int i = 0; i <questionList.length; i++){
      dataRows.add(DataRow(cells: [
        DataCell(Text(questionList[i].Text)),
        DataCell(Text(questionList[i].Answer)),
        DataCell(Text(selectedAnswer[i])),
        DataCell(Text('${questionList[i].ConsumingTime}')),
        DataCell(Text(questionList[i].A)),
        DataCell(Text(questionList[i].B)),
        DataCell(Text(questionList[i].C)),
        DataCell(Text(questionList[i].D)),
      ]));
    }


    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Questions"),),
              DataColumn(label: Text("CorrectAnswer"),),
              DataColumn(label: Text("YourAnswer"),),
              DataColumn(label: Text("ConsumingTime"),),
              DataColumn(label: Text("Choices_A"),),
              DataColumn(label: Text("Choices_B"),),
              DataColumn(label: Text("Choices_C"),),
              DataColumn(label: Text("Choices_D"),),
            ],
            rows: dataRows,
          )
      ),

    );

  }
}