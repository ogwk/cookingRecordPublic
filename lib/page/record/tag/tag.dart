import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/model/user.dart';
import 'package:cooking_record/page/record/tag/tag_column.dart';
import 'package:cooking_record/page/record/tag/tag_view_model.dart';
import 'package:flutter/material.dart';

class TagPage extends StatefulWidget {
  const TagPage(this.user, {Key? key}) : super(key: key);
  final User? user;

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final TagViewModel viewModel = TagViewModel();

  Future<List<Tag>> getTagList() async {
    await viewModel.getTagList();
    return viewModel.allTags;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タグの追加"),
        actions: [
          ElevatedButton(
            child: const Text("登録"),
            onPressed: () async {
              viewModel.addRegisterTag().then(
                  (value) => Navigator.pop(context, viewModel.registerTags));
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: getTagList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return TagColumn(viewModel);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
