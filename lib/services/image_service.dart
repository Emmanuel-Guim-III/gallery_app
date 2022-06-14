import 'dart:async';
import 'dart:convert';
import 'package:gallery_app/models/image_model.dart';
import 'package:http/http.dart' as http;

abstract class ImageService {
  Future<List<ImageModel>> getImages();
}

class ImageServiceImpl implements ImageService {
  ImageServiceImpl();

  @override
  Future<List<ImageModel>> getImages() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      final List responseJson = jsonDecode(response.body);

      return response.body.isEmpty
          ? []
          : responseJson.map((e) => ImageModel.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
