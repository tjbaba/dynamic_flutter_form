import 'dart:async';
import 'package:flutter/material.dart';

/// Your original flashing widget design
class FlashingWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? beforeFlashing;

  const FlashingWidget({
    super.key,
    required this.child,
    required this.onTap,
    this.beforeFlashing,
  });

  @override
  State<FlashingWidget> createState() => _FlashingWidgetState();
}

class _FlashingWidgetState extends State<FlashingWidget> {
  bool isFlashing = false;

  void _startFlashing() {
    setState(() {
      isFlashing = true;
      if (widget.beforeFlashing != null) {
        widget.beforeFlashing!();
      }
    });

    int flashCount = 0;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        isFlashing = !isFlashing;
        flashCount++;
      });

      if (flashCount == 5) {
        timer.cancel();
        widget.onTap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFlashing ? null : _startFlashing,
      child: AnimatedOpacity(
        opacity: isFlashing ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}

/// Legacy widget name for backward compatibility
class FlashingWidgetScreen extends FlashingWidget {
  const FlashingWidgetScreen({
    super.key,
    required super.child,
    required super.onTap,
    super.beforeFlashing,
  });
}