import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/page/myrecords/search/search_result_from_tag_view_model.dart';
import 'package:cooking_record/page/record/edit_record.dart';
import 'package:cooking_record/unit/image/record_card.dart';
import 'package:flutter/material.dart';

class SearchResultFromTag extends StatefulWidget {
  const SearchResultFromTag(this.tag, {Key? key}) : super(key: key);
  final Tag tag;

  @override
  State<SearchResultFromTag> createState() => _SearchResultFromTagState();
}

class _SearchResultFromTagState extends State<SearchResultFromTag> {
  final SearchResultFromTagViewModel viewModel = SearchResultFromTagViewModel();

  Future<List<Record>> _getResultRecords(Tag tag) async {
    await viewModel.getSearchRecord(tag);
    return viewModel.getRecords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("# ${widget.tag.tagName}"),
      ),
      body: FutureBuilder(
        future: _getResultRecords(widget.tag),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (viewModel.getRecords.isEmpty) {
              return const Center(child: Text('検索結果がありませんでした。'));
            } else {
              return ListView.builder(
                  itemCount: viewModel.getRecords.length,
                  itemBuilder: (context, index) {
                    return buildCard(viewModel.getRecords[index], onTap);
                  });
            }
          } else {
            return const Center(child: Text('検索結果がありませんでした。'));
          }
        },
      ),
    );
  }

  void onTap(Record record) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditRecordPage(record)));
    setState(() {});
  }
}
