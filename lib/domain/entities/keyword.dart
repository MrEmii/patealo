import 'dart:convert';

class Keyword {
  final String keyword;
  final String plural;
  Keyword({
    required this.keyword,
    required this.plural,
  });

  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
      'plural': plural,
    };
  }

  factory Keyword.fromMap(Map<String, dynamic> map) {
    return Keyword(
      keyword: map['keyword'] ?? '',
      plural: map['plural'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Keyword.fromJson(String source) => Keyword.fromMap(json.decode(source));
}
