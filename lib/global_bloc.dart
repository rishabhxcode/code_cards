import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBloc extends StatelessWidget {
  final Widget child;

  const GlobalBloc({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RandomCardsBloc()),
      ],
      child: child,
    );
  }
}
