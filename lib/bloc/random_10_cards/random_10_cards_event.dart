part of 'random_10_cards_bloc.dart';

abstract class Random10CardsEvent extends Equatable {
  const Random10CardsEvent();
}

class Random10CardsLoadEvent extends Random10CardsEvent {
  @override
  List<Object> get props => [];
}
