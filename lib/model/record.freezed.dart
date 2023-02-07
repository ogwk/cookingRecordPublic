// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
mixin _$Record {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get recipeUrl => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  bool get isOpen => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;
  List<String> get likeUserIds => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userImgUrl => throw _privateConstructorUsedError;
  DateTime? get registerDate => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res, Record>;
  @useResult
  $Res call(
      {String id,
      String title,
      String recipeUrl,
      String memo,
      bool isOpen,
      DateTime? date,
      String imageUrl,
      List<Tag> tags,
      List<String> likeUserIds,
      String userId,
      String userName,
      String userImgUrl,
      DateTime? registerDate,
      bool isDone});
}

/// @nodoc
class _$RecordCopyWithImpl<$Res, $Val extends Record>
    implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? recipeUrl = null,
    Object? memo = null,
    Object? isOpen = null,
    Object? date = freezed,
    Object? imageUrl = null,
    Object? tags = null,
    Object? likeUserIds = null,
    Object? userId = null,
    Object? userName = null,
    Object? userImgUrl = null,
    Object? registerDate = freezed,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      recipeUrl: null == recipeUrl
          ? _value.recipeUrl
          : recipeUrl // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      likeUserIds: null == likeUserIds
          ? _value.likeUserIds
          : likeUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImgUrl: null == userImgUrl
          ? _value.userImgUrl
          : userImgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      registerDate: freezed == registerDate
          ? _value.registerDate
          : registerDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$$_RecordCopyWith(_$_Record value, $Res Function(_$_Record) then) =
      __$$_RecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String recipeUrl,
      String memo,
      bool isOpen,
      DateTime? date,
      String imageUrl,
      List<Tag> tags,
      List<String> likeUserIds,
      String userId,
      String userName,
      String userImgUrl,
      DateTime? registerDate,
      bool isDone});
}

/// @nodoc
class __$$_RecordCopyWithImpl<$Res>
    extends _$RecordCopyWithImpl<$Res, _$_Record>
    implements _$$_RecordCopyWith<$Res> {
  __$$_RecordCopyWithImpl(_$_Record _value, $Res Function(_$_Record) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? recipeUrl = null,
    Object? memo = null,
    Object? isOpen = null,
    Object? date = freezed,
    Object? imageUrl = null,
    Object? tags = null,
    Object? likeUserIds = null,
    Object? userId = null,
    Object? userName = null,
    Object? userImgUrl = null,
    Object? registerDate = freezed,
    Object? isDone = null,
  }) {
    return _then(_$_Record(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      recipeUrl: null == recipeUrl
          ? _value.recipeUrl
          : recipeUrl // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      likeUserIds: null == likeUserIds
          ? _value._likeUserIds
          : likeUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImgUrl: null == userImgUrl
          ? _value.userImgUrl
          : userImgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      registerDate: freezed == registerDate
          ? _value.registerDate
          : registerDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Record implements _Record {
  const _$_Record(
      {required this.id,
      required this.title,
      this.recipeUrl = "",
      this.memo = "",
      this.isOpen = false,
      this.date,
      this.imageUrl = "",
      final List<Tag> tags = const [],
      final List<String> likeUserIds = const [],
      this.userId = "",
      this.userName = "",
      this.userImgUrl = "",
      this.registerDate,
      this.isDone = false})
      : _tags = tags,
        _likeUserIds = likeUserIds;

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String recipeUrl;
  @override
  @JsonKey()
  final String memo;
  @override
  @JsonKey()
  final bool isOpen;
  @override
  final DateTime? date;
  @override
  @JsonKey()
  final String imageUrl;
  final List<Tag> _tags;
  @override
  @JsonKey()
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _likeUserIds;
  @override
  @JsonKey()
  List<String> get likeUserIds {
    if (_likeUserIds is EqualUnmodifiableListView) return _likeUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likeUserIds);
  }

  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String userImgUrl;
  @override
  final DateTime? registerDate;
  @override
  @JsonKey()
  final bool isDone;

  @override
  String toString() {
    return 'Record(id: $id, title: $title, recipeUrl: $recipeUrl, memo: $memo, isOpen: $isOpen, date: $date, imageUrl: $imageUrl, tags: $tags, likeUserIds: $likeUserIds, userId: $userId, userName: $userName, userImgUrl: $userImgUrl, registerDate: $registerDate, isDone: $isDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Record &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.recipeUrl, recipeUrl) ||
                other.recipeUrl == recipeUrl) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._likeUserIds, _likeUserIds) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImgUrl, userImgUrl) ||
                other.userImgUrl == userImgUrl) &&
            (identical(other.registerDate, registerDate) ||
                other.registerDate == registerDate) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      recipeUrl,
      memo,
      isOpen,
      date,
      imageUrl,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_likeUserIds),
      userId,
      userName,
      userImgUrl,
      registerDate,
      isDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      __$$_RecordCopyWithImpl<_$_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(
      this,
    );
  }
}

abstract class _Record implements Record {
  const factory _Record(
      {required final String id,
      required final String title,
      final String recipeUrl,
      final String memo,
      final bool isOpen,
      final DateTime? date,
      final String imageUrl,
      final List<Tag> tags,
      final List<String> likeUserIds,
      final String userId,
      final String userName,
      final String userImgUrl,
      final DateTime? registerDate,
      final bool isDone}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get recipeUrl;
  @override
  String get memo;
  @override
  bool get isOpen;
  @override
  DateTime? get date;
  @override
  String get imageUrl;
  @override
  List<Tag> get tags;
  @override
  List<String> get likeUserIds;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String get userImgUrl;
  @override
  DateTime? get registerDate;
  @override
  bool get isDone;
  @override
  @JsonKey(ignore: true)
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      throw _privateConstructorUsedError;
}
