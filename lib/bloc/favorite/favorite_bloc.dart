import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteUpdatedState> {
  FavoriteBloc() : super(FavoriteUpdatedState(fav: false));
  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<FavoriteUpdatedState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is UpdateFavEvent) {
      var fav = await helper.updateFav(event.fav, event.id);
      yield FavoriteUpdatedState(fav: fav);
    }
  }
}
