import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/global_bloc.dart';
import 'package:code_cards/screens/favorite_cards_list_screen.dart';
import 'package:code_cards/screens/home_screen.dart';
import 'package:code_cards/screens/my_cards_list_screen.dart';
import 'package:code_cards/screens/statistics_screen.dart';
import 'package:code_cards/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/filter_tags/filter_tags_bloc.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalBloc(
      child: MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (cotext) => FilterTagsBloc(context.read<RandomCardsBloc>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.defaultTheme,
        home: HomeScreen(),
        routes: {
          FavoriteCardsListScreen.routeName: (context) =>
              FavoriteCardsListScreen(),
          MyCardsListScreen.routeName: (context) => MyCardsListScreen(),
          StatisticsScreen.routeName: (context) => StatisticsScreen()
        },
      ),
    );
  }
}
