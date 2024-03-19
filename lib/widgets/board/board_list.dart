import 'package:app/models/board_model.dart';
import 'package:app/services/board_service.dart';
import 'package:app/widgets/board/delete_board_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllBoards(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.space_dashboard_rounded, size: 20),
                  title: Text(snapshot.data[index].name,
                      style: const TextStyle(fontSize: 14)),
                  trailing: DeleteBoardButton(
                      key: const Key('deleteBoardButton'),
                      boardId: snapshot.data[index].id),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                );
              },
            );
          }
        });
  }

  Future<List<ShortBoardModel>> getAllBoards() async {
    try {
      final BoardService boardService = BoardService();
      return boardService.getAllBoards();
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return [];
    }
  }
}
