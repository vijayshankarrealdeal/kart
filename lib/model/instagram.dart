import 'dart:convert';

class InstagramCall {
  InstagramCall({
    required this.imageUrl,
    required this.textData,
    required this.id,
  });
  late final String imageUrl;
  late final Map<String, dynamic> textData;
  late final String id;

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
    imageUrl = json['image_url'];
    textData = giveValid(json['text_data']);
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