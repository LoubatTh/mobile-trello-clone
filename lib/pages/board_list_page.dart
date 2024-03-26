import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/board/create_board_button.dart';
import 'package:app/widgets/board/board_list.dart';
import 'package:flutter/material.dart';

class BoardListPage extends StatelessWidget {
  const BoardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 550,
                child: BoardList(
                  key: Key('boardList'),
                ),
              ),
              CreateBoardButton(
                key: Key('createBoardButton'),
              )
            ],
          )),
    );
  }
}
