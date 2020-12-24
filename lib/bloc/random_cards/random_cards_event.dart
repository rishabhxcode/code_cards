part of 'random_cards_bloc.dart';

abstract class RandomCardsEvent extends Equatable {
  const RandomCardsEvent();
  @override
  List<Object> get props => [];
}

class RandomCardsLoadEvent extends RandomCardsEvent {
}

class LoadNextRandomCard extends RandomCardsEvent {
}