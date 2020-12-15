import 'package:code_cards/widgets/flip_widget.dart';
import 'package:flutter/material.dart';

class NewCardScreen extends StatefulWidget {
  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('New Question', style: TextStyle(color: Colors.black)),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text('Save'),
          )
        ],
      ),
      body: Center(
        child: FlipWidget(
            flipController: _flipController,
            front: FrontQuestion(
              onSwapPressed: () {
                _flipController.isDismissed
                    ? _flipController.forward()
                    : _flipController.reverse();
              },
            ),
            back: BackAnswer(
              onSwapPressed: () {
                _flipController.isDismissed
                    ? _flipController.forward()
                    : _flipController.reverse();
              },
            )),
      ),
    );
  }
}

// ignore: must_be_immutable
class FrontQuestion extends StatelessWidget {
  final _border = OutlineInputBorder(borderSide: BorderSide.none);
  TextEditingController questionController = TextEditingController();
  final Function onSwapPressed;
  FrontQuestion({Key key, this.onSwapPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      child: Container(
        height: 300,
        width: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTypeWidget(),
            const Spacer(),
            TextField(
              controller: questionController,
              maxLines: 3,
              autofocus: true,
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              cursorColor: Colors.grey[800],
              cursorWidth: 1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                fillColor: Color(0xfff8f7ff),
                filled: true,
                enabledBorder: _border,
                border: _border,
                focusedBorder: _border,
                disabledBorder: _border,
                hintText: 'Question...',
                hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: onSwapPressed,
                icon: Icon(Icons.swap_horiz_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BackAnswer extends StatelessWidget {
  final Function onSwapPressed;
  TextEditingController answerController = TextEditingController();
  final _border = OutlineInputBorder(borderSide: BorderSide.none);
  BackAnswer({Key key, this.onSwapPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      child: Container(
        height: 300,
        width: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            TextField(
              autofocus: true,
              controller: answerController,
              maxLines: 5,
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              cursorColor: Colors.grey[800],
              cursorWidth: 1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                fillColor: Color(0xfff8f7ff),
                filled: true,
                enabledBorder: _border,
                border: _border,
                focusedBorder: _border,
                disabledBorder: _border,
                hintText: 'Answer...',
                hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onSwapPressed,
                icon: Icon(Icons.swap_horiz_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QTypeWidget extends StatefulWidget {
  @override
  _QTypeWidgetState createState() => _QTypeWidgetState();
}

class _QTypeWidgetState extends State<QTypeWidget> {
  String _value = 'general';
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ChoiceChip(
          selectedColor: Colors.purple[300],
          labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11,
              color: _value == 'general' ? Colors.white : Colors.grey[500]),
          backgroundColor: Colors.grey[300],
          labelPadding: EdgeInsets.fromLTRB(4, -6, 4, -6),
          padding: EdgeInsets.fromLTRB(4, -6, 4, -6),
          onSelected: (selected) {
            setState(() {
              _value = selected ? 'general' : null;
            });
          },
          selected: _value == 'general',
          label: Text(
            'general',
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        ChoiceChip(
          selectedColor: Colors.purple[300],
          backgroundColor: Colors.grey[300],
          labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11,
              color: _value == 'code' ? Colors.white : Colors.grey[500]),
          labelPadding: EdgeInsets.fromLTRB(5, -6, 5, -6),
          padding: EdgeInsets.fromLTRB(5, -6, 5, -6),
          selected: _value == 'code',
          label: Text(
            'code',
          ),
          onSelected: (selected) {
            setState(() {
              _value = selected ? 'code' : null;
            });
          },
        )
      ],
    );
  }
}
