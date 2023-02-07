import 'package:cooking_record/const/custom_type.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

Future<Map<SiteContent, String>> getSiteData(String url) async {
  Map<SiteContent, String> siteInfo = {};

  // URLにアクセスして情報をすべて取得
  try {
    Response response = await get(Uri.parse(url));
// HTMLパッケージでHTMLタグとして認識
    var document = parse(response.body);
    // ヘッダー内のtitleタグの中身を取得
    siteInfo[SiteContent.title] =
        document.head!.getElementsByTagName('title')[0].innerHtml;
    // ヘッダー内のmetaタグをすべて取得
    var metas = document.head!.getElementsByTagName('meta');
    siteInfo[SiteContent.description] = "";
    siteInfo[SiteContent.imageUrl] = "";

    for (var meta in metas) {
      // metaタグの中からname属性がdescriptionであるものを探す
      if (meta.attributes['name'] == 'description') {
        siteInfo[SiteContent.description] = meta.attributes['content'] ?? '';
        // metaタグの中からproperty属性がog:imageであるものを探す
      } else if (meta.attributes['property'] == 'og:image') {
        siteInfo[SiteContent.imageUrl] = meta.attributes['content']!;
      }
    }
  } catch (e) {
    //URLが不正な場合
  }

  return siteInfo;
}
