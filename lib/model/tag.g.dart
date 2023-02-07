// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Tag _$$_TagFromJson(Map<String, dynamic> json) => _$_Tag(
      id: json['id'] as String,
      tagName: json['tagName'] as String,
      userId: json['userId'] ?? "",
      addDate: json['addDate'] == null
          ? null
          : DateTime.parse(json['addDate'] as String),
    );

Map<String, dynamic> _$$_TagToJson(_$_Tag instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
      'userId': instance.userId,
      'addDate': instance.addDate?.toIso8601String(),
    };
