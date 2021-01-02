import 'package:code_cards/bloc/filter_tags/filter_tags_bloc.dart';
import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/common/app_darwer.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/screens/new_card_screen.dart';
import 'package:code_cards/widgets/current_selected_filters.dart';
import 'package:code_cards/widgets/filter_dialog_box/filter_dialog_box.dart';
import 'package:code_cards/widgets/full_card.dart';
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
                        color: mainColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w200)),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'New',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: BlocBuilder<FilterTagsBloc, FilterTagsState>(
                      builder: (context, state) {
                    if (state is FilterTagsChangedState) {
                      return CurrentSelectedFiltersWidget(
                          filteredTags: state.filteredTags);
                    } else {
                      return CurrentSelectedFiltersWidget(
                        filteredTags: [],
                      );
                    }
                  })),
                  IconButton(
                    icon: Icon(Icons.sort_rounded),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            // TODO: Check and Clean FilterTagsBloc
                            return FilterDialogBox();
                          }).whenComplete(() => setState(() {}));
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: BlocBuilder<RandomCardsBloc, RandomCardsState>(
                builder: (context, state) {
              if (state is RandomCardsLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is RandomCardsLoadedState) {
                return FullCard(
                  card: state.codeCard,
                );
              }
              if (state is RandomCardsLoadFailedState) {
                return Center(child: Text("Something Went Wrong!!"));
              }
              return Container();
            }),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
