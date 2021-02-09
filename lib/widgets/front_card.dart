import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_cards/bloc/known/known_bloc.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrontCard extends StatelessWidget {
  final CodeCard card;
  const FrontCard({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_rounded,
                    color: Colors.grey[500],
                    size: 14,
                  ),
                  Text(' ${card.appearCount}',
                      style: TextStyle(color: Colors.grey, fontSize: 12))
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.cyan[50],
                        border:
                            Border.all(width: 0.5, color: Colors.cyan[400])),
                    child: Text(card.type,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    margin: EdgeInsets.only(left: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: mainColor10,
                        border: Border.all(width: 0.5, color: mainColor50)),
                    child: Text(card.tag,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic)),
                  ),
                  const Spacer(),
                  FavoriteButton(
                    id: card.id,
                    fav: card.fav,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Flexible(flex: 2,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: AutoSizeText(
                      card.question,
                      maxLines: 10,
                      minFontSize: 14,
                      maxFontSize: 18,
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Spacer(),
              DoYouKnowThisWidget(
                id: card.id,
              ),
              const SizedBox(
                height: 18,
              )
            ],
          )),
    );
  }
}

class DoYouKnowThisWidget extends StatelessWidget {
  final int id;

  const DoYouKnowThisWidget({Key key, this.id}) : super(key: key);
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
        BlocBuilder<KnownBloc, KnownState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                YesButton(
                  isKnown: state.isKnown,
                  id: id,
                  initialTap: state.initialTap,
                ),
                const SizedBox(
                  width: 24,
                ),
                NoButton(
                  isKnown: state.isKnown,
                  id: id,
                  initialTap: state.initialTap,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class NoButton extends StatelessWidget {
  final bool isKnown;
  final int id;
  final bool initialTap;

  const NoButton({Key key, this.isKnown, this.id, this.initialTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Colors.red,
        onPressed: () {
          BlocProvider.of<KnownBloc>(context)
              .add(KnownEvent(isKnown: false, id: id, initialTap: true));
        },
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 4),
                child: isKnown
                    ? Container()
                    : initialTap
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          )
                        : Container()),
            Text('NO',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ));
  }
}

class YesButton extends StatelessWidget {
  final bool isKnown;
  final int id;
  final bool initialTap;

  const YesButton({Key key, this.isKnown, this.id, this.initialTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.green,
      onPressed: () {
        BlocProvider.of<KnownBloc>(context)
            .add(KnownEvent(isKnown: true, id: id, initialTap: true));
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: isKnown
                ? initialTap
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      )
                    : Container()
                : Container(),
          ),
          Text('YES',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
