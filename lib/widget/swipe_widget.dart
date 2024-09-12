import 'package:flutter/material.dart';

class SwipeWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeDown;
  final VoidCallback onSwipeUp;
  const SwipeWidget({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSwipeDown,
    required this.onSwipeUp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // swipe right
          onSwipeRight.call();
        } else {
          // swipe left
          onSwipeLeft.call();
        }
      },
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy > 0) {
          // Swiped down
          onSwipeDown.call();
        } else {
          // Swiped up
          onSwipeUp.call();
        }
      },
      child: child,
    );
  }
}
