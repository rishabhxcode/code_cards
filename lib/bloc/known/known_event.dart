part of 'known_bloc.dart';

class KnownEvent extends Equatable {
  final bool isKnown;
  final int id;
  final bool initialTap;
  const KnownEvent({this.isKnown, this.id, this.initialTap});

  @override
  List<Object> get props => [isKnown, id];
}
