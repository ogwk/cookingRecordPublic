import 'package:cooking_record/const/custom_type.dart';
import 'package:cooking_record/page/record/base_record_view_model.dart';
import 'package:cooking_record/unit/siteimage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget recipeUrlInfoWidget(BaseRecordViewModel viewModel) {
  return (viewModel.isOgpReload)
      ? FutureBuilder(
          future: getSiteData(viewModel.record.recipeUrl),
          builder: (context, AsyncSnapshot<Map<SiteContent, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // 通信が失敗した場合
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            // snapshot.dataにデータが格納されていれば、かつURLが存在すれば
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              viewModel.setSiteInfo = snapshot.data ?? {};
              return makeOgpWidget(viewModel);
            }
            return Container();
          },
        )
      : makeOgpWidget(viewModel);
}

Widget makeOgpWidget(BaseRecordViewModel viewModel) {
  return InkWell(
    onTap: () async {
      await launchUrlString(
        viewModel.record.recipeUrl,
        mode: LaunchMode.externalApplication, //別ブラウザで開く
      );
    },
    child: Container(
      height: 120,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          ogpImage(viewModel.recipeUrlInfo[SiteContent.imageUrl]!),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel.recipeUrlInfo[SiteContent.title] ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                  Text(
                    viewModel.recipeUrlInfo[SiteContent.description] ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget ogpImage(String imageUrl) {
  if (imageUrl.isEmpty) {
    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.rectangle,
        image: null,
      ),
    );
  }

  return Image.network(
    imageUrl,
    width: 120,
    height: 120,
    fit: BoxFit.cover,
    alignment: Alignment.center,
  );
}
