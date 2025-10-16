

class InfoModel {

  final String title;
  final String phone;
  final String location;
  final String? urlImage;
  final String? svgIconPath;
  final String? latLng;
  InfoModel({
    required this.title,
    required this.phone,
    required this.location,
    this.urlImage = '', 
    this.svgIconPath = '',
    this.latLng,
  });





}
