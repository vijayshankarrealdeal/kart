class TopTrendings {
  TopTrendings({
    required this.itemName,
    required this.famous,
  });
  late final String itemName;
  late final int famous;

  TopTrendings.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    famous = json['famous'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['famous'] = famous;
    return data;
  }
}
