// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.title,
    this.imageMax,
    this.imageMin,
    this.createdAt,
  });

  String id;
  String title;
  String imageMax;
  String imageMin;
  DateTime createdAt;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    title: json["title"],
    imageMax: json["image_max"],
    imageMin: json["image_min"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_max": imageMax,
    "image_min": imageMin,
    "created_at": createdAt.toIso8601String(),
  };
}
