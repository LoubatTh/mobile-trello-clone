import 'package:app/services/board_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateBoardButton extends StatelessWidget {
  final String boardId;

  const UpdateBoardButton({super.key, required this.boardId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return IconButton(
        focusColor: Colors.white30,
        onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Rename board'),
                      content: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                            hintText: 'Enter the new board name'),
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
                            updateBoard(boardId, textController.text);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Create'),
                        ),
                      ],
                    );
                  })
            },
        icon: const Icon(Icons.edit, color: Colors.white70, size: 20));
  }

  Future<void> updateBoard(String id, String name) async {
    try {
      final BoardService boardService = BoardService();
      boardService.renameBoard(id, name);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}
