import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedScrollIndicator extends StatefulWidget {
  final VoidCallback onTap;
  const AnimatedScrollIndicator({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<AnimatedScrollIndicator> createState() =>
      _AnimatedScrollIndicatorState();
}

class _AnimatedScrollIndicatorState extends State<AnimatedScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 15)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("SCROLL",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2)),
              IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 32),
                  onPressed: widget.onTap),
            ],
          ),
        );
      },
    );
  }
}
