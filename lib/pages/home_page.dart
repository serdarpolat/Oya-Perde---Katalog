import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katalog/index.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = List<CategoryModel>.empty(growable: true);
  Providers providers = Providers();
  bool loading;
  Size get s => MediaQuery.of(context).size;

  Map<String, String> header = {
    "HttpHeaders.contentTypeHeader": "application/json"
  };

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final url =
          "https://www.oyaperde.org/?api=categories&api_key=25d55ad283aa400af464c76d713c07ad";
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        final List<CategoryModel> categoryList =
            categoryModelFromJson(response.body);
        return categoryList;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  void initState() {
    loading = true;
    fetchCategories().then((categoryList) {
      setState(() {
        categories = categoryList;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        width: s.width,
        height: s.height,
        padding: EdgeInsets.all(24),
        child: loading
            ? Center(
                child: Container(
                  child: Lottie.asset('assets/lottie/animation.json'),
                  width: 60,
                  height: 60,
                ),
              )
            : categories == null
                ? Center(child: Text("Veri Yok"))
                : GridView.count(
                    childAspectRatio: 3 / 3.7,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    crossAxisCount: 2,
                    children: List.generate(
                      categories.length,
                      (index) {
                        CategoryModel cat = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Products(
                                    productId: cat.id, catName: cat.title)));
                          },
                          child: CategoryItem(
                            providers: providers,
                            cat: cat,
                          ),
                        );
                      },
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assets/images/whatsapp.png",
          color: Colors.white,
          width: 32,
          height: 32,
        ),
        onPressed: () {
          launchWhatsapp(number: "+905326963364", message: "Merhaba!");
        },
        backgroundColor: Color(0xFF25D366),
      ),
      drawer: MenuDrawer(),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Providers providers;
  final CategoryModel cat;

  const CategoryItem({Key key, this.providers, this.cat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3.5 / 3,
            child: Container(
              padding: EdgeInsets.all(24),
              child: CachedNetworkImage(
                imageUrl: providers.catImgPath + cat.imageMax,
                fadeInCurve: Curves.ease,
                httpHeaders: {
                  "HttpHeaders.contentTypeHeader": "application/json"
                },
                key: ValueKey(providers.catImgPath + cat.imageMax),
                maxHeightDiskCache: s.height ~/ 2,
                maxWidthDiskCache: s.width ~/ 2,
                memCacheWidth: s.width ~/ 2,
                memCacheHeight: s.height ~/ 2,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: Container(
                    child: Lottie.asset('assets/lottie/animation.json'),
                    width: 60,
                    height: 60,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  cat.title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    color: mainDark,
                    fontSize: 24,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
