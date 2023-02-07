import 'package:cooking_record/model/tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String id,
    required String title,
    @Default("") String recipeUrl,
    @Default("") String memo,
    @Default(false) bool isOpen,
    DateTime? date,
    @Default("") String imageUrl,
    @Default([]) List<Tag> tags,
    @Default([]) List<String> likeUserIds,
    @Default("") String userId,
    @Default("") String userName,
    @Default("") String userImgUrl,
    DateTime? registerDate,
    @Default(false) bool isDone,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
