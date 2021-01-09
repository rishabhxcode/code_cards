import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'known_event.dart';
part 'known_state.dart';

class KnownBloc extends Bloc<KnownEvent, KnownState> {
  final RandomCardsBloc randomCardBloc;
  final bool isKnown;
  KnownBloc({@required this.isKnown, @required this.randomCardBloc})
      : super(KnownState(isKnown: isKnown, initialTap: false));

  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<KnownState> mapEventToState(
    KnownEvent event,
  ) async* {
    if (event is KnownEvent) {
      CodeCard updatedCard = await helper.updateKnown(event.isKnown, event.id);
      randomCardBloc.add(RandomCardUpdated(updatedCard));
      yield KnownState(
          isKnown: updatedCard.known, initialTap: event.initialTap);
    }
  }
}
