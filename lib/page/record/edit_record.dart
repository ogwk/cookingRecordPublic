// ignore_for_file: must_be_immutable
import 'package:cooking_record/extension/date_time_ex.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/page/record/edit_record_view_model.dart';
import 'package:cooking_record/page/record/record_widget.dart';
import 'package:cooking_record/page/record/search_recipi.dart';
import 'package:cooking_record/page/record/tag/tag.dart';
import 'package:cooking_record/repository/record_repository.dart';
import 'package:cooking_record/unit/dialog/dialog.dart';
import 'package:cooking_record/unit/dialog/function.dart';
import 'package:cooking_record/unit/image/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditRecordPage extends StatefulWidget {
  EditRecordPage(this.record, {Key? key}) : super(key: key);
  Record record;

  @override
  State<EditRecordPage> createState() => _EditRecordPageState();
}

class _EditRecordPageState extends State<EditRecordPage> {
  final recordRepository = RecordRepository();

  final EditRecordViewModel viewModel = EditRecordViewModel();
  final TextEditingController titleController = TextEditingController();

  void reload() {
    setState(() {});
  }

  void setDate(selectDate) {
    setState(() {
      viewModel.setDate = selectDate;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.setup(widget.record);
  }

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("記録を修正"),
        actions: [
          IconButton(
              onPressed: () async {
                List<Tag> registerTags = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TagPage(viewModel.user)));
                viewModel.addRegisterTags(registerTags);
                setState(() {});
              },
              icon: const Icon(Icons.new_label)),
          IconButton(
              onPressed: () {
                showDialogYesNo(
                    context, "削除", "この記録を削除します。\n よろしいですか？", deleteRecord);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(viewModel.record.date?.getFormatString("yyyy年MM月dd日") ??
                      "-年-月-日"),
                  IconButton(
                      onPressed: () {
                        pickDate(context, setDate);
                      },
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: viewModel.record.isDone,
                    onChanged: (value) {
                      viewModel.setIsDone = value!;
                      setState(() {});
                    },
                  ),
                  Text(viewModel.record.isDone ? "作った！" : "まだ作ってない",
                      textAlign: TextAlign.start),
                ],
              ),
              // Row(
              //   children: [
              //     Switch(
              //       value: viewModel.record.isOpen,
              //       onChanged: (value) {
              //         setState(() {
              //           viewModel.setIsOpen = value;
              //         });
              //       },
              //     ),
              //     Text(viewModel.record.isOpen ? "公開" : "非公開",
              //         textAlign: TextAlign.start),
              //   ],
              // ),
              const SizedBox(
                height: 15,
              ),
              const Text("参考レシピ", textAlign: TextAlign.start),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'レシピのURL',
                      ),
                      controller: TextEditingController(
                          text: viewModel.record.recipeUrl),
                      onChanged: (value) {
                        setState(() {
                          viewModel.setRecipeUrl = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      width: size.width * 0.2,
                      child: ElevatedButton(
                          onPressed: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchRecipe(
                                        'https://www.google.com/')));
                            if (result.isNotEmpty) {
                              viewModel.getSiteTitle(result);
                              setState(() {});
                            }
                          },
                          child: const Icon(Icons.search)))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              recipeUrlInfoWidget(viewModel),
              const SizedBox(
                height: 15,
              ),
              const Text("料理タイトル", textAlign: TextAlign.start),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '料理タイトルを入力してください。',
                ),
                controller: TextEditingController(text: viewModel.record.title),
                onChanged: (value) {
                  setState(() {
                    viewModel.setTitle = value;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("料理メモ", textAlign: TextAlign.start),
              TextFormField(
                initialValue: viewModel.record.memo,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: '',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                onChanged: (value) {
                  setState(() {
                    viewModel.setMemo = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              localImageWidget(),
              const SizedBox(
                height: 15,
              ),
              const Text("タグ　※タップで削除できます。", textAlign: TextAlign.start),
              Wrap(
                children: viewModel.record.tags
                    .map(
                      (Tag tag) => SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(216, 217, 217, 1)),
                            ),
                            child: Text(
                              tag.tagName.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              viewModel.removeTag(tag);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            EasyLoading.show();
            await viewModel.updateRecord();
            setState(() {});
            EasyLoading.dismiss();

            if (!mounted) return;
            Navigator.pop(context);
          },
          child: const Text("更新する"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          selectImage(context, viewModel, reload);
        },
        child: const Icon(Icons.photo_camera),
      ),
    );
  }

  Widget localImageWidget() {
    return Container(
      alignment: Alignment.topLeft,
      child: GestureDetector(
          onTap: () async {
            selectImage(context, viewModel, reload);
          },
          child: (viewModel.imgFilePath != "")
              //画像の変更パスが設定されている時は設定画像を表示
              ? imageBox(200.0, 200.0, viewModel.imgFilePath)
              : netImageBox(200.0, 200.0, viewModel.record.imageUrl)),
    );
  }

  void deleteRecord() {
    viewModel.deleteRecord();
    Navigator.pop(context);
  }
}
