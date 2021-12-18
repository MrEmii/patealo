import 'dart:convert';

import 'package:patealo/domain/abstracts/entity.dart';
import 'package:patealo/domain/entities/keyword.dart';

class Pictogram extends Entity {
  final String url;
  final List<Keyword> keywords;
  final List<String> categories;
  final List<String> tags;

  Pictogram(int id, this.url, this.keywords, this.categories, this.tags) : super(id);

  Map<String, dynamic> toMap() => {
        'id': id,
        'url': url,
        'keywords': jsonEncode(keywords.map((keyword) => keyword.toMap()).toList()),
        'categories': jsonEncode(categories),
      };

  factory Pictogram.fromMap(Map<String, dynamic> map) {
    return Pictogram(
      map['_id'],
      "https://api.arasaac.org/api/pictograms/${map['_id']}",
      map['keywords'].map<Keyword>((keyword) => Keyword.fromMap(keyword)).toList(),
      map['categories'].map<String>((category) => category.toString()).toList(),
      map['tags'].map<String>((tag) => tag.toString()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pictogram.fromJson(String source) => Pictogram.fromMap(json.decode(source));
}
