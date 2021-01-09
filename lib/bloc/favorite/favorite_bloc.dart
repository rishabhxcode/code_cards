import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<UpdateFavoriteEvent, FavoriteUpdateState> {
  final RandomCardsBloc randomCardBloc;
  final bool fav;
  FavoriteBloc({
    @required this.fav,
    @required this.randomCardBloc,
  }) : super(FavoriteUpdateState(fav: fav));
  DatabaseHelper helper = DatabaseHelper();
  @override
  Stream<FavoriteUpdateState> mapEventToState(
    UpdateFavoriteEvent event,
  ) async* {
    if (event is UpdateFavoriteEvent) {
      CodeCard updatedCard = await helper.updateFav(event.fav, event.id);
      randomCardBloc.add(RandomCardUpdated(updatedCard));
      yield FavoriteUpdateState(fav: updatedCard.fav);
    }
  }
}
