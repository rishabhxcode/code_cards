import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/common/app_darwer.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/screens/new_card_screen.dart';
import 'package:code_cards/widgets/code_card_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper helper = DatabaseHelper();
  @override
  void initState() {
    BlocProvider.of<RandomCardsBloc>(context).add(RandomCardsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewCardScreen()));
            },
            child: Row(
              children: [
                Text('+',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 40,
                        fontWeight: FontWeight.w200)),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'New',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Center(child: BlocBuilder<RandomCardsBloc, RandomCardsState>(
          builder: (context, state) {
        if (state is RandomCardsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is RandomCardsLoadedState) {
          return CodeCardMain(
            card: state.codeCard,
          );
        }
        if (state is RandomCardsLoadFailedState) {
          return Center(child: Text("Something Went Wrong!!"));
        }
        return Container();
      })),
    );
  }
}
