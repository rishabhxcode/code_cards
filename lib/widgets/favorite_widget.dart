import 'package:code_cards/bloc/favorite/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final int id;
  final bool fav;
  FavoriteButton({Key key, this.id, this.fav}) : super(key: key);
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteUpdatedState>(
      builder: (context, state) {
        return IconButton(
          padding: EdgeInsets.all(0),
          icon: state.fav
              ? Icon(
                  Icons.star_rounded,
                  color: Colors.yellow[800],
                  size: 30,
                )
              : Icon(
                  Icons.star_outline_rounded,
                  color: Colors.grey[500],
                  size: 30,
                ),
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context)
                .add(UpdateFavEvent(fav: !state.fav, id: widget.id));
          },
        );
      },
    );
  }
}
