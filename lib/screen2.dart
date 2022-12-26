// ignore_for_file: prefer_const_constructors, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'dart:math';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2();
}

class _Screen2 extends State<Screen2> with SingleTickerProviderStateMixin {
  int dice1 = 1;
  int dice2 = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutExpo);
    animation.addListener(() {
      setState(() {});
      print(animation.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('completed');
        setState(() {});
        dice1 = Random().nextInt(6) + 1;
        dice2 = Random().nextInt(6) + 1;
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
            child: Text(
          " - - - - -  DICE  ROLL  - - - - - ",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Tap on Roll or Double Tap on Die !",
            style: TextStyle(fontSize: 25),
          ),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onDoubleTap: roll,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Image(
                      height: 250 - (animation.value) * 200,
                      image: AssetImage('assets/images/dice-png-$dice1.png')),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: roll,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Image(
                      height: 250 - (animation.value) * 200,
                      image: AssetImage('assets/images/dice-png-$dice2.png')),
                ),
              )),
            ],
          ),
          ElevatedButton(
              onPressed: roll,
              child:
                  Text('ROLL', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)))
        ]),
      ),
    );
  }
}
