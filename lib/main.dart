import 'package:code_cards/global_bloc.dart';
import 'package:code_cards/screens/favorite_cards_list_screen.dart';
import 'package:code_cards/screens/home_screen.dart';
import 'package:code_cards/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalBloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.defaultTheme,
        home: HomeScreen(),
        routes: {
          FavoriteCardsListScreen.routeName: (context) =>
              FavoriteCardsListScreen()
        },
      ),
    );
  }
}
