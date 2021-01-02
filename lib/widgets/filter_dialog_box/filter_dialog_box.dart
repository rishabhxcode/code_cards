import 'package:code_cards/bloc/filter_tags/filter_tags_bloc.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/widgets/filter_dialog_box/multi_choice_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialogBox extends StatefulWidget {
  //TODO: Fix Render OverFlow Problem
  @override
  _FilterDialogBoxState createState() => _FilterDialogBoxState();
}

class _FilterDialogBoxState extends State<FilterDialogBox>
    with SingleTickerProviderStateMixin {
  AnimationController sizeAnimation;
  Animation<double> vertFactor;
  Animation<double> horiFactor;

  List<String> selectedTags = [];

  @override
  void initState() {
    sizeAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    horiFactor = CurvedAnimation(
        parent: sizeAnimation,
        curve: Interval(0, 0.4, curve: Curves.easeOutCubic));
    vertFactor = CurvedAnimation(
        parent: sizeAnimation,
        curve: Interval(0.5, 1.0, curve: Curves.easeOutBack));
    Future.delayed(Duration(milliseconds: 100), () {
      sizeAnimation.forward();
    });
    super.initState();
  }

  bool choiceSelected = false;

  @override
  Widget build(BuildContext context) {
    var scrnWidth = MediaQuery.of(context).size.width;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 450,
        width: scrnWidth,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Container(
          height: 420 * vertFactor.value + 2,
          width: scrnWidth * horiFactor.value,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 2),
                    blurRadius: 8.0,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8 * vertFactor.value),
              border: Border.all(width: 1.0, color: Colors.white),
              color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, top: 8, bottom: 6),
                child: Text(
                  'Filter Tags',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              BlocBuilder<FilterTagsBloc, FilterTagsState>(
                builder: (context, state) {
                  if (state is FilterTagsChangedState) {
                    selectedTags = state.filteredTags;
                    return MultiChoiceChipWidget(
                      selectedtags: state.filteredTags,
                      getTags: (tags) {
                        selectedTags = tags;
                        print(" T A G S ");
                        print(selectedTags);
                      },
                    );
                  } else {
                    return MultiChoiceChipWidget(
                      selectedtags: null,
                      getTags: (tags) {
                        selectedTags = tags;
                        print(" T A G S ");
                        print(selectedTags);
                      },
                    );
                  }
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12, right: 16),
                  child: IconButton(
                    icon: Icon(
                      Icons.check_rounded,
                      size: 40,
                      color: mainColor,
                    ),
                    onPressed: () async {
                      await sizeAnimation.reverse();
                      if (selectedTags.isEmpty || selectedTags == null) {
                        BlocProvider.of<FilterTagsBloc>(context)
                            .add(FilterAllEvent());
                      } else {
                        BlocProvider.of<FilterTagsBloc>(context).add(
                            FilterTagsChangeEvent(filteredTags: selectedTags));
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
