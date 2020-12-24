
import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/swtich_card/switch_card_bloc.dart';

class GlobalBloc extends StatelessWidget {
  final Widget child;

  const GlobalBloc({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
<<<<<<< HEAD
        BlocProvider(create: (context) => Random10CardsBloc()),
        BlocProvider(create: (context) => SwitchCardBloc()),
=======
        BlocProvider(create: (context) => RandomCardsBloc()),
      
>>>>>>> 957c9aad988dd358d2109204995afc8d0b4cd608
      ],
      child: child,
    );
  }
}
