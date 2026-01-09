import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final num value;
  final TextStyle? style;
  final Duration duration;
  final bool isDecimal;
  final String suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 1500),
    this.isDecimal = false,
    this.suffix = '',
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.value.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String text;
        if (widget.isDecimal) {
          text = _animation.value.toStringAsFixed(1);
        } else {
          text = _animation.value.toInt().toString();
        }

        return Text(
          '$text${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
