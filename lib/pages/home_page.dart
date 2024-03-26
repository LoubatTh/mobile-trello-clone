import 'package:app/pages/board_page.dart';
import 'package:app/pages/card_page.dart';
import 'package:app/pages/workspace_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: <Widget>[
          const Text('Welcome to the Home Page'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WorkspacePage()),
              );
            },
            child: const Text('Go to Workspace Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BoardPage()),
              );
            },
            child: const Text('Go to Board Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CardPage(
                          listId: '6549fbfc898976d651f9d8cf',
                        )),
              );
            },
            child: const Text('Go to Card Page'),
          ),
        ],
      ),
    );
  }
}
