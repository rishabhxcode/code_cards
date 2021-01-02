part of 'random_cards_bloc.dart';

abstract class RandomCardsEvent extends Equatable {
  const RandomCardsEvent();
  @override
  List<Object> get props => [];
}

class RandomCardsLoadEvent extends RandomCardsEvent {
  final List<String> filters;

  RandomCardsLoadEvent({this.filters = const []});
  @override
  List<Object> get props => [filters];
}

class LoadNextRandomCard extends RandomCardsEvent {
}