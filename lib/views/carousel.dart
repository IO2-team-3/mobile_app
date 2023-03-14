import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_app/models/slideshow_info.dart';
import 'package:mobile_app/services/slideshow_service.dart';

class Carousel extends StatefulWidget {
  final SlideshowService slideshowService;

  const Carousel({super.key, required this.slideshowService});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late Future<List<SlideshowInfo>> _infos;

  @override
  void initState() {
    super.initState();
    _infos = widget.slideshowService.fetchSlideshowInfosList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SlideshowInfo>>(
      future: _infos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final imgList = snapshot.data!;
          final imageSliders = getImageSliders(imgList);
          return CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              initialPage: 1,
              autoPlay: true,
            ),
            items: imageSliders,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

String getPathToSlideshowImg(String imgName) {
  return 'assets/img/slideshow/$imgName.jpg';
}

List<Widget> getImageSliders(List<SlideshowInfo> imgList) {
  return imgList
      .map(
        (item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image(
                  image: AssetImage(
                    getPathToSlideshowImg(item.photo),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      item.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
      .toList();
}
