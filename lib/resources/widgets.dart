import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color mainDark = Color(0xFF333860);
Color pink = Color(0xFFE21670);
Color green = Color(0xFF14ABAA);
Color purple = Color(0xFF6770E6);

Color catLightGreen = Color(0xFF00f5d4);
Color catGreen = Color(0xFF14ABAA);
Color catLightBlue = Color(0xFF00bbf9);
Color catBlue = Color(0xFF3a86ff);
Color catYellow = Color(0xFFfee440);
Color catLightPink = Color(0xFFf15bb5);
Color catPink = Color(0xFFE21670);
Color catPurple = Color(0xFF6770E6);

final _appBar = AppBar(
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
);

Widget get appBar => _appBar;

void launchWhatsapp({@required number, @required message}) async {
  String url = "whatsapp://send?phone=$number&text=$message";

  await canLaunch(url) ? launch(url) : Text("Error");
}

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
