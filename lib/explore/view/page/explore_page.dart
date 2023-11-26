import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Изучения", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Lottie.asset(
           'assets/animations/animation.json',
           width: 300,
           height: 300,
           fit: BoxFit.fill,
         ),
      ),
    );
  }
}
