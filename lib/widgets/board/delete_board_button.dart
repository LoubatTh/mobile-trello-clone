import 'package:app/services/board_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeleteBoardButton extends StatelessWidget {
  final String boardId;

  const DeleteBoardButton({super.key, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        focusColor: Colors.white30,
        onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Board'),
                    content: const Text(
                        'Are you sure you want to delete this board?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () =>
                            {deleteBoard(boardId), Navigator.of(context).pop()},
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              )
            },
        icon: const Icon(Icons.delete, color: Colors.white70, size: 20));
  }

  Future<void> deleteBoard(String id) async {
    try {
      final BoardService boardService = BoardService();
      boardService.deleteBoard(id);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}
