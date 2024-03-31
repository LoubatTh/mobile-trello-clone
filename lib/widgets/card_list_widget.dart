import 'package:app/widgets/card/card_list.dart';
import 'package:flutter/material.dart';

class CardListWidget extends StatefulWidget {
  final String listId, listName;

  const CardListWidget({
    required Key key,
    required this.listId,
    required this.listName,
  }) : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.listName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75, 
                  child: CardList(key: const Key("cardList"), listId: widget.listId),
                ),
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
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog(
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
        },
      ),
      child: const Text('Add a card'),
    );
  }
}