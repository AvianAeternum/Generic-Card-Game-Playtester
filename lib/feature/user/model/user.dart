/*
 * Copyright (c) 2022-2023. MyGuide
 *
 * MyGuide is a closed source project developed by Arcane Arts.
 * Do not copy, share, distribute or otherwise allow this source file
 * to leave hardware approved by Arcane Arts unless otherwise
 * approved by Arcane Arts.
 */

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User with EquatableMixin {
  @JsonKey(ignore: true)
  String? uid;
  String? firstName;
  String? lastName;
  String? emailAddress;
  bool? enabled;
  bool? registered;

  User();

  String fullName() => "${firstName ?? "Unknown User"} ${lastName ?? ""}";

  String first() => (firstName ?? "Unknown User");

  @override
  List<Object?> get props => [
        uid,
        firstName,
        registered,
        lastName,
        emailAddress,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String getName() => "${emailAddress ?? ""} ${fullName()}";
}
