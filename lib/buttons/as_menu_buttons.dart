import 'package:as_design_system/container/as_base_container.dart';
import 'package:flutter/material.dart';

class AsMenuButtonItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  AsMenuButtonItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });
}

class AsMenuButtons extends StatelessWidget {
  const AsMenuButtons({
    super.key,
    required this.items,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.enableBorder = false,
  });

  final List<AsMenuButtonItem> items;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    return AsBaseContainer(
      color: backgroundColor,
      radius: 16,
      enableBorder: enableBorder,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final isSelected = item.selected;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: item.onTap,
              child: AsBaseContainer(
                color: isSelected
                    ? (selectedColor ??
                          Theme.of(context).primaryColor.withOpacity(0.15))
                    : (unselectedColor ?? Colors.transparent),
                radius: 12,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
