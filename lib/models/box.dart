enum Category {
  Snacks,
  Beauty,
  Books,
  SelfCare,
  Stationery,
  Health,
  Fashion,
}

class Box {
  final int? id;
  final String? name;
  final double? price;
  final String? image;
  final String? description;
  final Category? category;
  final List<String>? items;

  Box({
    this.id,
    this.name,
    this.price,
    this.image,
    this.description,
    this.category,
    this.items,
  });
}
