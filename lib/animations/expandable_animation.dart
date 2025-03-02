import 'package:flutter/material.dart';

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ExpandableAnimation(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Text('Item 1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))),
              ListTile(
                  title: Text('Item 2',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))),
              ListTile(
                  title: Text('Item 3',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableAnimation extends StatefulWidget {
  final Widget child;
  const ExpandableAnimation({
    super.key,
    required this.child,
  });

  @override
  State<ExpandableAnimation> createState() => _ExpandableAnimationState();
}

class _ExpandableAnimationState extends State<ExpandableAnimation> with TickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _animationController;
  late Animation<double> roteAnimation;
  late Animation<double> heightAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    roteAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.2, 1, curve: Curves.easeInOut)));
    heightAnimation = Tween<double>(begin: 100, end: 300)
        .animate(CurvedAnimation(parent: _animationController, curve: Interval(0.6, 0.8, curve: Curves.easeInOut)));

    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.6, 1, curve: Curves.easeInOut)));

    heightAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => GestureDetector(
          onTap: _toggleExpansion,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Expandable Card',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Transform.rotate(
                      angle: roteAnimation.value * 3.1416,
                      child: Icon(Icons.expand_more),
                    ),
                  ],
                ),
              ),
              ClipRect(
                child: Align(
                  heightFactor: heightAnimation.value,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
