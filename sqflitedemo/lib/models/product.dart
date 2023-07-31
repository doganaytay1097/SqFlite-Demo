class Product {
  int? id;
  String name;
  String description;
  double unitPrice;

  // Constructors

  Product(this.id, this.name, this.description, this.unitPrice);

  Product.withoutId(this.name, this.description, this.unitPrice) : id = null;

  // Methods
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        unitPrice = map["unitPrice"].toDouble();
}


