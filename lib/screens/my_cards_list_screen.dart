import 'package:code_cards/bloc/my_cards/my_cards_bloc.dart';
import 'package:code_cards/common/card_list_item.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCardsListScreen extends StatelessWidget {
  static final String routeName = '/my_cards_list_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyCardsBloc(),
      child: MyCardsListWidget(),
    );
  }
}

class MyCardsListWidget extends StatefulWidget {
  @override
  _MyCardsListWidgetState createState() => _MyCardsListWidgetState();
}

class _MyCardsListWidgetState extends State<MyCardsListWidget> {
  DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    BlocProvider.of<MyCardsBloc>(context).add(MyCardsListLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.web_asset_rounded,
              color: Colors.deepOrange,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'My Cards',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: BlocBuilder<MyCardsBloc, MyCardsState>(
        builder: (context, state) {
          if (state is MyCardsListLoadedState) {
            print('CARDS Length:: ${state.cards.length}');
            return state.cards.length != 0
                ? ListView.builder(
                    itemCount: state.cards.length,
                    itemBuilder: (context, index) {
                      return CardListItem(
                          card: state.cards[index],
                          trailing: PopupMenuButton(
                              onSelected: (val) {
                                BlocProvider.of<MyCardsBloc>(context).add(
                                    MyCardDeleteEvent(
                                        id: state.cards[index].id));
                              },
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete_rounded,
                                            size: 20,
                                          ),
                                          Text('Delete')
                                        ],
                                      ),
                                    )
                                  ]));
                    })
                : Center(
                    child: Text(
                      'You haven\'t added any card yet!',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
