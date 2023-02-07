import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/model/user.dart';
import 'package:cooking_record/repository/tag_repository.dart';

class TagViewModel {
  List<Tag> allTags = [];
  List<Tag> registerTags = [];
  List<Tag> addTags = [];
  String addTagName = '';
  User? user;
  TagRepository tagRepository = TagRepository();

  set setUser(User? getUser) {
    user = getUser;
  }

  set setTagName(String tagName) {
    addTagName = tagName;
  }

  void removeTag(Tag removeTag) {
    addTags.remove(removeTag);
  }

  void addNewTag(Tag addTag) {
    addTags.add(addTag);
  }

  Future<void> addRegisterTag() async {
    for (var tag in addTags) {
      registerTags.add(tag);
    }
    addTags = [];
  }

  Future<void> getTagList() async {
    allTags = await tagRepository.getTagList();
  }
}
