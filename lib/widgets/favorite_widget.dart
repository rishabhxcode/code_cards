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
  bool _fav;

  @override
  void initState() {
    _fav = widget.fav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteUpdateState>(
      builder: (context, state) {
        print('FAV - ${state.fav}');
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
            _fav = !_fav;
            BlocProvider.of<FavoriteBloc>(context)
                .add(UpdateFavoriteEvent(fav: _fav, id: widget.id));
          },
        );
      },
    );
  }
}
