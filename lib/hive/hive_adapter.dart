import 'package:hive/hive.dart';

class Product {
  String? productId;
  String? productName;
  String? productImage;
  String? purchaseRate;
  String? salesRate;
  String? boxQuantity;
  String? quantity;
  String? total;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.purchaseRate,
    required this.salesRate,
    required this.boxQuantity,
    required this.quantity,
    required this.total,
});

  // Product.fromJson(Map<String, dynamic> json) {
  //   productId = json["product_id"];
  //   productName = json["product_name"];
  //   productImage = json["product_image"];
  //   salesRate = json["sales_rate"];
  //   boxQuantity = json["box_quantity"];
  //   quantity = json["quantity"];
  //   total = json["total"];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data["product_id"] = productId;
  //   data["product_name"] = productName;
  //   data["product_image"] = productImage;
  //   data["sales_rate"] = salesRate;
  //   data["box_quantity"] = boxQuantity;
  //   data["quantity"] = quantity;
  //   data["total"] = total;
  //   return data;
  // }

}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final productId = reader.readString();
    final productName = reader.readString();
    final productImage = reader.readString();
    final purchaseRate = reader.readString();
    final salesRate = reader.readString();
    final boxQuantity = reader.readString();
    final quantity = reader.readString();
    final total = reader.readString();
    return Product(
      productId: productId,
      productName: productName,
      productImage: productImage,
      purchaseRate: purchaseRate,
      salesRate: salesRate,
      boxQuantity: boxQuantity,
      quantity: quantity,
      total: total,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString("${obj.productId}");
    writer.writeString("${obj.productName}");
    writer.writeString("${obj.productImage}");
    writer.writeString("${obj.purchaseRate}");
    writer.writeString("${obj.salesRate}");
    writer.writeString("${obj.boxQuantity}");
    writer.writeString("${obj.quantity}");
    writer.writeString("${obj.total}");
  }
}