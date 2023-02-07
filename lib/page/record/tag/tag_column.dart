import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/page/record/tag/tag_view_model.dart';
import 'package:cooking_record/unit/tag_list.dart';
import 'package:flutter/material.dart';

class TagColumn extends StatefulWidget {
  const TagColumn(this.viewModel, {Key? key}) : super(key: key);

  final TagViewModel viewModel;

  @override
  State<TagColumn> createState() => _TagColumnState();
}

class _TagColumnState extends State<TagColumn> {
  final _editController = TextEditingController();

  void addTag(Tag tag) {
    setState(() {
      widget.viewModel.addNewTag(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Wrap(
            children: widget.viewModel.addTags
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
                          widget.viewModel.removeTag(tag);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: TextFormField(
                  controller: _editController,
                  decoration: InputDecoration(
                    hintText: 'タグを追加',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (widget.viewModel.addTagName.trim() == '') return;
                        widget.viewModel.addNewTag(
                            Tag(id: '', tagName: widget.viewModel.addTagName));
                        widget.viewModel.setTagName = "";
                        _editController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.viewModel.setTagName = value.trim();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        tagList(widget.viewModel.allTags, addTag),
      ],
    );
  }
}
