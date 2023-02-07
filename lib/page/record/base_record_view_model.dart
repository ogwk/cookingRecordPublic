import 'package:cooking_record/const/custom_type.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/model/user.dart';
import 'package:cooking_record/repository/record_repository.dart';
import 'package:cooking_record/repository/tag_repository.dart';
import 'package:cooking_record/repository/user_repository.dart';
import 'package:cooking_record/unit/shared_preference.dart';
import 'package:cooking_record/unit/siteimage.dart';
import 'package:image_picker/image_picker.dart';

class BaseRecordViewModel {
  User? user;
  Record record = const Record(
    id: "",
    title: "",
    tags: [],
  );
  String imgFilePath = "";
  final ShareData shareData = ShareData();

  final picker = ImagePicker();
  final RecordRepository recordRepository = RecordRepository();
  final UserRepository userRepository = UserRepository();
  TagRepository tagRepository = TagRepository();
  Map<SiteContent, String> recipeUrlInfo = {};
  bool isOgpReload = true;

  BaseRecordViewModel() {
    shareData.setInstance().then((value) => getInfo());
    //  Todo　Userがnullの時にエラーメッセージを出したい
  }

  void getInfo() async {
    final userId = shareData.getStringShareData('id');
    final tempUser = await userRepository.getUserinfo(userId);
    if (tempUser != null) {
      user = tempUser;
    }
  }

  set setSiteInfo(Map<SiteContent, String> mapItem) {
    recipeUrlInfo = mapItem;
    isOgpReload = false;
  }

  set setTitle(String title) {
    record = record.copyWith(title: title);
  }

  set setRecipeUrl(String recipeUrl) {
    record = record.copyWith(recipeUrl: recipeUrl);
    isOgpReload = true;
  }

  set setMemo(String memo) {
    record = record.copyWith(memo: memo);
  }

  set setIsOpen(bool open) {
    record = record.copyWith(isOpen: open);
  }

  set setDate(DateTime date) {
    record = record.copyWith(date: date);
  }

  set setImageUrl(String fileUrl) {
    imgFilePath = fileUrl;
  }

  set setIsDone(bool isDone) {
    record = record.copyWith(isDone: isDone);
  }

  Future<void> getSiteTitle(String recipeUrl) async {
    setRecipeUrl = recipeUrl;
    Map<SiteContent, String> siteData = await getSiteData(recipeUrl);
    if (siteData[SiteContent.title] != null && record.title.isNotEmpty) {
      setTitle = siteData[SiteContent.title]!;
    }
  }

  void setup(Record record) {
    if (record.date == null) {
      this.record = record.copyWith(date: DateTime.now());
    } else {
      this.record = record.copyWith();
    }
  }

  void addRegisterTags(List<Tag> registerTags) {
    List<Tag> tags = [];
    for (var tag in record.tags) {
      tags.add(tag);
    }
    //登録されているtags一覧に、今回登録するregisterTagのタグ名がない場合
    for (var registerTag in registerTags) {
      if (tags.any((t) => t.tagName == registerTag.tagName) == false) {
        tags.add(registerTag);
      }
    }
    record = record.copyWith(tags: tags);
  }

  void removeTag(Tag tag) {
    List<Tag> tags = [];
    for (var tag in record.tags) {
      tags.add(tag);
    }
    tags.remove(tag);
    record = record.copyWith(tags: tags);
  }

  //画像の取得
  Future getImage(bool isCamera) async {
    final pickedFile = (isCamera == true)
        //カメラから取得
        ? await picker.pickImage(source: ImageSource.camera, imageQuality: 50)
        //ギャラリーから取得
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      imgFilePath = pickedFile.path;
    }
  }

  Future<void> addNewTags() async {
    List<Tag> registerTags = [];

    //登録済みのタグを取得
    await tagRepository.getTagList().then((List<Tag> tagList) async {
      for (Tag tag in record.tags) {
        if (tag.id != '') {
          registerTags.add(tag);
        } else if (tagList.any((t) => t.tagName == tag.tagName)) {
          //既にtabNameが登録されている場合、Firestoreのデータで上書き
          final tagData = tagList.firstWhere((t) => t.tagName == tag.tagName);
          registerTags.add(tagData);
        } else {
          //既にtabNameが登録されていない場合、新規登録
          final tagData = await tagRepository.addNewTag(user!.id, tag);
          if (tagData != null) {
            registerTags.add(tagData);
          }
        }
        //登録データ書き換え
        record = record.copyWith(tags: registerTags);
      }
    });
  }
}
