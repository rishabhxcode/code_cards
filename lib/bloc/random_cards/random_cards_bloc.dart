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
  List<String> currentFilters = [];
  int index = 0;
  @override
  Stream<RandomCardsState> mapEventToState(
    RandomCardsEvent event,
  ) async* {
    if (event is RandomCardsLoadEvent) {
      try {
        cards.clear();
        currentFilters = event.filters;
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
      //? Uncomment below for viewing the list
      // cards.forEach((element) {
      //   print("element-> $element \n");
      // });

      if (cards.length <= 4) {
        var card = await _loadRandomCard();
        yield RandomCardsLoadedState(codeCard: card);
      }
      print('${cards[index].id} ${cards[index].star}');
      yield RandomCardsLoadedState(codeCard: cards[index]);
    }
    if (event is RandomCardUpdated) {
      //TODO: Update this code whenever you find optimized approach!
      for (int i = 0; i < cards.length; i++) {
        if (cards[i].id == event.card.id) {
          cards[i] = event.card;
        }
      }
    }
  }

  Future<CodeCard> _loadRandomCard() async {
    var newCards = await helper.getRandomCards(filters: currentFilters);
    cards.addAll(newCards);
    return cards[index];
  }
}
