import 'package:flutter/material.dart';
import 'package:katalog/index.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  SettingsModel setting = SettingsModel();
  Providers providers = Providers();
  String mail;
  bool loading;
  Size get s => MediaQuery.of(context).size;

  Widget contactButton(String img, String url, String title) {
    return TextButton(
      onPressed: () async {
        await launchURL(url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            child: Image.asset(
              "assets/images/" + img,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 24),
          Container(
            width: 130,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Capriola",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    loading = true;
    providers.fetchSettings().then((setList) {
      setState(() {
        setting = setList;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto', path: mail, queryParameters: {'subject': 'Katalog!'});
    return Scaffold(
      appBar: appBar,
      body: Container(
        width: s.width,
        height: s.height,
        padding: EdgeInsets.all(16),
        child: loading
            ? Center(
                child: Container(
                  child: Lottie.asset('assets/lottie/animation.json'),
                  width: 60,
                  height: 60,
                ),
              )
            : setting == null
                ? Center(child: Text("Veri Yok"))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: s.height * 0.1),
                      TextButton(
                        onPressed: () async {
                          await makePhoneCall('tel:' + setting.phone);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              child: Image.asset(
                                "assets/images/phones.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 24),
                            Container(
                              width: 130,
                              child: Text(
                                "Telefon",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Capriola",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      contactButton(
                          "facebook.png", setting.facebook, "Facebook"),
                      contactButton(
                          "instagram.png", setting.instagram, "Instagram"),
                      TextButton(
                        onPressed: () async {
                          await launch(_emailLaunchUri.toString());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              child: Image.asset(
                                "assets/images/email.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 24),
                            Container(
                              width: 130,
                              child: Text(
                                "E-Posta",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Capriola",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: s.height * 0.1),
                    ],
                  ),
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final Function onPressed;
  final String img;
  final String title;

  const ContactButton({Key key, this.onPressed, this.img, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            child: Image.asset(
              "assets/images/" + img,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Capriola",
            ),
          ),
        ],
      ),
    );
  }
}
