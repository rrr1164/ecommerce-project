class Product {
  final String title;
  final int price;
  final String thumbnail;

  Product.fromJson(Map json)
      :
        title = json['title'],
        price = json['price'],
        thumbnail = json['thumbnail'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumbnail': thumbnail,
      'price' : price
    };
  }
}