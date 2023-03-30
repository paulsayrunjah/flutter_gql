import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  Person({this.id, this.name, this.image});

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? image;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
