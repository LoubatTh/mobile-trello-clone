import 'package:app/services/board_service.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/board/create_board_button.dart';
import 'package:app/widgets/board/board_list.dart';
import 'package:flutter/material.dart';

class BoardListPage extends StatefulWidget {
  const BoardListPage({super.key});

  @override
  State<BoardListPage> createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  final BoardService boardService = BoardService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 550,
                child: BoardList(
                  key: const Key('boardList'),
                  boardService: boardService,
                ),
              ),
              CreateBoardButton(
                key: const Key('createBoardButton'),
                boardService: boardService,
              )
            ],
          )),
    );
  }
}       