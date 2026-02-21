
class ProductModel {
    final String id;
    final Status status;
    final Category category;
    final String name;
    final double price;
    final String description;
    final String image;
    final List<String> images;
    final String company;
    final int countInStock;
    final int v;
    final int sales;

    ProductModel({
        required this.id,
        required this.status,
        required this.category,
        required this.name,
        required this.price,
        required this.description,
        required this.image,
        required this.images,
        required this.company,
        required this.countInStock,
        required this.v,
        required this.sales,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"] ?? "",
        status: statusValues.map[json["status"]] ?? Status.newItem,
        category: categoryValues.map[json["category"]] ?? Category.laptops,
        name: json["name"] ?? "",
        price: json["price"]?.toDouble() ?? 0.0,
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        images: json["images"] != null 
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        company: json["company"] ?? "",
        countInStock: json["countInStock"] ?? 0,
        v: json["__v"] ?? 0,
        sales: json["sales"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "status": statusValues.reverse[status],
        "category": categoryValues.reverse[category],
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "images": List<dynamic>.from(images.map((x) => x)),
        "company": company,
        "countInStock": countInStock,
        "__v": v,
        "sales": sales,
    };
}

enum Category {
    laptops
}

final categoryValues = EnumValues({
    "Laptops": Category.laptops
});

enum Status {
    newItem,
    used
}

final statusValues = EnumValues({
    "New": Status.newItem,
    "Used": Status.used
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
