import 'package:code_cards/helper/database_constants.dart' as db;
import 'package:equatable/equatable.dart';

class CodeCard extends Equatable {
  final int id;
  final String question;
  final String answer;
  final String type;
  final String tag;
  final int appearCount;
  final int answeredCount;
  final String childTag;
  final bool fav;
  final bool known;

  CodeCard({
    this.id,
    this.tag,
    this.appearCount,
    this.answeredCount,
    this.childTag,
    this.question,
    this.answer,
    this.type,
    this.known = false,
    this.fav = false,
  });

  static CodeCard fromJson(Map<String, dynamic> json) {
    return CodeCard(
      answer: json[db.answer],
      appearCount: json[db.appearCount],
      childTag: json[db.childTag],
      id: json[db.id],
      question: json[db.question],
      tag: json[db.tag],
      type: json[db.type],
      answeredCount: json[db.answeredCount],
      known: json[db.known] == 0 ? false : true,
      fav: json[db.fav] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      db.id: id,
      db.question: question,
      db.answer: answer,
      db.appearCount: appearCount,
      db.tag: tag,
      db.type: type,
      db.answeredCount: answeredCount,
      db.childTag: childTag,
      db.known: known == false ? 0 : 1,
      db.fav: fav == false ? 0 : 1,
    };
  }

  @override
  List<Object> get props => [id, question, answer];

  @override
  toString() =>
      "${db.id}: ${this.id}, ${db.tag}: ${this.tag}, ${db.fav}: ${this.fav}";
}
