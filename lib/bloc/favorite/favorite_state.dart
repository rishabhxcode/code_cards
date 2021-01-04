part of 'favorite_bloc.dart';

class FavoriteUpdatedState extends Equatable {
  final bool fav;
  FavoriteUpdatedState({this.fav});
  @override
  List<Object> get props => [fav];
}
