import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/repository/tag_repository.dart';

class SearchViewModel {
  List<Tag> allTags = [];
  TagRepository tagRepository = TagRepository();
  String searchText = "";

  Future<void> getTagList() async {
    allTags = await tagRepository.getTagList();
  }

  set setSearchText(String? text) {
    searchText = text ?? '';
  }
}
