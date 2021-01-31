import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:katalog/index.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  Size get s => MediaQuery.of(context).size;

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget menuButton(Widget page, String title) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 16),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      splashColor: catLightPink,
    );
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'srdr_plt@hotmail.com',
      queryParameters: {'subject': 'Katalog!'});

  Widget socialButton(String image, String url) {
    return FlatButton(
      onPressed: () async {
        await launchURL(url);
      },
      child: Container(
          width: 32,
          height: 32,
          child: Image.asset("assets/images/$image.png")),
      shape: CircleBorder(),
      padding: EdgeInsets.all(12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: s.width,
      height: s.height,
      color: mainDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            margin: const EdgeInsets.all(0.0),
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: s.width,
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                    color: catLightPink.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    child: Image.asset("assets/images/icon.png"),
                  ),
                  Text(
                    "katalog",
                    style: TextStyle(
                      fontFamily: "Capriola",
                      fontSize: 26,
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
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: mainDark,
            ),
          ),
          Spacer(),
          menuButton(ServicesPage(), "Hizmetlerimiz"),
          menuButton(AboutPage(), "Hakkımızda"),
          menuButton(ContactPage(), "İletişim"),
          Spacer(),
        ],
      ),
    );
  }
}
