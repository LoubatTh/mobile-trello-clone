import 'package:app/services/board_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateBoardButton extends StatelessWidget {
  const CreateBoardButton({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return FloatingActionButton(
        backgroundColor: Colors.white10,
        focusColor: Colors.white30,
        onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Create a new board'),
                      content: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                            hintText: 'Enter the board name'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            createBoard(textController.text);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Create'),
                        ),
                      ],
                    );
                  })
            },
        child: const Icon(Icons.add, color: Colors.white70, size: 30));
  }

  Future<void> createBoard(String name) async {
    try {
      final BoardService boardService = BoardService();
      boardService.createBoard(name);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}

