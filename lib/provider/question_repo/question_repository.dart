import 'package:code_cards/model/question.dart';

class QuestionRepo {
  Question getQuestion() {
    return Question(
      codeQuestion: '<xcode>',
      generalQuestion: 'What is Bubble Sort?',
      isGeneralKnown: false,
      isCodeKnown: false,
    );
  }
}
