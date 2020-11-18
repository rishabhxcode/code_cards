import 'package:code_cards/common/app_darwer.dart';
import 'package:code_cards/widgets/code_card_main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Center(child: CodeCardMain()),
    );
  }
}
