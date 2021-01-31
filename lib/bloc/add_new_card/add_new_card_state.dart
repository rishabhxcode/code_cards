part of 'add_new_card_bloc.dart';

abstract class AddNewCardState extends Equatable {
  const AddNewCardState();

  @override
  List<Object> get props => [];
}

class AddNewCardInitial extends AddNewCardState {}

class NewCardAddedState extends AddNewCardState {}
