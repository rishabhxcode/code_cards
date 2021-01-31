import 'package:code_cards/bloc/add_new_card/add_new_card_bloc.dart';
import 'package:code_cards/constants/app_constants.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/helper/database_constants.dart' as db;
import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCardBlocWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NewCardBlocWidget({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddNewCardBloc(),
      child: NewCardScreen(
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}

class NewCardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NewCardScreen({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController _flipController;
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  final queSnack = SnackBar(
    content: Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text('Question Can\'t be empty!'),
      ],
    ),
  );
  final ansSnack = SnackBar(
    content: Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text('Answer Can\'t be empty!'),
      ],
    ),
  );

  final newCardSavedSnack = SnackBar(
    content: Row(
      children: [
        Icon(
          Icons.check,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text('New Card Saved!'),
      ],
    ),
  );

  Map<String, dynamic> newCard = {
    db.question: '',
    db.answer: '',
    db.tag: null,
    db.type: 'general',
    db.answeredCount: 0,
    db.appearCount: 0,
    db.fav: 0,
    db.known: 0,
    db.childTag: null
  };

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
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('New Question', style: TextStyle(color: Colors.black)),
        actions: [
          BlocListener<AddNewCardBloc, AddNewCardState>(
            listener: (context, state) {
              if (state is NewCardAddedState) {
                Navigator.of(context).pop();
                widget.scaffoldKey.currentState.showSnackBar(newCardSavedSnack);
              }
            },
            child: FlatButton(
              disabledTextColor: Colors.grey[500],
              textColor: mainColor,
              onPressed: () {
                newCard['${db.question}'] = questionController.text;
                newCard['${db.answer}'] = answerController.text;
                if (newCard['${db.question}'] == '') {
                  _scaffoldKey.currentState.showSnackBar(queSnack);
                } else if (newCard['${db.answer}'] == '') {
                  _scaffoldKey.currentState.showSnackBar(ansSnack);
                } else {
                  BlocProvider.of<AddNewCardBloc>(context)
                      .add(AddNewCardEvent(card: CodeCard.fromJson(newCard)));
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text('SAVE'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: FlipWidget(
            flipController: _flipController,
            front: FrontQuestion(
              onTagSelect: (val) {
                setState(() {
                  newCard['${db.tag}'] = val;
                });
              },
              onTypeSelect: (val) {
                setState(() {
                  newCard['${db.type}'] = val ?? db.general;
                  print('${newCard[db.type]}');
                });
              },
              tag: newCard['${db.tag}'] ?? 'none',
              type: newCard['${db.type}'] == ''
                  ? db.general
                  : newCard['${db.type}'],
              questionController: questionController,
              onSwapPressed: () {
                _flipController.isDismissed
                    ? _flipController.forward()
                    : _flipController.reverse();
              },
            ),
            back: BackAnswer(
              answerController: answerController,
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

class FrontQuestion extends StatelessWidget {
  final _border = OutlineInputBorder(borderSide: BorderSide.none);
  final TextEditingController questionController;
  final Function onSwapPressed;
  final Function(String) onTagSelect;
  final String tag;
  final String type;
  final Function(String) onTypeSelect;
  FrontQuestion(
      {Key key,
      this.onSwapPressed,
      this.questionController,
      this.onTagSelect,
      this.tag,
      this.type,
      this.onTypeSelect})
      : super(key: key);
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
            Row(
              children: [
                QTypeWidget(
                  type: type,
                  typeSelect: onTypeSelect,
                ),
                const Spacer(),
                tag == null || tag == 'none' || tag == ''
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(right: 4),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        child: Text(
                          tag,
                          style: TextStyle(
                              fontSize: 11,
                              color: mainColor,
                              fontWeight: FontWeight.w400),
                        ),
                        decoration: BoxDecoration(
                            color: mainColor15,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return TagChoices(
                            onSelected: onTagSelect,
                            tag: tag,
                          );
                        });
                  },
                  child: Icon(
                    Icons.sort_rounded,
                    size: 20,
                  ),
                ),
              ],
            ),
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

class BackAnswer extends StatelessWidget {
  final Function onSwapPressed;
  final TextEditingController answerController;
  final _border = OutlineInputBorder(borderSide: BorderSide.none);
  BackAnswer({Key key, this.onSwapPressed, this.answerController})
      : super(key: key);
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
  final String type;
  final Function(String) typeSelect;
  const QTypeWidget({Key key, this.type, this.typeSelect}) : super(key: key);
  @override
  _QTypeWidgetState createState() => _QTypeWidgetState();
}

class _QTypeWidgetState extends State<QTypeWidget> {
  String _value;
  @override
  void initState() {
    _value = widget.type ?? '${db.general}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ChoiceChip(
          selectedColor: mainColor60,
          labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11,
              color:
                  _value == '${db.general}' ? Colors.white : Colors.grey[500]),
          backgroundColor: Colors.grey[300],
          labelPadding: EdgeInsets.fromLTRB(4, -6, 4, -6),
          padding: EdgeInsets.fromLTRB(4, -6, 4, -6),
          onSelected: (selected) {
            setState(() {
              _value = selected ? '${db.general}' : null;
            });
            widget.typeSelect(_value);
          },
          selected: _value == '${db.general}',
          label: Text(
            '${db.general}',
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        ChoiceChip(
          selectedColor: mainColor60,
          backgroundColor: Colors.grey[300],
          labelStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11,
              color: _value == '${db.code}' ? Colors.white : Colors.grey[500]),
          labelPadding: EdgeInsets.fromLTRB(5, -6, 5, -6),
          padding: EdgeInsets.fromLTRB(5, -6, 5, -6),
          selected: _value == '${db.code}',
          label: Text(
            '${db.code}',
          ),
          onSelected: (selected) {
            setState(() {
              _value = selected ? '${db.code}' : null;
            });
            widget.typeSelect(_value);
          },
        )
      ],
    );
  }
}

class TagChoices extends StatefulWidget {
  final Function(String) onSelected;
  final String tag;
  const TagChoices({Key key, this.onSelected, this.tag}) : super(key: key);
  @override
  _TagChoicesState createState() => _TagChoicesState();
}

class _TagChoicesState extends State<TagChoices> {
  String _tag;

  @override
  void initState() {
    _tag = widget.tag ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: FractionallySizedBox(
          heightFactor: 0.5,
          widthFactor: 0.9,
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tags',
                    style: TextStyle(
                        color: mainColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 16),
                  ),
                  Divider(),
                  Wrap(
                    spacing: 4,
                    runSpacing: 6,
                    children: List.generate(
                        filterTags.length,
                        (index) => ChoiceChip(
                              selectedColor: mainColor15,
                              backgroundColor: Colors.grey[200],
                              labelPadding: EdgeInsets.all(0),
                              avatar: _tag == filterTags[index]
                                  ? Icon(
                                      Icons.check_rounded,
                                      color: mainColor,
                                      size: 18,
                                    )
                                  : null,
                              labelStyle: TextStyle(
                                  color: _tag == filterTags[index]
                                      ? mainColor
                                      : Colors.grey[600]),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              label: Text(filterTags[index]),
                              selected: _tag == filterTags[index],
                              onSelected: (val) {
                                setState(() {
                                  val
                                      ? _tag = filterTags[index]
                                      : _tag = 'none';
                                });
                              },
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ChoiceChip(
                      label: Text('None'),
                      selectedColor: mainColor15,
                      backgroundColor: Colors.grey[200],
                      labelPadding: EdgeInsets.all(0),
                      selected: _tag == 'none',
                      avatar: _tag == 'none'
                          ? Icon(
                              Icons.check_rounded,
                              color: mainColor,
                              size: 18,
                            )
                          : null,
                      labelStyle: TextStyle(
                          color: _tag == 'none' ? mainColor : Colors.grey[600]),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      onSelected: (val) {
                        setState(() {
                          val ? _tag = 'none' : _tag = 'none';
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        widget.onSelected(_tag);
                        print('TAG :: $_tag');
                        Navigator.of(context).pop();
                      },
                      color: mainColor,
                      icon: Icon(Icons.check_rounded),
                      iconSize: 40,
                    ),
                  )
                ],
              )),
        ));
  }
}
