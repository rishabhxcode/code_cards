import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_card_event.dart';
part 'switch_card_state.dart';

class SwitchCardBloc extends Bloc<SwitchCardEvent, CardSwitchState> {
  SwitchCardBloc() : super(CardSwitchState(count: 0));
  int count = 0;

  @override
  Stream<CardSwitchState> mapEventToState(
    SwitchCardEvent event,
  ) async* {
    if (event is SwitchCardEvent) {
      count++;
      yield CardSwitchState(count: count);
    }
  }
}
