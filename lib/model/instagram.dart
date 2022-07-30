import 'dart:convert';
import 'dart:math';

class InstagramCall {
  InstagramCall({
    required this.imageUrl,
    required this.textData,
    required this.id,
  });
  late final String imageUrl;
  late final Map<String, dynamic> textData;
  late final String id;
  late final int likes;

  Map<String, dynamic> giveValid(String x) {
    String t = x.replaceAll('\'', '"');
    String temp = r'';
    for (int i = 0; i < t.length; ++i) {
      if (t[i] == '"' && t[i + 1] == '[') {
        temp += '';
      } else if (t[i] == '"' && t[i - 1] == ']') {
        temp += '';
      } else if (t[i] == '"' && i > 0 && t[i - 1] == '"') {
        temp += '';
      } else {
        temp += t[i];
      }
    }
    //print(temp);
    return jsonDecode(temp);
  }

  InstagramCall.fromJson(Map<String, dynamic> json) {
    final reg = RegExp(r'[^0-9]');

    textData = giveValid(json['text_data']);
    likes = giveValid(json['text_data'])['likes']
            .replaceAll(reg, '')
            .toString()
            .isEmpty
        ? Random().nextInt(800)
        : int.parse(giveValid(json['text_data'])['likes']
                .replaceAll(reg, '')
                .toString()) *
            1000;
    imageUrl = json['image_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['text_data'] = textData;
    data['id'] = id;
    return data;
  }
}
