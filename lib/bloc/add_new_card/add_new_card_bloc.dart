import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:equatable/equatable.dart';

part 'add_new_card_event.dart';
part 'add_new_card_state.dart';

class AddNewCardBloc extends Bloc<AddNewCardEvent, AddNewCardState> {
  AddNewCardBloc() : super(AddNewCardInitial());

  DatabaseHelper helper = DatabaseHelper();
  @override
  Stream<AddNewCardState> mapEventToState(
    AddNewCardEvent event,
  ) async* {
    if (event is AddNewCardEvent) {
      await helper.addNewCard(event.card);
      yield NewCardAddedState();
    }
  }
}
