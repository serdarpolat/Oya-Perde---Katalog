import 'package:katalog/index.dart';
import 'package:http/http.dart' as http;

class Providers {
  //https://www.oyaperde.org/?api=categories&api_key=25d55ad283aa400af464c76d713c07ad
  //https://www.oyaperde.org/?api=settings&api_key=25d55ad283aa400af464c76d713c07ad
  //https://www.oyaperde.org/?api=products&id=54&api_key=25d55ad283aa400af464c76d713c07ad
  //https://www.oyaperde.org/?api=images&id=10&api_key=25d55ad283aa400af464c76d713c07ad

  final apiKey = "25d55ad283aa400af464c76d713c07ad";
  final baseUrl = "https://www.oyaperde.org/?api=";
  final setPath = "settings";
  final catPath = "categories";
  final prodPath = "products";
  final imgPath = "images";
  final catImgPath = "https://www.oyaperde.org/admin/images/category_images/";
  final prodImgPath = "https://www.oyaperde.org/admin/images/product_images/";

  Map<String, String> header = {
    "HttpHeaders.contentTypeHeader": "application/json"
  };

  Future<SettingsModel> fetchSettings() async {
    try {
      final url = baseUrl + setPath + "&api_key=" + apiKey;
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        final SettingsModel settings = settingsModelFromJson(response.body);
        return settings;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      List<SettingsModel>.empty(growable: true);
    }

    return null;
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final url = baseUrl + catPath + "&api_key=" + apiKey;
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        final List<CategoryModel> categoryList =
            categoryModelFromJson(response.body);
        return categoryList;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      List<CategoryModel>.empty(growable: true);
    }

    return null;
  }

  Future<List<ProductModel>> fetchProducts(String id) async {
    try {
      final url = baseUrl + prodPath + "&id=" + id + "&api_key=" + apiKey;
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        final List<ProductModel> productList =
            productModelFromJson(response.body);
        return productList;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      List<ProductModel>.empty(growable: true);
    }

    return null;
  }

  Future<List<ImageModel>> fetchImages(String id) async {
    try {
      final url = baseUrl + imgPath + "&id=" + id + "&api_key=" + apiKey;
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        final List<ImageModel> imageList = imageModelFromJson(response.body);
        return imageList;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      List<ImageModel>.empty(growable: true);
    }

    return null;
  }
}
