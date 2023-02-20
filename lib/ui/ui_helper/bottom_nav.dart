import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;
  const BottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color iconColor =
        primaryColor == Colors.blueAccent ? Colors.white : Colors.black;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor == Colors.blueAccent
          ? Colors.blueAccent
          : Colors.blueAccent.shade700,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    color: iconColor,
                    onPressed: () {
                      controller.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(Icons.home),
                  ),
                  IconButton(
                    color: iconColor,
                    onPressed: () {
                      controller.animateToPage(1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(Icons.bar_chart),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    color: iconColor,
                    onPressed: () {
                      controller.animateToPage(2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(Icons.person),
                  ),
                  IconButton(
                    color: iconColor,
                    onPressed: () {
                      controller.animateToPage(3,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(Icons.bookmark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
