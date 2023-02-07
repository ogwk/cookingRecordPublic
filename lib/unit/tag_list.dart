import 'package:cooking_record/model/tag.dart';
import 'package:flutter/material.dart';

Widget tagList(List<Tag> allTags, Function fncAct) {
  return Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(),
            ),
          ),
          child: ListTile(
            title: Text(allTags[index].tagName),
            onTap: () {
              fncAct(allTags[index]);
            },
          ),
        );
      },
      itemCount: allTags.length,
    ),
  );
}
