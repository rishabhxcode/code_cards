import 'package:code_cards/bloc/random_10_cards/random_10_cards_bloc.dart';
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
    BlocProvider.of<Random10CardsBloc>(context).add(Random10CardsLoadEvent());
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
      body: Center(child: BlocBuilder<Random10CardsBloc, Random10CardsState>(
          builder: (context, state) {
        if (state is Random10CardsLoadedState) {
          return CodeCardMain(
            card: state.codeCards[0],
          );
        }
        return Center(child: Text("Something Went Wrong!!"));
      })),
    );
  }
}
