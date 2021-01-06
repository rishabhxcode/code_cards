part of 'favorite_bloc.dart';

class UpdateFavoriteEvent extends Equatable {
  final bool fav;
  final int id;
  UpdateFavoriteEvent({@required this.fav, @required this.id});

  @override
  List<Object> get props => [fav];
}
