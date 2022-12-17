import "package:flutter/material.dart";

class HoverEffect extends StatefulWidget {
  const HoverEffect({super.key, required this.child});
  final Widget child;

  @override
  State<HoverEffect> createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..translate(0.0, -8.0, 0.0);
    final transform = _isHovering ? hoveredTransform : Matrix4.identity();

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: transform,
        child: widget.child,
      ),
    );
  }
}
