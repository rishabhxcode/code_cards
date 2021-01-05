part of 'random_cards_bloc.dart';

abstract class RandomCardsState extends Equatable {
  const RandomCardsState();
   @override
  List<Object> get props => [];
}

class RandomCardsInitial extends RandomCardsState {}

class RandomCardsLoadingState extends RandomCardsState {}

class RandomCardsLoadedState extends RandomCardsState {
  final CodeCard codeCard;

  RandomCardsLoadedState({this.codeCard});
  @override
  List<Object> get props => [codeCard];
}

class RandomCardsLoadFailedState extends RandomCardsState {}
