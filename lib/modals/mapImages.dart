
class MapImages {
  String Id;
  String name;
  String path;
  String mapType;
  MapImages({
    required this.Id,
    required this.name,
    required this.path,
    required this.mapType,
  });
  factory MapImages.fromJson(Map data) {
    return MapImages(Id: data['id'],
        name: data['name'],
        path: data['path'],
        mapType: data['mapType']);
  }
}
