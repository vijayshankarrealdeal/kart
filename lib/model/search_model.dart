class SearchModelFlipkart {
  SearchModelFlipkart({
    required this.img,
    required this.title,
    required this.price,
    required this.rating,
    required this.link,
  });
  late final String img;
  late final String title;
  late final num price;
  late final String rating;
  late final String link;

  SearchModelFlipkart.fromJson(Map<String, dynamic> json) {
    img = json['img'] ?? '';
    title = json['title'] ?? '';
    price = json['price'] ?? 0;
    rating = json['rating'] ?? '';
    link = json['link'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['img'] = img;
    data['title'] = title;
    data['price'] = price;
    data['rating'] = rating;
    return data;
  }
}
