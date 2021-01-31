import 'package:code_cards/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:code_cards/constants/app_constants.dart' as appCons;

class CurrentSelectedFiltersWidget extends StatelessWidget {
  final List<String> filteredTags;

  const CurrentSelectedFiltersWidget({Key key, this.filteredTags})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: filteredTags == null || filteredTags.isEmpty
            ? Wrap(
                children: [
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: mainColor15,
                    label: Text(
                      'All',
                      style: TextStyle(fontSize: 12, color: mainColor80),
                    ),
                    labelPadding: EdgeInsets.fromLTRB(0, -4, 0, -4),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 00),
                  ),
                ],
              )
            : Wrap(
                children: List.generate(
                    filteredTags.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          child: Chip(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: mainColor15,
                            label: Text(
                              appCons.filterTags[filteredTags[index]],
                              style:
                                  TextStyle(fontSize: 12, color: mainColor80),
                            ),
                            labelPadding: EdgeInsets.fromLTRB(0, -4, 0, -4),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 00),
                          ),
                        ))));
  }
}
