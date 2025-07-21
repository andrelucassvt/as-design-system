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
    this.floatingIconRight,
    this.colorSelected,
    this.scrollController,
    this.enableBorder = false,
  });
  final List<AsNavIcon> navIcons;
  final AsNavIcon? floatingIconRight;
  final int indexSelected;
  final Color? colorSelected;
  final ScrollController? scrollController;
  final bool enableBorder;

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
      padding: const EdgeInsets.all(8.0),
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
                child: SizedBox(
                  height: 75,
                  child: Row(
                    key: const ValueKey('floatingIcon'),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AsBaseContainer(
                        shape: BoxShape.circle,
                        enableBorder: widget.enableBorder,
                        elevation: 1,
                        width: 50,
                        height: 50,
                        child: _iconBase(
                          widget.navIcons[widget.indexSelected],
                          size: 26,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              )
            : Row(
                key: const ValueKey('navbar'),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AsBaseContainer(
                      padding: const EdgeInsets.all(5),
                      enableBorder: widget.enableBorder,
                      elevation: 1,
                      constraints: BoxConstraints(maxHeight: 70, minHeight: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.navIcons.asMap().entries.take(4).map((
                          item,
                        ) {
                          final isSelected = item.key == widget.indexSelected;
                          return Expanded(
                            child: InkWell(
                              onTap: item.value.onTap,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: AsBaseContainer(
                                padding: isSelected
                                    ? const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 0,
                                      )
                                    : null,
                                color: isSelected
                                    ? widget.colorSelected ??
                                          Colors.grey.withValues(alpha: .3)
                                    : Colors.transparent,
                                child: _onTapIcon(item.value),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  if (widget.floatingIconRight != null) ...[
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: widget.floatingIconRight!.onTap,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: AsBaseContainer(
                        shape: BoxShape.circle,
                        width: 60,
                        height: 60,
                        elevation: 1,
                        enableBorder: widget.enableBorder,
                        child: _onTapIcon(widget.floatingIconRight!),
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _iconBase(AsNavIcon item, {double? size}) {
    return IconTheme(
      data: IconThemeData(
        color: AsColorBase.iconColor(context),
        size: size ?? (item.title != null ? 20 : 26),
      ),
      child: item.icon,
    );
  }

  Widget _onTapIcon(AsNavIcon item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _iconBase(item),
        if (item.title != null)
          Text(
            item.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AsColorBase.textColor(context),
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
