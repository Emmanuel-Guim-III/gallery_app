import 'package:flutter/material.dart';
import 'package:gallery_app/logic_provider.dart';
import 'package:gallery_app/logics/image_logic.dart';
import 'package:gallery_app/models/image_model.dart';
import 'package:gallery_app/page_routes.dart' as routes;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageLogic _imageLogic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageLogic = LogicProvider.of(context)!.imageLogic;
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Album'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: FutureBuilder<List<ImageModel>>(
              future: _imageLogic.getImages(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ImageModel>> images) {
                if (!images.hasData) {
                  return const Center(child: Text('Loading...'));
                }

                return images.data!.isEmpty
                    ? const Center(
                        child: Text('No Image yet!'),
                      )
                    : CustomScrollView(
                        primary: false,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(8),
                            sliver: SliverGrid.count(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              crossAxisCount: 3,
                              children:
                                  _buildImageGridView(images, isLandscape),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageGridView(
      AsyncSnapshot<List<ImageModel>> images, bool isLandscape) {
    return images.data!.map((img) {
      return GestureDetector(
        onTap: () {
          _openImageViewer(img);
        },
        child: Stack(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                img.thumbnailUrl,
                fit: BoxFit.fill,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Text(
              img.id.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(isLandscape ? 10 : 5),
                child: Text(img.title,
                    style: TextStyle(fontSize: isLandscape ? 18 : 10)),
              ),
            ),
          ),
        ]),
      );
    }).toList();
  }

  void _openImageViewer(ImageModel image) {
    Navigator.pushNamed(
      context,
      routes.imageView,
      arguments: image,
    );
  }
}
