import 'package:code_cards/provider/question_repo/question_repository.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CodeCardMain extends StatefulWidget {
  @override
  _CodeCardMainState createState() => _CodeCardMainState();
}

class _CodeCardMainState extends State<CodeCardMain>
    with SingleTickerProviderStateMixin {
  QuestionRepo questionRepo = QuestionRepo();

  AnimationController _flipController;
  @override
  void initState() {
    _flipController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform(
          origin: Offset(150, 0),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0008)
            ..rotateY(pi * _flipController.value),
          child: _flipController.value < 0.5
              ? FrontCard(
                  generalQuestion: questionRepo.getQuestion().generalQuestion)
              : Transform(
                  origin: Offset(150, 0),
                  transform: Matrix4.identity()..rotateY(pi),
                  child: BackCard(
                      codeQuestion: questionRepo.getQuestion().codeQuestion)),
        ),
        const SizedBox(
          height: 30,
        ),
        OutlineButton.icon(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: Colors.deepPurple),
            onPressed: () {
              _flipController.isDismissed
                  ? _flipController.forward()
                  : _flipController.reverse();
            },
            icon: Icon(Icons.swap_horiz_rounded, color: Colors.deepPurple),
            label: Text(
              'FLIP',
              style: TextStyle(color: Colors.deepPurple),
            ))
      ],
    );
  }
}

class FrontCard extends StatelessWidget {
  final String generalQuestion;
  const FrontCard({Key key, this.generalQuestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 400,
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.cyan[50],
                        border:
                            Border.all(width: 0.5, color: Colors.grey[400])),
                    child: Text('general',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic)),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star_border,
                    size: 30,
                    color: Colors.grey[500],
                  )
                ],
              ),
              const Spacer(),
              Text(
                generalQuestion,
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              DoYouKnowThisWidget(),
              const SizedBox(
                height: 24,
              )
            ],
          )),
    );
  }
}

class BackCard extends StatelessWidget {
  final String codeQuestion;
  const BackCard({Key key, this.codeQuestion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 400,
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.cyan[50],
                        border:
                            Border.all(width: 0.5, color: Colors.grey[400])),
                    child: Text('code',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic)),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star_border,
                    size: 30,
                    color: Colors.grey[500],
                  )
                ],
              ),
              const Spacer(),
              Text(
                codeQuestion,
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              DoYouKnowThisWidget(),
              const SizedBox(
                height: 24,
              )
            ],
          )),
    );
  }
}

class DoYouKnowThisWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Do you know this?',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              color: Colors.green,
              onPressed: () {},
              child: Text('YES',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              width: 24,
            ),
            FlatButton(
                color: Colors.red,
                onPressed: () {},
                child: Text('NO',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)))
          ],
        )
      ],
    );
  }
}
