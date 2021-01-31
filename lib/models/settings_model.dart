// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  SettingsModel({
    this.id,
    this.siteUrl,
    this.siteHeader,
    this.siteDesc,
    this.siteKeyw,
    this.siteTheme,
    this.siteStatus,
    this.phone,
    this.facebook,
    this.instagram,
    this.email,
  });

  String id;
  String siteUrl;
  String siteHeader;
  String siteDesc;
  String siteKeyw;
  String siteTheme;
  String siteStatus;
  String phone;
  String facebook;
  String instagram;
  String email;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    id: json["id"],
    siteUrl: json["site_url"],
    siteHeader: json["site_header"],
    siteDesc: json["site_desc"],
    siteKeyw: json["site_keyw"],
    siteTheme: json["site_theme"],
    siteStatus: json["site_status"],
    phone: json["phone"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_url": siteUrl,
    "site_header": siteHeader,
    "site_desc": siteDesc,
    "site_keyw": siteKeyw,
    "site_theme": siteTheme,
    "site_status": siteStatus,
    "phone": phone,
    "facebook": facebook,
    "instagram": instagram,
    "email": email,
  };
}
