import 'package:app/services/list_service.dart';
import 'package:app/models/list_model.dart';
import 'package:app/widgets/board/delete_board_button.dart';
import 'package:app/widgets/board/update_board_button.dart';
import 'package:app/widgets/card_list_widget.dart';
import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  final String boardId, boardName;

  const BoardPage({super.key, required this.boardId, required this.boardName});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  ListService listService = ListService();
  late Future<List<ListModel>> futureLists;

  @override
  void initState() {
    super.initState();
    futureLists = listService.getAllBoardLists(widget.boardId).then((value) {
      value.sort((a, b) => a.pos.compareTo(b.pos));
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.boardName),
          actions: [
            UpdateBoardButton(boardId: widget.boardId),
            DeleteBoardButton(boardId: widget.boardId)
          ],
          // TODO: Add a button to manage (update, delete) the board
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: futureLists,
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
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.white10,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CardListWidget(
                          listId: snapshot.data[index].id,
                          listName: snapshot.data[index].name,
                        ),
                      );
                    },
                  );
                }
              },
            )),
            Container(
              // color: Colors.white10,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: const CreateListButton(),
            )
          ],
        ));
  }
}

class CreateListButton extends StatelessWidget {
  const CreateListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white70),
        backgroundColor: Colors.white10,
      ),
      onPressed: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Create a new list'),
                content: const TextField(
                  decoration: InputDecoration(hintText: 'Enter the list name'),
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
                      // createCard(textController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            })
      },
      child: const Text('Create a list'),
    );
  }
}
