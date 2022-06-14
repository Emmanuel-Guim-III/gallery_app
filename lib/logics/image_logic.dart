import 'package:gallery_app/models/image_model.dart';
import 'package:gallery_app/services/image_service.dart';

abstract class ImageLogic {
  Future<List<ImageModel>> getImages();
}

class ImageLogicImpl implements ImageLogic {
  final ImageService _imageService;

  ImageLogicImpl(
    this._imageService,
  );

  @override
  Future<List<ImageModel>> getImages() async {
    return await _imageService.getImages();
  }
}
