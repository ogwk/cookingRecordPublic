import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/page/myrecords/search/search_result_from_tag.dart';
import 'package:cooking_record/page/myrecords/search/search_view_model.dart';
import 'package:cooking_record/unit/tag_list.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchViewModel viewModel = SearchViewModel();

    return Scaffold(
      appBar: AppBar(title: const Text("タグで検索")),
      body: Column(
        children: [
          // textFieldWidget(viewModel),
          SearchTagList(viewModel),
        ],
      ),
    );
  }

  Widget textFieldWidget(SearchViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: TextFormField(
              onChanged: (value) {
                viewModel.setSearchText = (value).trim();
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                // MaterialPageRoute(builder: (context) => SearchResultFromTag(viewModel.searchText)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTagList extends StatefulWidget {
  const SearchTagList(this.viewModel, {Key? key}) : super(key: key);
  final SearchViewModel viewModel;

  @override
  State<SearchTagList> createState() => _SearchTagListState();
}

class _SearchTagListState extends State<SearchTagList> {
  Future<List<Tag>> getTagList() async {
    await widget.viewModel.getTagList();
    return widget.viewModel.allTags;
  }

  @override
  Widget build(BuildContext context) {
    void onTap(Tag tag) async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchResultFromTag(tag)));
    }

    return FutureBuilder(
        future: getTagList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return tagList(widget.viewModel.allTags, onTap);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
