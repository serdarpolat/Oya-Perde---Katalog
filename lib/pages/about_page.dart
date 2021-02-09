import 'package:flutter/material.dart';
import 'package:katalog/index.dart';
import 'package:lottie/lottie.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  SettingsModel setting = SettingsModel();
  Providers providers = Providers();
  Size get s => MediaQuery.of(context).size;
  bool loading;

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
                ? Center(
                    child: Text("Veri Yok"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Hakkımızda",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: mainDark,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(12),
                          child: Text(
                            setting.about,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: mainDark.withOpacity(0.75),
                              fontFamily: "Capriola",
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
