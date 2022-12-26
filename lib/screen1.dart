// ignore_for_file: prefer_const_constructors, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'dart:math';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1();
}

class _Screen1 extends State<Screen1> with SingleTickerProviderStateMixin {
  int dice1 = 1;
  late AnimationController _controller1;
  late CurvedAnimation animation1;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
  }

  void animate() {
    _controller1 =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation1 =
        CurvedAnimation(parent: _controller1, curve: Curves.easeInOutExpo);
    animation1.addListener(() {
      setState(() {});
      print(animation1.value);
    });
    animation1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('completed');
        setState(() {});
        dice1 = Random().nextInt(6) + 1;
        _controller1.reverse();
      }
    });
  }

  void roll1() {
    _controller1.forward();
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
          GestureDetector(
            onDoubleTap: roll1,
            child: SizedBox(
              height: 300,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image(
                    height: 300 - (animation1.value) * 200,
                    image: AssetImage('assets/images/dice-png-$dice1.png')),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: roll1,
              child: Text('ROLL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
        ]),
      ),
    );
  }
}
