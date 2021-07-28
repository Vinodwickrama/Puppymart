import 'dart:io';

class Puppy {
  String _post_id;
  String _post_dateTime;
  String _post_user_uid;
  String _post_user_name;
  String _title;
  String _breed;
  String _description;
  String _country;
  String _province;
  String _district;
  String _gender;
  String _city;
  String _town;
  String _location;
  File _imgPropic_url;
  String _imgPropic_fire_url;
  List<File> _img_urls;
  List<String> _img_fire_urls;
  double _price;
  String _mobile_no;
  int _isNegotiable;

  String get imgPropic_fire_url => _imgPropic_fire_url;

  set imgPropic_fire_url(String value) {
    _imgPropic_fire_url = value;
  }

  String get post_id => _post_id;

  set post_id(String value) {
    _post_id = value;
  }

  String get post_dateTime => _post_dateTime;

  set post_dateTime(String value) {
    _post_dateTime = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get breed => _breed;

  int get isNegotiable => _isNegotiable;

  set isNegotiable(int value) {
    _isNegotiable = value;
  }

  String get mobile_no => _mobile_no;

  set mobile_no(String value) {
    _mobile_no = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  List<File> get img_urls => _img_urls;

  set img_urls(List<File> value) {
    _img_urls = value;
  }

  File get imgPropic_url => _imgPropic_url;

  set imgPropic_url(File value) {
    _imgPropic_url = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get province => _province;

  set province(String value) {
    _province = value;
  }

  String get town => _town;

  set town(String value) {
    _town = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set breed(String value) {
    _breed = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get post_user_uid => _post_user_uid;

  set post_user_uid(String value) {
    _post_user_uid = value;
  }

  String get post_user_name => _post_user_name;

  set post_user_name(String value) {
    _post_user_name = value;
  }

  List<String> get img_fire_urls => _img_fire_urls;

  set img_fire_urls(List<String> value) {
    _img_fire_urls = value;
  }
}
