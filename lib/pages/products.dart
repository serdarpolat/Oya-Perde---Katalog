import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katalog/index.dart';

class Products extends StatefulWidget {
  final String productId;
  final String catName;

  const Products({Key key, this.productId, this.catName}) : super(key: key);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<ProductModel> products = List<ProductModel>();
  Providers providers = Providers();
  Size get s => MediaQuery.of(context).size;
  bool hasProduct = false;
  bool hasImage = false;

  @override
  void initState() {
    providers.fetchProducts(widget.productId).then((productList) {
      setState(() {
        products = productList;
        hasProduct = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainDark,
        title: Text(
          "katalog",
          style: TextStyle(
            fontFamily: "Capriola",
            fontSize: 24,
            color: catLightGreen,
            shadows: [
              Shadow(
                color: catLightPink,
                offset: Offset(1.5, 1.5),
                blurRadius: 1,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: !hasProduct
            ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(mainDark),
            ))
            : products == null
            ? Center(
            child: Text(
              "Bu Kategoride Henüz Ürün Yok!",
              style: TextStyle(
                fontSize: 24,
              ),
            ))
            : GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 32,
          mainAxisSpacing: 32,
          childAspectRatio: 3 / 4.5,
          children: List.generate(
            products.length,
                (index) {
              ProductModel prod = products[index];
              String img = providers.prodImgPath +
                  prod.code +
                  "/" +
                  prod.image;

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (contetx) => ProductDetail(
                        prod: prod,
                        catName: widget.catName,
                      )));
                },
                child: Container(
                  width: (s.width - 72) / 2,
                  child: Stack(
                    children: [
                      Container(
                        width: (s.width - 72) / 2,
                        height: ((s.width - 72) / 2) * 4.5 / 3 - 1,
                        child: CachedNetworkImage(
                          imageUrl: img,
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.ease,
                          httpHeaders: {
                            "HttpHeaders.contentTypeHeader":
                            "application/json"
                          },
                          key: ValueKey(img),
                          maxHeightDiskCache: s.height ~/ 1,
                          maxWidthDiskCache: s.width ~/ 1,
                          memCacheWidth: s.width ~/ 1,
                          memCacheHeight: s.height ~/ 1,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                      mainDark),
                                  value: downloadProgress.progress,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Container(
                              width: (s.width - 72) / 2,
                              height: ((s.width - 72) / 2) * 4.5 / 3 -
                                  ((s.width - 72) / 2),
                              color: Colors.white70,
                              child: Center(
                                child: Text(
                                  prod.title.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: mainDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
