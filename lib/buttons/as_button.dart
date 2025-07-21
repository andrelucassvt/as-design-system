import 'package:as_design_system/container/as_base_container.dart';
import 'package:flutter/material.dart';

class AsButton extends StatefulWidget {
  const AsButton({
    required this.onPressed,
    required this.child,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.elevation = 1,
    this.enableBorder = false,
    super.key,
  });
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double elevation;
  final double? width;
  final double? height;
  final Color? color;
  final bool enableBorder;

  @override
  State<AsButton> createState() => _AsButtonState();
}

class _AsButtonState extends State<AsButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AsBaseContainer(
        enableBorder: widget.enableBorder,
        color: widget.color,
        width: widget.width,
        height: widget.height,
        padding: widget.padding ?? EdgeInsets.all(16.0),
        elevation: widget.elevation,
        child: Center(child: widget.child),
      ),
    );
  }
}
