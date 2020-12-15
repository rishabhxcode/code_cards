import 'package:code_cards/model/code_card.dart';

class QuestionRepo {
  CodeCard getQuestion() {
    return CodeCard(
        answer: 'ANSWER',
        question: 'WHAT IS BUBBLE SORT?',
        type: 'general',
        isKnown: false);
  }
}
