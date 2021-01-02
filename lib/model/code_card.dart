import 'package:equatable/equatable.dart';

class CodeCard extends Equatable {
  final int id;
  final String question;
  final String answer;
  final String type;
  final String tag;
  final int appearCount;
  final int unAnsweredCount;
  final String childTag;
  final bool star;
  final bool isKnown;

  CodeCard({
    this.id,
    this.tag,
    this.appearCount,
    this.unAnsweredCount,
    this.childTag,
    this.question,
    this.answer,
    this.type,
    this.isKnown = false,
    this.star = false,
  });

  static CodeCard fromJson(Map<String, dynamic> json) {
    return CodeCard(
      answer: json['answer'],
      appearCount: json['appear_count'],
      childTag: json['child_tag'],
      id: json['id'],
      question: json['question'],
      tag: json['tag'],
      type: json['type'],
      unAnsweredCount: json['un_answered_count'],
      isKnown: json['is_known'] == 0 ? false : true,
      star: json['star'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'appear_count': appearCount,
      'tag': tag,
      'type': type,
      'un_answered_count': unAnsweredCount,
      'child_tag': childTag,
      'is_known': isKnown == false ? 0 : 1,
      'star': star == false ? 0 : 1,
    };
  }

  @override
  List<Object> get props => [id, question, answer];

  @override 
  toString()=> "id: ${this.id}, tag: ${this.tag},";
}
