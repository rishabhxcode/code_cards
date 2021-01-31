part of 'my_cards_bloc.dart';

abstract class MyCardsState extends Equatable {
  const MyCardsState();

  @override
  List<Object> get props => [];
}

class MyCardsInitial extends MyCardsState {}

class MyCardsListLoadedState extends MyCardsState {
  final List<CodeCard> cards;

  MyCardsListLoadedState({this.cards});
  @override
  List<Object> get props => [cards];
}
