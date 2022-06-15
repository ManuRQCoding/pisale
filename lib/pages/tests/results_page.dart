import 'package:flutter/material.dart';
import 'package:pisale/providers/test_provider.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testProv = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              testProv.reset();
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
        title: Text('Resultados'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                height: 0,
              ),
          itemCount: testProv.questionsAnswered.length,
          itemBuilder: (context, i) {
            final item = testProv.questionsAnswered[i];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                tileColor: item!.selected!.correct ? Colors.green : Colors.red,
                title:
                    Text(item.content, style: TextStyle(color: Colors.white)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    height: item.answers.length * 25,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.answers.length,
                        itemBuilder: (context, i) {
                          final answer = item.answers[i];
                          return Row(
                            children: [
                              Flexible(
                                child: FittedBox(
                                  child: Text(
                                      '${String.fromCharCode(65 + i)}) ${answer.content}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: item.selected!.content ==
                                                  answer.content
                                              ? FontWeight.bold
                                              : FontWeight.normal)),
                                ),
                              ),
                              item.selected!.content == answer.content &&
                                      !answer.correct
                                  ? Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    )
                                  : answer.correct
                                      ? Icon(Icons.check, color: Colors.white)
                                      : Container()
                            ],
                          );
                        }),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
