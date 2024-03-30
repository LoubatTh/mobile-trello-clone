import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CardListWidget extends StatefulWidget {
  final String listId, listName;

  const CardListWidget(
      {super.key, required this.listId, required this.listName});

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  // CardService cardService = CardService();
  // late Future<List<CardModel>> futureCards;

  @override
  void initState() {
    super.initState();
    // futureCards = cardService.getAllListCards(widget.listId).then((value) {
    //   value.sort((a, b) => a.pos.compareTo(b.pos));
    //   return value;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            widget.listName),
        // FutureBuilder(
        //     future: futureCards,
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const SizedBox(
        //           width: 60,
        //           height: 60,
        //           child: Center(child: CircularProgressIndicator()),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Text('Error: ${snapshot.error}');
        //       } else {
        //         // TODO: return card list builder
        //         return const Placeholder();
        //       }
        //     }),
        const CreateCardButton(
          key: Key('createCardButton'),
        )
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
