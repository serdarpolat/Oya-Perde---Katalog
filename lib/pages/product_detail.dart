import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:katalog/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel prod;
  final String catName;

  const ProductDetail({Key key, this.prod, this.catName}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CarouselController crsCtrl = CarouselController();
  List<ImageModel> images = List<ImageModel>.empty(growable: true);
  Providers providers = Providers();
  Size get s => MediaQuery.of(context).size;
  bool hasImage = false;
  bool openImage = false;
  List<CachedNetworkImage> cachedImages =
      List<CachedNetworkImage>.empty(growable: true);

  @override
  void initState() {
    providers.fetchImages(widget.prod.id).then((imageList) {
      setState(() {
        images = imageList;
        hasImage = true;
      });
    }).whenComplete(() {
      for (var image in images) {
        String img =
            providers.prodImgPath + widget.prod.code + "/" + image.image;
        cachedImages.add(
          CachedNetworkImage(
            imageUrl: img,
            fit: BoxFit.cover,
            fadeInCurve: Curves.ease,
            httpHeaders: {"HttpHeaders.contentTypeHeader": "application/json"},
            key: ValueKey(img),
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
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: !hasImage
          ? Center(
              child: Container(
                child: Lottie.asset('assets/lottie/animation.json'),
                width: 60,
                height: 60,
              ),
            )
          : Container(
              width: s.width,
              height: s.height,
              child: Stack(
                children: [
                  Container(
                    width: s.width,
                    height: s.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                openImage = true;
                              });
                            },
                            child: CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: s.width,
                                  color: Colors.grey,
                                  child: cachedImages[index],
                                );
                              },
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                autoPlayInterval: Duration(seconds: 4),
                                autoPlay: true,
                                viewportFraction: 1,
                                aspectRatio: 4 / 3,
                              ),
                              carouselController: crsCtrl,
                            ),
                          ),
                          Container(
                            width: s.width,
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(12),
                            color: mainDark.withOpacity(0.1),
                            child: Row(
                              children: [
                                Text(
                                  widget.prod.title.toUpperCase(),
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  widget.catName.toUpperCase(),
                                  style: TextStyle(
                                    color: mainDark.withOpacity(0.5),
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: s.width,
                            margin: EdgeInsets.only(left: 6, right: 6, top: 6),
                            padding: EdgeInsets.all(12),
                            color: mainDark.withOpacity(0.1),
                            child: Text(
                              "ÜRÜN AÇIKLAMASI",
                              style: TextStyle(
                                color: mainDark.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Container(
                            width: s.width,
                            padding: EdgeInsets.all(12),
                            margin:
                                EdgeInsets.only(left: 6, right: 6, bottom: 6),
                            color: mainDark.withOpacity(0.025),
                            child: Text(
                              widget.prod.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color: mainDark.withOpacity(0.7),
                                fontFamily: "Capriola",
                              ),
                            ),
                          ),
                          Container(
                            width: s.width,
                            margin: EdgeInsets.only(left: 6, right: 6, top: 6),
                            padding: EdgeInsets.all(12),
                            color: mainDark.withOpacity(0.1),
                            child: Text(
                              "ÜRÜN ÖZELLİKLERİ",
                              style: TextStyle(
                                color: mainDark.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Container(
                            width: s.width,
                            padding: EdgeInsets.all(12),
                            margin:
                                EdgeInsets.only(left: 6, right: 6, bottom: 6),
                            color: mainDark.withOpacity(0.025),
                            child: Text(
                              widget.prod.info,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color: mainDark.withOpacity(0.7),
                                fontFamily: "Capriola",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    top: openImage ? 0 : s.height,
                    left: 0,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      width: s.width,
                      height: s.height,
                      color: mainDark,
                      child: Stack(
                        children: [
                          Container(
                            width: s.width,
                            height: s.height,
                            child: CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: s.width,
                                  color: Colors.grey,
                                  child: cachedImages[index],
                                );
                              },
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                autoPlayInterval: Duration(seconds: 4),
                                autoPlay: true,
                                viewportFraction: 1,
                                aspectRatio: 4 / 3,
                              ),
                              carouselController: crsCtrl,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  openImage = false;
                                });
                              },
                              iconSize: 36,
                              color: catLightGreen.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
