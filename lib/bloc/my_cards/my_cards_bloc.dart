import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:equatable/equatable.dart';

part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  MyCardsBloc() : super(MyCardsInitial());
  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<MyCardsState> mapEventToState(
    MyCardsEvent event,
  ) async* {
    if (event is MyCardsListLoadEvent) {
      var cards = await helper.getMyCards();
      yield MyCardsListLoadedState(cards: cards);
    }
    if (event is MyCardDeleteEvent) {
      await helper.deleteMyCard(event.id);
      var cards = await helper.getMyCards();
      yield MyCardsListLoadedState(cards: cards);
    }
  }
}
