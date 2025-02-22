import 'package:app/models/board_model.dart';
import 'package:app/pages/board_page.dart';
import 'package:app/services/board_service.dart';
import 'package:app/widgets/board/delete_board_button.dart';
import 'package:flutter/material.dart';

class BoardList extends StatefulWidget {
  final BoardService boardService;

  const BoardList({super.key, required this.boardService});

  @override
  State<BoardList> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  late Future<List<ShortBoardModel>> boardsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: boardsFuture,
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
                          boardService: widget.boardService,
                        ),
                      ),
                    );
                  },
                  trailing: DeleteBoardButton(
                    key: const Key('deleteBoardButton'),
                    boardId: snapshot.data[index].id,
                    boardService: widget.boardService,
                  ),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                );
              },
            );
          }
        });
  }
}
