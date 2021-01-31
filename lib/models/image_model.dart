// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    this.id,
    this.image,
    this.productId,
  });

  String id;
  String image;
  String productId;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    image: json["image"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "product_id": productId,
  };
}
