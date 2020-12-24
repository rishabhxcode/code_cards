part of 'switch_card_bloc.dart';

class CardSwitchState extends Equatable {
  final int count;

  CardSwitchState({this.count});
  @override
  List<Object> get props => [count];
}
