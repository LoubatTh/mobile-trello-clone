import 'package:app/models/board_model.dart';
import 'package:app/pages/board_page.dart';
import 'package:app/services/board_service.dart';
import 'package:app/widgets/board/delete_board_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoardList extends StatefulWidget {
  const BoardList({super.key});

  @override
  State<BoardList> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  late Future<List<ShortBoardModel>> boards;

  @override
  void initState() {
    super.initState();
    boards = getAllBoards();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: boards,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: 60,
              height: 60,
              child: Center(child: CircularProgressIndicator()),
            );
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoardPage(
                          boardId: snapshot.data[index].id,
                          boardName: snapshot.data[index].name,
                        ),
                      ),
                    );
                  },
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

      final board = boardService.getAllBoards();
      if (kDebugMode) {
        print('Board: $board');
      }

      return await boardService.getAllBoards();
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return [];
    }
  }
}
