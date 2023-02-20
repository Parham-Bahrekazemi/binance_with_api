import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<String> images = [
    'assets/images/a1.png',
    'assets/images/a2.png',
    'assets/images/a3.png',
    'assets/images/a4.png',
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      allowImplicitScrolling: true,
      children: <Widget>[
        myPage(images[0]),
        myPage(images[1]),
        myPage(images[2]),
        myPage(images[3]),
      ],
    );
  }

  Widget myPage(String image) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.fill,
      ),
    );
  }
}
