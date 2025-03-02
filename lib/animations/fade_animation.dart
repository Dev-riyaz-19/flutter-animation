import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:typewritertext/typewritertext.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({super.key});

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final spring = SpringSimulation(SpringDescription(mass: 1, stiffness: 100, damping: 10), 0, 1, 0);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            // alignment: Alignment.center,
            width: 200,
            height: 200,
            color: Colors.red,
            child: TypeWriter.text(
              maintainSize: true,
              // overflow: TextOverflow.ellipsis,
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididdfldfljdfkjdlkfj dflkdjflkdjf dflkdfjlunt ut labore et dfljsadlfjlkdsjflkajdsflkjasdlkfjsakdjflkajdflkajsdlkfjalk dslkjdlfjd dflkdjflddlkfj df dlkfjdflkjdl flkdfjldkfj dlkjfdkf sdjflkasjdflks sdlkfj dfljdf ldjfdf ldkfjdlfjdolore magna aliqua.',
              duration: const Duration(seconds: 0),
            ),
          ),
        ),
      ),
    );
  }
}
