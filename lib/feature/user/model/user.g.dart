// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..emailAddress = json['emailAddress'] as String?
  ..enabled = json['enabled'] as bool?
  ..registered = json['registered'] as bool?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'enabled': instance.enabled,
      'registered': instance.registered,
    };
