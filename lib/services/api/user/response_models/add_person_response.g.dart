// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPersonResponse _$AddPersonResponseFromJson(Map<String, dynamic> json) =>
    AddPersonResponse(
      person: Person.fromJson(json['addPerson'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddPersonResponseToJson(AddPersonResponse instance) =>
    <String, dynamic>{
      'addPerson': instance.person,
    };
