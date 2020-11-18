import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String generalQuestion;
  final String codeQuestion;
  final bool isGeneralKnown;
  final bool isCodeKnown;
  Question({
    this.generalQuestion,
    this.codeQuestion,
    this.isGeneralKnown,
    this.isCodeKnown,
  });
  @override
  List<Object> get props =>
      [generalQuestion, codeQuestion, isGeneralKnown, isCodeKnown];
}
