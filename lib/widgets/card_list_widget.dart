import 'package:app/widgets/card/card_list.dart';
import 'package:flutter/material.dart';
import 'package:app/services/card_service.dart'; 

final cardService = CardService(); 

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
                // Passer cardService à CreateCardButton
                CreateCardButton(
                  key: const Key('createCardButton'),
                  listId: widget.listId,
                  cardService: cardService, // Utiliser le service de carte passé par le parent
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
  final CardService cardService; // Ajouter CardService comme paramètre

  const CreateCardButton({
    required Key key,
    required this.listId,
    required this.cardService, // Mettre à jour le constructeur
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
                      cardService, // Utiliser le service de carte passé par le parent
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

  void createCard(String name, String description, String listId, CardService cardService) {
    try {
      cardService.createCard(name, description, listId);
    } catch (e) {
      print('Erreur lors de la création de la carte : $e');
    }
  }
}