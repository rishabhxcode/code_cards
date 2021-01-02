part of 'filter_tags_bloc.dart';

abstract class FilterTagsEvent extends Equatable {
  const FilterTagsEvent();
  @override
  List<Object> get props => [];
}

class FilterTagsChangeEvent extends FilterTagsEvent {
  final List<String> filteredTags;
  FilterTagsChangeEvent({this.filteredTags});

  @override
  List<Object> get props => [filteredTags];
}

class FilterAllEvent extends FilterTagsEvent {}
