import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/question.dart';
import 'package:equatable/equatable.dart';

part 'random_10_cards_event.dart';
part 'random_10_cards_state.dart';

class Random10CardsBloc extends Bloc<Random10CardsEvent, Random10CardsState> {
  Random10CardsBloc() : super(Random10CardsInitial());

  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<Random10CardsState> mapEventToState(
    Random10CardsEvent event,
  ) async* {
    if (event is Random10CardsEvent) {
      try {
        yield Random10CardsLoadingState();
        List<CodeCard> cards = await helper.get10RandomCards();
        yield Random10CardsLoadedState(codeCards: cards);
      } catch (e) {
        yield Random10CardsLoadFailedState();
      }
    }
  }
}
