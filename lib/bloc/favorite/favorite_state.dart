part of 'favorite_bloc.dart';

class FavoriteUpdateState extends Equatable {
  final bool fav;
  FavoriteUpdateState({@required this.fav});
  @override
  List<Object> get props => [fav];
}
