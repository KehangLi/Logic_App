import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';

class HighScoreTable extends ConsumerWidget {
  const HighScoreTable({super.key});

  @override
  Widget build(BuildContext context, ref) {

    String currentUser = ref.watch(currentUserNotifierProvider);
    var scoreTableInfo = ref.watch(highScoreTableNotifierProvider).userScoreTableInfo;
    bool ascending = ref.watch(sortNotifierProvider);


    if (ascending == true){
      scoreTableInfo.sort((a,b)=>(a.totalScoresE + 2*a.totalScoresM + 3*a.totalScoresH).compareTo(b.totalScoresE + 2*b.totalScoresM + 3*b.totalScoresH));
    } else {
      scoreTableInfo.sort((a,b)=>(b.totalScoresE + 2*b.totalScoresM + 3*b.totalScoresH).compareTo(a.totalScoresE + 2*a.totalScoresM + 3*a.totalScoresH));
    }


    List<DataRow> dataRows = [];
    for(int i=0; i< scoreTableInfo.length; i++){

      Color? rowColor = scoreTableInfo[i].username == currentUser ? Colors.red : Colors.tealAccent;

      dataRows.add(DataRow
        (
          color: MaterialStateColor.resolveWith((states) => rowColor),
          cells: [
            DataCell(Text(scoreTableInfo[i].username)),
            DataCell(Text('${scoreTableInfo[i].totalScoresE + 2*scoreTableInfo[i].totalScoresM + 3*scoreTableInfo[i].totalScoresH}')),
            DataCell(Text('${scoreTableInfo[i].totalScoresE}')),
            DataCell(Text('${scoreTableInfo[i].totalConsumingTimeE/scoreTableInfo[i].totalAttemptsE}')),
            DataCell(Text('${scoreTableInfo[i].totalScoresM}')),
            DataCell(Text('${scoreTableInfo[i].totalConsumingTimeM/scoreTableInfo[i].totalAttemptsM}')),
            DataCell(Text('${scoreTableInfo[i].totalScoresH}')),
            DataCell(Text('${scoreTableInfo[i].totalConsumingTimeH/scoreTableInfo[i].totalAttemptsH}')),
          ]));
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text('High Score Table'),
        elevation: 0.0,
        centerTitle: true,
      ),

      body: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortColumnIndex: 1,
                  sortAscending: ascending,
                  columns: [
                    const DataColumn(label: Text("User"),),
                    DataColumn(label: const Text("TotalScores"), onSort: (int columnIndex,bool ascending){

                      ref.read(sortNotifierProvider.notifier).changeSort();

                    }),
                    const DataColumn(label: Text("Scores_Easy"),),
                    const DataColumn(label: Text("ConsumingTime/Task_Easy (ms)"),),
                    const DataColumn(label: Text("Scores_Medium"),),
                    const DataColumn(label: Text("ConsumingTime/Task_Medium (ms)"),),
                    const DataColumn(label: Text("Scores_Hard"),),
                    const DataColumn(label: Text("ConsumingTime/Task_Hard (ms)"),),
                  ],
                  rows: dataRows,
                ),
              ),
            ),]
      ),
    );
  }
}

