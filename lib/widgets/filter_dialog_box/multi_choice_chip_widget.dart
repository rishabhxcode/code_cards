import 'package:code_cards/constants/app_constants.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:flutter/material.dart';

class MultiChoiceChipWidget extends StatefulWidget {
  final Function(List<String> selectedTags) getTags;
  final List<String> selectedtags;

  const MultiChoiceChipWidget({Key key, this.getTags, this.selectedtags})
      : super(key: key);
  @override
  _MultiChoiceChipWidgetState createState() => _MultiChoiceChipWidgetState();
}

class _MultiChoiceChipWidgetState extends State<MultiChoiceChipWidget> {
  List<String> selectedTags = [];
  bool _isAllSelected = true;
  @override
  void initState() {
    if (widget.selectedtags == null || widget.selectedtags.isEmpty) {
      _isAllSelected = true;
    } else {
      _isAllSelected = false;
    }
    selectedTags = widget.selectedtags ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AllChip(
          isAllSelected: _isAllSelected,
          onAllSelected: (val) {
            setState(() {
              selectedTags.clear();
              _isAllSelected = val;
            });
          },
        ),
        Wrap(
          children: filterTags.entries
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: ChoiceChip(
                      backgroundColor: Colors.grey[200],
                      selectedColor: mainColor15,
                      disabledColor: Colors.grey[100],
                      labelStyle: TextStyle(
                          color: selectedTags.contains(e.key)
                              ? mainColor80
                              : Colors.grey[600]),
                      avatar: selectedTags.contains(e.key)
                          ? Icon(
                              Icons.check_rounded,
                              color: mainColor,
                              size: 20,
                            )
                          : null,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      selected: selectedTags.contains(e.key),
                      label: Text(e.key),
                      onSelected: (choice) {
                        setState(() {
                          selectedTags.contains(e.key)
                              ? selectedTags.remove(e.key)
                              : selectedTags.add(e.key);
                          widget.getTags(selectedTags);
                          _isAllSelected = false;
                        });
                      },
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class AllChip extends StatefulWidget {
  final Function(bool) onAllSelected;
  final bool isAllSelected;

  const AllChip({Key key, this.onAllSelected, this.isAllSelected})
      : super(key: key);
  @override
  _AllChipState createState() => _AllChipState();
}

class _AllChipState extends State<AllChip> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
        backgroundColor: Colors.grey[200],
        selected: widget.isAllSelected,
        label: Text('All'),
        selectedColor: mainColor15,
        labelStyle: TextStyle(
            color: widget.isAllSelected ? mainColor80 : Colors.grey[600]),
        labelPadding: EdgeInsets.symmetric(horizontal: 16),
        avatar: widget.isAllSelected
            ? Icon(
                Icons.check_rounded,
                color: mainColor,
                size: 20,
              )
            : null,
        onSelected: widget.onAllSelected);
  }
}
