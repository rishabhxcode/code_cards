import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_tags_event.dart';
part 'filter_tags_state.dart';

class FilterTagsBloc extends Bloc<FilterTagsEvent, FilterTagsState> {
  final RandomCardsBloc randomCardsBloc;
  FilterTagsBloc(this.randomCardsBloc) : super(FilterAllState());

  @override
  Stream<FilterTagsState> mapEventToState(
    FilterTagsEvent event,
  ) async* {
    if (event is FilterTagsChangeEvent) {
      yield FilterTagsChangedState(filteredTags: event.filteredTags);
      randomCardsBloc.add(RandomCardsLoadEvent(filters: event.filteredTags));
    }
    if (event is FilterAllEvent) {
      yield FilterAllState();
    }
  }
}
