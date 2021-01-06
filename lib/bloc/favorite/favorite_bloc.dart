import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<UpdateFavoriteEvent, FavoriteUpdateState> {
  final bool fav;
  FavoriteBloc({@required this.fav}) : super(FavoriteUpdateState(fav: fav));
  DatabaseHelper helper = DatabaseHelper();
  @override
  Stream<FavoriteUpdateState> mapEventToState(
    UpdateFavoriteEvent event,
  ) async* {
    if (event is UpdateFavoriteEvent) {
      var fav = await helper.updateFav(event.fav, event.id);
      print('S U C C E S S $fav');
      yield FavoriteUpdateState(fav: fav);
    }
  }
}
