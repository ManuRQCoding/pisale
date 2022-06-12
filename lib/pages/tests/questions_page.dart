import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:pisale/models/answer.dart';
import 'package:pisale/models/question.dart';
import 'package:pisale/propeties.dart';
import 'package:pisale/providers/test_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_prov.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  // Future<List<QuerySnapshot<Object?>>> getTestsByIds(
  PageController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
  }

  // after all of the data is fetched, return it

  @override
  Widget build(BuildContext context) {
    final testProv = Provider.of<TestProvider>(context, listen: false);
    final authProv = Provider.of<AuthProv>(context, listen: false);
    final questionsIds =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    if (testProv.questionsAnswered.isEmpty) {
      testProv.start(questionsIds.length);
    }

    final palette = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              testProv.reset();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Test 1'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('questions')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }

                    final data = snapshot.data!.docs
                        .where((element) => questionsIds.contains(element.id))
                        .toList();

                    return PageView.builder(
                        controller: _controller,
                        itemCount: questionsIds.length,
                        itemBuilder: (context, i) {
                          final currentData = data[i];

                          final actualQuestion =
                              Question.fromJson(jsonEncode(currentData.data()));

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Pregunta ${i + 1} de ${questionsIds.length}',
                                  style: TextStyle(
                                      color: palette.tertiary,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage('assets/loading.gif'),
                                      image: NetworkImage(actualQuestion
                                              .image ??
                                          'https://firebasestorage.googleapis.com/v0/b/pisale-80b0a.appspot.com/o/images%2Fdefault.png?alt=media&token=d3d5574d-d74c-4650-9ae5-19326fbd5e52'),
                                      width: 250,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder:
                                          (context, object, stacktrace) {
                                        return Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/pisale-80b0a.appspot.com/o/images%2Fdefault.png?alt=media&token=d3d5574d-d74c-4650-9ae5-19326fbd5e52',
                                          width: 250,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        actualQuestion.content,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height:
                                            actualQuestion.answers.length * 76,
                                        child: TestAnswers(
                                          actualQuestion: actualQuestion,
                                          pos: i,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                testProv.studyMode
                                    ? Column(
                                        children: [
                                          FloatingActionButton(
                                            heroTag: 'help',
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              actualQuestion
                                                                  .help),
                                                        ),
                                                      ));
                                            },
                                            child: Icon(
                                              Icons.lightbulb,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        });
                  }),
            ),
            SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: 'prev',
                      onPressed: () {
                        _controller!.previousPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left_rounded,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(palette.tertiary),
                      ),
                      onPressed: () {
                        if (testProv.questionsAnswered
                            .any((test) => test == null)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0XFFFFB818),
                              content: Text(
                                'Debes responder a todas las preguntas',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )));
                        } else {
                          testProv.updateUserResults(authProv.userLogged!);
                          Navigator.pushNamed(context, 'results');

                          // showDialog(
                          //     context: context,
                          //     builder: (context) => Dialog(
                          //           child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Text(testProv
                          //                   .getAciertos()
                          //                   .toString())),
                          //         ));
                        }
                      },
                      child:
                          Text(testProv.studyMode ? 'Finalizar' : 'Corregir'),
                    ),
                    FloatingActionButton(
                      heroTag: 'next',
                      onPressed: () {
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class TestAnswers extends StatefulWidget {
  const TestAnswers({
    Key? key,
    required this.actualQuestion,
    required this.pos,
  }) : super(key: key);

  final Question actualQuestion;
  final int pos;

  @override
  State<TestAnswers> createState() => _TestAnswersState();
}

class _TestAnswersState extends State<TestAnswers> {
  @override
  @override
  Widget build(BuildContext context) {
    final testProv = Provider.of<TestProvider>(context);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.actualQuestion.answers.length,
        itemBuilder: (context, i) {
          final answer = widget.actualQuestion.answers[i];

          return InkWell(
            onTap: () {
              if (testProv.studyMode &&
                  testProv.questionsAnswered[widget.pos] != null) {
                return;
              }
              widget.actualQuestion.selected = answer;
              testProv.add(widget.actualQuestion, widget.pos);
            },
            child: AnswerWidget(
              pos: i,
              answer: answer,
              selected: testProv.questionsAnswered[widget.pos] != null &&
                      testProv.questionsAnswered[widget.pos]!.selected!
                              .content ==
                          answer.content
                  ? true
                  : false,
              actualQuestion: testProv.questionsAnswered[widget.pos] ??
                  widget.actualQuestion,
            ),
          );
        });
  }
}

class AnswerWidget extends StatefulWidget {
  const AnswerWidget(
      {Key? key,
      required this.pos,
      required this.answer,
      required this.selected,
      required this.actualQuestion})
      : super(key: key);

  final Answer answer;
  final int pos;

  final bool selected;
  final Question actualQuestion;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  // item.selected!.content == answer.content &&
  //                                   !answer.correct
  //                               ? Icon(Icons.close)
  //                               : answer.correct
  //                                   ?

  @override
  Widget build(BuildContext context) {
    final testProv = Provider.of<TestProvider>(context);
    final bool answered =
        testProv.studyMode && widget.actualQuestion.selected != null;
    final palette = Theme.of(context).colorScheme;

    print('answer' + answered.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tileColor: answered
            ? widget.actualQuestion.selected!.content ==
                        widget.answer.content &&
                    !widget.answer.correct
                ? Colors.red
                : widget.answer.correct
                    ? Colors.green
                    : Colors.transparent
            : widget.selected
                ? Colors.blue.withOpacity(0.5)
                : Colors.transparent,
        leading: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: palette.tertiary),
          child: Center(
            child: Text(
              String.fromCharCode(65 + widget.pos),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(widget.answer.content),
      ),
    );
  }
}

// List<Widget> getAnswerWithPos(List<Answer> answers) {
//   final List<Widget> answersWidgets = [];

//   for (var i = 0; i < answers.length; i++) {
//     answersWidgets.add(AnswerWidget(
//         pos: i, content: answers[i].content, selected: answers[i].correct));
//   }

//   return answersWidgets;
// }
