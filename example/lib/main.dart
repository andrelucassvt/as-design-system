import 'package:as_design_system/config/as_config.dart';
import 'package:as_design_system/container/as_base_container.dart';
import 'package:as_design_system/navbar/as_navbar.dart';
import 'package:as_design_system/navbar/util/as_nav_icon.dart';
import 'package:example/pages/buttons_page.dart';
import 'package:example/pages/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AS Design System',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<ScrollController> _scrollControllers = List.generate(
    4,
    (_) => ScrollController(),
  );

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    AsConfig().init();
    _pages = [
      ButtonsPage(scrollController: _scrollControllers[0], key: Key('teste')),
      LoadingPage(scrollController: _scrollControllers[1], key: Key('search')),
      Container(color: Colors.green),
      Container(color: Colors.blue),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          IndexedStack(index: _selectedIndex, children: _pages),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AsBaseContainer(
                padding: const EdgeInsets.all(10),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.info, size: 20, color: Colors.black)],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AsNavbar(
                key: Key('navbar $_selectedIndex'),
                indexSelected: _selectedIndex,
                scrollController: _scrollControllers[_selectedIndex],
                floatingIconRight: AsNavIcon(
                  icon: Icon(Icons.home),
                  onTap: () {},
                ),
                navIcons: [
                  AsNavIcon(
                    title: 'Buttons',
                    icon: Icon(Icons.home),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  AsNavIcon(
                    title: 'Search',
                    icon: Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  AsNavIcon(
                    title: 'Novidades',
                    icon: Icon(Icons.person),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                  ),
                  AsNavIcon(
                    title: 'Settings',
                    icon: Icon(Icons.settings),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
