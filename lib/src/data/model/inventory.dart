class Inventory {
  String? id;
  String? color;
  String? colorValue;
  String? size;
  int? stockQuantity;

  Inventory(
      {this.id, this.color, this.colorValue, this.size, this.stockQuantity});

  Inventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    colorValue = json['color_value'];
    size = json['size'];
    stockQuantity = json['stock_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['color'] = color;
    data['color_value'] = colorValue;
    data['size'] = size;
    data['stock_quantity'] = stockQuantity;
    return data;
  }

  Inventory copyWith({
    String? id,
    String? color,
    String? colorValue,
    String? size,
    int? stockQuantity,
  }) {
    return Inventory(
      id: id ?? this.id,
      stockQuantity: stockQuantity ?? this.stockQuantity
    );
  }
}
