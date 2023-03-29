import 'package:json_annotation/json_annotation.dart';
import 'package:test_gql/models/person.dart';

part 'add_person_response.g.dart';

@JsonSerializable()
class AddPersonResponse {
  AddPersonResponse({
    required this.person,
  });

  @JsonKey(name: 'addPerson')
  final Person person;

  factory AddPersonResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPersonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddPersonResponseToJson(this);
}
