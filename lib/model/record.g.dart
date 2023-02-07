// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      id: json['id'] as String,
      title: json['title'] as String,
      recipeUrl: json['recipeUrl'] as String? ?? "",
      memo: json['memo'] as String? ?? "",
      isOpen: json['isOpen'] as bool? ?? false,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String? ?? "",
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      likeUserIds: (json['likeUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userId: json['userId'] as String? ?? "",
      userName: json['userName'] as String? ?? "",
      userImgUrl: json['userImgUrl'] as String? ?? "",
      registerDate: json['registerDate'] == null
          ? null
          : DateTime.parse(json['registerDate'] as String),
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'recipeUrl': instance.recipeUrl,
      'memo': instance.memo,
      'isOpen': instance.isOpen,
      'date': instance.date?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'likeUserIds': instance.likeUserIds,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImgUrl': instance.userImgUrl,
      'registerDate': instance.registerDate?.toIso8601String(),
      'isDone': instance.isDone,
    };
