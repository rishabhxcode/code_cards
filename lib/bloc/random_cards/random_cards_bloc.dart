import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:equatable/equatable.dart';

part 'random_cards_event.dart';
part 'random_cards_state.dart';

class RandomCardsBloc extends Bloc<RandomCardsEvent, RandomCardsState> {
  RandomCardsBloc() : super(RandomCardsInitial());

  DatabaseHelper helper = DatabaseHelper();
  List<CodeCard> cards = [];
  int index = 0;
  @override
  Stream<RandomCardsState> mapEventToState(
    RandomCardsEvent event,
  ) async* {
    if (event is RandomCardsLoadEvent) {
      try {
        yield RandomCardsLoadingState();
        var card = await _loadRandomCard();
        yield RandomCardsLoadedState(codeCard: card);
      } catch (e) {
        print(e);
        yield RandomCardsLoadFailedState();
      }
    }
    if (event is LoadNextRandomCard) {
      cards.removeAt(index);
      if (cards.length <= 4) {
        var card = await _loadRandomCard();
        yield RandomCardsLoadedState(codeCard: card);
      }
      yield RandomCardsLoadedState(codeCard: cards[index]);
    }
  }

  Future<CodeCard> _loadRandomCard() async {
    var newCards = await helper.getRandomCards();
    cards.addAll(newCards);
    return cards[index];
  }
}
