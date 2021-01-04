part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object> get props => [];
}

class UpdateFavEvent extends FavoriteEvent {
  final bool fav;
  final int id;

  UpdateFavEvent({this.id, this.fav});
  @override
  List<Object> get props => [fav, id];
}
