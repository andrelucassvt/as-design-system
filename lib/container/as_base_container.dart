import 'package:as_design_system/config/as_color_base.dart';
import 'package:flutter/material.dart';

class AsBaseContainer extends StatelessWidget {
  const AsBaseContainer({
    required this.child,
    this.padding,
    this.constraints,
    this.color,
    this.shape = BoxShape.rectangle,
    this.width,
    this.height,
    this.radius = 50.0,
    this.enableBorder = false,
    this.elevation = 0.0,
    super.key,
  });
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final Color? color;
  final BoxShape shape;
  final double? width;
  final double? height;
  final double radius;
  final Widget child;
  final bool enableBorder;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: color ?? AsColorBase.primaryColor(context),
      shape: shape,
      border: enableBorder ? Border.all() : null,
      borderRadius: shape == BoxShape.rectangle
          ? BorderRadius.circular(radius)
          : null,
    );

    final content = Container(
      padding: padding,
      constraints: constraints,
      width: width,
      height: height,
      decoration: boxDecoration,
      child: child,
    );

    if (elevation != 0.0) {
      return Card(
        elevation: elevation,
        shape: shape == BoxShape.rectangle
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              )
            : const CircleBorder(),
        color: color ?? AsColorBase.primaryColor(context),
        child: content,
      );
    }

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}
