import 'package:test_gql/models/person.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_response.g.dart';

@JsonSerializable()
class PeopleResponse {
  PeopleResponse({
    this.people,
  });

  final List<Person>? people;

  factory PeopleResponse.fromJson(Map<String, dynamic> json) =>
      _$PeopleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PeopleResponseToJson(this);
}
