import 'package:as_design_system/config/as_color_base.dart';
import 'package:as_design_system/container/as_base_container.dart';
import 'package:as_design_system/navbar/util/as_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AsNavbar extends StatefulWidget {
  const AsNavbar({
    super.key,
    required this.navIcons,
    required this.indexSelected,
    this.floatingIconLeft,
    this.floatingIconRight,
    this.colorSelected,
    this.scrollController,
    this.enableBorder = false,
    this.padding,
    this.backgroundColor,
    this.colorItemSelected,
    this.width,
  });
  final List<AsNavIcon> navIcons;
  final AsNavIcon? floatingIconLeft;
  final AsNavIcon? floatingIconRight;
  final int indexSelected;
  final Color? colorSelected;
  final ScrollController? scrollController;
  final bool enableBorder;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? colorItemSelected;

  /// Apenas para o caso de ter menos de 4 itens no navbar
  final double? width;

  @override
  State<AsNavbar> createState() => _AsNavbarState();
}

class _AsNavbarState extends State<AsNavbar> {
  bool isScroll = false;

  @override
  void initState() {
    super.initState();

    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_handleScroll);
    }
  }

  void _handleScroll() {
    if (mounted) {
      final direction = widget.scrollController!.position.userScrollDirection;
      setState(() {
        isScroll = direction == ScrollDirection.reverse ? true : false;
      });
    }
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        switchInCurve: Curves.easeInCubic,
        switchOutCurve: Curves.easeOutCubic,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            ),
            child: child,
          );
        },
        child: isScroll
            ? InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isScroll = false;
                  });
                },
                child: Row(
                  key: const ValueKey('floatingIcon'),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AsBaseContainer(
                        shape: BoxShape.circle,
                        color: widget.backgroundColor,
                        enableBorder: widget.enableBorder,
                        elevation: 1,
                        width: 50,
                        height: 50,
                        child: _iconBase(
                          widget.navIcons[widget.indexSelected],
                          size: 26,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )
            : Row(
                key: const ValueKey('navbar'),
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.floatingIconLeft != null) ...[
                    InkWell(
                      onTap: widget.floatingIconLeft!.onTap,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: AsBaseContainer(
                          shape: BoxShape.circle,
                          width: widget.navIcons.first.title == null ? 45 : 60,
                          height: widget.navIcons.first.title == null ? 45 : 60,
                          elevation: 1,
                          color: widget.backgroundColor,
                          enableBorder: widget.enableBorder,
                          child: _onTapIcon(widget.floatingIconLeft!),
                        ),
                      ),
                    ),
                  ],
                  _buildNavBarContainer(context),
                  if (widget.floatingIconRight != null) ...[
                    InkWell(
                      onTap: widget.floatingIconRight!.onTap,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: AsBaseContainer(
                          shape: BoxShape.circle,
                          width: widget.navIcons.first.title == null ? 45 : 60,
                          height: widget.navIcons.first.title == null ? 45 : 60,
                          elevation: 1,
                          color: widget.backgroundColor,
                          enableBorder: widget.enableBorder,
                          child: _onTapIcon(widget.floatingIconRight!),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _iconBase(AsNavIcon item, {double? size, bool isSelected = false}) {
    return IconTheme(
      data: IconThemeData(
        color: isSelected
            ? widget.colorItemSelected ?? AsColorBase.iconColor(context)
            : AsColorBase.iconColor(context),
        size: size ?? 26,
      ),
      child: item.icon,
    );
  }

  Widget _onTapIcon(AsNavIcon item, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _iconBase(item, isSelected: isSelected),
        if (item.title != null)
          Text(
            item.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected
                  ? widget.colorItemSelected ?? AsColorBase.textColor(context)
                  : AsColorBase.textColor(context),
              fontSize: 10,
            ),
          ),
      ],
    );
  }

  double _calcNavBarWidth(BuildContext context) {
    const double itemWidth = 100;
    double extra = 0;
    if (widget.floatingIconLeft != null) {
      extra += 65;
    }
    if (widget.floatingIconRight != null) {
      extra += 65;
    }
    return (itemWidth * widget.navIcons.length) + extra;
  }

  Widget _buildNavBarContainer(BuildContext context) {
    final bool expand = widget.navIcons.length > 3;
    final navBar = AsBaseContainer(
      padding: const EdgeInsets.all(5),
      enableBorder: widget.enableBorder,
      elevation: 1,
      color: widget.backgroundColor,
      width: expand ? null : widget.width ?? _calcNavBarWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.navIcons.asMap().entries.take(4).map((item) {
          final isSelected = item.key == widget.indexSelected;
          return Expanded(
            child: InkWell(
              onTap: item.value.onTap,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: AsBaseContainer(
                padding: isSelected
                    ? const EdgeInsets.symmetric(vertical: 5, horizontal: 0)
                    : null,
                color: isSelected
                    ? widget.colorSelected ?? Colors.grey.withValues(alpha: .3)
                    : Colors.transparent,
                child: _onTapIcon(item.value, isSelected: isSelected),
              ),
            ),
          );
        }).toList(),
      ),
    );
    return expand ? Expanded(child: navBar) : navBar;
  }
}
