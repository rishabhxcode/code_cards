part of 'known_bloc.dart';

class KnownState extends Equatable {
  final bool isKnown;
  final bool initialTap;

  KnownState({@required this.isKnown, this.initialTap});
  @override
  List<Object> get props => [isKnown];
}
