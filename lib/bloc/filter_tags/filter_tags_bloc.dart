import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_tags_event.dart';
part 'filter_tags_state.dart';

class FilterTagsBloc extends Bloc<FilterTagsEvent, FilterTagsState> {
  FilterTagsBloc() : super(FilterAllState());

  @override
  Stream<FilterTagsState> mapEventToState(
    FilterTagsEvent event,
  ) async* {
    if (event is FilterTagsChangeEvent) {
      yield FilterTagsChangedState(filteredTags: event.filteredTags);
    }
    if (event is FilterAllEvent) {
      yield FilterAllState();
    }
  }
}
