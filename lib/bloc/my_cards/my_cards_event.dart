part of 'my_cards_bloc.dart';

abstract class MyCardsEvent extends Equatable {
  const MyCardsEvent();

  @override
  List<Object> get props => [];
}

class MyCardsListLoadEvent extends MyCardsEvent {}

class MyCardDeleteEvent extends MyCardsEvent {
  final int id;
  MyCardDeleteEvent({this.id});
}
