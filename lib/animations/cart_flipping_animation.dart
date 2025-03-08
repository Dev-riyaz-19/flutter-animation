import 'dart:math';

import 'package:flutter/material.dart';

class CartFlippingAnimation extends StatefulWidget {
  const CartFlippingAnimation({super.key});

  @override
  State<CartFlippingAnimation> createState() => _CartFlippingAnimationState();
}

class _CartFlippingAnimationState extends State<CartFlippingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.rotationY(_animation.value),
              alignment: Alignment.center,
              child: child,
            ),
            Transform(
              transform: Matrix4.rotationZ(_animation.value),
              alignment: Alignment.topLeft,
              child: child,
            ),
          ],
        ),
        child: Container(
          height: 200,
          width: 200,
          color: Colors.black,
          child: Column(
            children: [
              Text('Cart'),
            ],
          ),
        ),
      ),
    );
  }
}
