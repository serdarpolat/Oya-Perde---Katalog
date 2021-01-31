// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.code,
    this.title,
    this.info,
    this.description,
    this.categoryId,
    this.image,
    this.createdAt,
  });

  String id;
  String code;
  String title;
  String info;
  String description;
  String categoryId;
  String image;
  DateTime createdAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    code: json["code"],
    title: json["title"],
    info: json["info"],
    description: json["description"],
    categoryId: json["category_id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "title": title,
    "info": info,
    "description": description,
    "category_id": categoryId,
    "image": image,
    "created_at": createdAt.toIso8601String(),
  };
}
