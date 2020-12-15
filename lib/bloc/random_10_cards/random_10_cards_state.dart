part of 'random_10_cards_bloc.dart';

abstract class Random10CardsState extends Equatable {
  const Random10CardsState();
}

class Random10CardsInitial extends Random10CardsState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Random10CardsLoadingState extends Random10CardsState {
  @override
  List<Object> get props => [];
}

class Random10CardsLoadedState extends Random10CardsState {
  final List<CodeCard> codeCards;

  Random10CardsLoadedState({this.codeCards});
  @override
  List<Object> get props => [codeCards];
}

class Random10CardsLoadFailedState extends Random10CardsState {
  @override
  List<Object> get props => [];
}
