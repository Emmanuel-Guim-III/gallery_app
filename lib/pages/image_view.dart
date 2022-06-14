import 'package:flutter/material.dart';
import 'package:gallery_app/models/image_model.dart';
import 'package:share_plus/share_plus.dart';

class ImageView extends StatefulWidget {
  final ImageModel? image;

  const ImageView({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
        actions: [
          TextButton(
            onPressed: () => Share.share(widget.image!.thumbnailUrl),
            child: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: isLandscape
          ? _buildLandScapeScreen()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ID: ${widget.image!.id.toString()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        Image.network(
                          widget.image!.thumbnailUrl,
                          fit: BoxFit.fill,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.image!.title,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _buildLandScapeScreen() {
    return Row(
      children: [
        Image.network(
          widget.image!.thumbnailUrl,
          fit: BoxFit.fill,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${widget.image!.id.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    widget.image!.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
