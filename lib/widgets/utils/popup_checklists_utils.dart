import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';

class ChecklistsPage extends StatelessWidget {
  final ShortCard card;

  const ChecklistsPage({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    bool isChecklistEmpty = card.checklists == null || card.checklists!.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklists'),
        actions: <Widget>[
          if (!isChecklistEmpty)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton "Ajouter une nouvelle checklist"
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isChecklistEmpty)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Action à effectuer lors du clic sur le bouton "Créer une nouvelle checklist"
                  },
                  child: const Text('Créer une nouvelle checklist'),
                ),
              )
            else
              for (var checklist in card.checklists!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: checklist.name,
                              onChanged: (value) {
                                // Mettre à jour le nom de la checklist dans card.checklists
                                checklist.name = value;
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Action à effectuer lors du clic sur le bouton de suppression de la checklist
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var item in checklist.items)
                      Row(
                        children: [
                          Checkbox(
                            value: item.state == 'complete',
                            onChanged: (value) {
                              // Mettre à jour l'état de l'item dans card.checklists
                              item.state = value! ? 'complete' : 'incomplete';
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: item.name, // Utilise initialValue pour afficher le nom de l'item
                              onChanged: (value) {
                                // Mettre à jour le nom de l'item dans card.checklists
                                item.name = value;
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Action à effectuer lors du clic sur le bouton de suppression de l'item
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton "Ajouter un nouvel élément"
                        },
                        child: const Text('Add item...'),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}

void showChecklistsPage(BuildContext context, ShortCard card) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChecklistsPage(card: card)),
  );
}