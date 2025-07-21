import 'package:as_design_system/as_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AsButton(
                onPressed: () {},
                color: Colors.green,
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
            Expanded(
              child: AsButton(
                onPressed: () {},
                color: Colors.red,
                child: Text(
                  'Esqueceu a senha',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AsButton(
                onPressed: () {},
                enableBorder: true,
                child: Text('Cadastrar'),
              ),
            ),
            Expanded(
              child: AsButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text('Continuar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // AsButton(
        //   onPressed: () {},
        //   child: CircularProgressIndicator(color: Colors.blue),
        // ),
        const SizedBox(height: 20),
        AsMenuButtons(
          items: [
            AsMenuButtonItem(
              title: 'Open pull request',
              icon: Icons.open_in_new,
              onTap: () {},
            ),
            AsMenuButtonItem(
              title: 'Another action',
              icon: Icons.settings,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
