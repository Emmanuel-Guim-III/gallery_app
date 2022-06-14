class ImageModel {
  final int id;
  final String title;
  final String thumbnailUrl;

  const ImageModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  String toString() {
    return '''
      Image{
        id: $id, 
        title: $title, 
        thumbnailUrl: $thumbnailUrl, 
      }
    ''';
  }
}
