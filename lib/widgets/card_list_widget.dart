import 'package:app/services/list_service.dart';
import 'package:app/widgets/card/card_list.dart';
import 'package:flutter/material.dart';
import 'package:app/services/card_service.dart';

final cardService = CardService();

class CardListWidget extends StatefulWidget {
  final String listId, listName;
  final ListService listService;

  const CardListWidget({
    required Key key,
    required this.listId,
    required this.listName,
    required this.listService,
  }) : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
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
        const SizedBox(height: 4.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: CardList(
                      key: const Key("cardList"), listId: widget.listId),
                ),
                CreateCardButton(
                  key: const Key('createCardButton'),
                  listId: widget.listId,
                  cardService: cardService,
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
  final String listId;
  final CardService cardService;

  const CreateCardButton({
    required Key key,
    required this.listId,
    required this.cardService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return TextButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create a new card'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the card name',
                      labelText: 'Name *',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the card description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
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
                  if (nameController.text.isNotEmpty) {
                    createCard(
                      nameController.text,
                      descriptionController.text,
                      listId,
                      cardService,
                    );
                    Navigator.of(context).pop();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please enter a card name.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Create'),
              ),
            ],
          );
        },
      ),
      child: const Text('Add a card'),
    );
  }

  void createCard(
      String name, String description, String listId, CardService cardService) {
    try {
      cardService.createCard(name, description, listId);
    } catch (e) {
      print('Erreur lors de la création de la carte : $e');
    }
  }
}
