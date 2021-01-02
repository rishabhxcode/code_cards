part of 'filter_tags_bloc.dart';

abstract class FilterTagsState extends Equatable {
  const FilterTagsState();
  @override
  List<Object> get props => [];
}

class FilterTagsChangedState extends FilterTagsState {
  final List<String> filteredTags;

  FilterTagsChangedState({this.filteredTags});
  @override
  List<Object> get props => [filteredTags];
}

class FilterAllState extends FilterTagsState {}
