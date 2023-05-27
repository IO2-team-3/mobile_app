import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String url;
  const ImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenViewer(url: url),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: SizedBox.fromSize(
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class PhotosGrid extends StatelessWidget {
  final List<String> urls;
  const PhotosGrid({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: urls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return ImageWidget(url: urls[index]);
      },
    );
  }
}

class FullScreenViewer extends StatelessWidget {
  final String url;
  const FullScreenViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(url),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
