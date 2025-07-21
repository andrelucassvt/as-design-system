import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        ...List.generate(40, (index) {
          return ListTile(
            title: Text('Button $index'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You tapped Button $index')),
              );
            },
          );
        }),
      ],
    );
  }
}
