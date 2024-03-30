import 'package:app/services/list_service.dart';
import 'package:app/widgets/card/card_list.dart';
import 'package:flutter/material.dart';

class CardListWidget extends StatefulWidget {
  final String listId, listName;
  final ListService listService;

  const CardListWidget(
      {super.key,
      required this.listId,
      required this.listName,
      required this.listService});

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.listName,
              textWidthBasis: TextWidthBasis.longestLine,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: TextButton(
                      onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Rename list'),
                                    content: TextField(
                                      controller: textController,
                                      decoration: const InputDecoration(
                                          hintText: 'Enter the new list name'),
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
                                          widget.listService.renameList(
                                              widget.listId,
                                              textController.text);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Rename'),
                                      ),
                                    ],
                                  );
                                })
                          },
                      child: const Text('Rename',
                          style: TextStyle(color: Colors.white))),
                ),
                PopupMenuItem(
                  child: TextButton(
                      onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete list'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          widget.listService
                                              .archiveList(widget.listId, true);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                })
                          },
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.white))),
                ),
              ],
              onSelected: (value) {},
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardList(key: const Key("cardList"), listId: widget.listId),
                const CreateCardButton(
                  key: Key('createCardButton'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CreateCardButton extends StatelessWidget {
  const CreateCardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Create a new card'),
                content: const TextField(
                  decoration: InputDecoration(hintText: 'Enter the card name'),
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
      child: const Text('Add a card'),
    );
  }
}
