import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:app/services/card_service.dart';

class ChecklistsPage extends StatefulWidget {
  final ShortCard card;
  final CardService cardService;

  const ChecklistsPage({Key? key, required this.card, required this.cardService}) : super(key: key);

  @override
  _ChecklistsPageState createState() => _ChecklistsPageState();
}

class _ChecklistsPageState extends State<ChecklistsPage> {
  late Future<List<Checklist>> _checklistsFuture;

  @override
  void initState() {
    super.initState();
    _checklistsFuture = widget.cardService.getChecklists(widget.card.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklists'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showCreateChecklistDialog(context, widget.card, widget.cardService);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Checklist>>(
        future: _checklistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  _showCreateChecklistDialog(context, widget.card, widget.cardService);
                },
                child: const Text('Create new checklist'),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(snapshot.data![index].name),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data![index].items.map((item) {
                          return Row(
                            children: [
                              Checkbox(
                                value: item.state == 'true',
                                onChanged: (bool? value) {
                                  // _updateItemState(item, value!);
                                },
                              ),
                              Text(item.name),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showAddItemDialog(context, snapshot.data![index], widget.cardService);
                      },
                      child: const Text('Add item'),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _showCreateChecklistDialog(BuildContext context, ShortCard card, CardService cardService) async {
    String? newChecklistName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? name;
        return AlertDialog(
          title: const Text('Create Checklist'),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: InputDecoration(hintText: "Enter checklist name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (name != null && name!.isNotEmpty) {
                  cardService.createChecklist(card.id, name!);
                  Navigator.pop(context, name);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
    if (newChecklistName != null) {
      setState(() {
        _checklistsFuture = cardService.getChecklists(card.id);
      });
    }
  }

  Future<void> _showAddItemDialog(BuildContext context, Checklist checklist, CardService cardservice) async {
    String? itemName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? name;
        return AlertDialog(
          title: const Text('Add Item'),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: InputDecoration(hintText: "Enter item name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (name != null && name!.isNotEmpty) {
                  // Call API to add new item to the checklist
                  await cardservice.addItemChecklist(checklist.id, name!);
                  Navigator.pop(context); // Close the dialog
                  setState(() {
                    _checklistsFuture = widget.cardService.getChecklists(widget.card.id);
                  });
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _updateItemState(Item item, bool newState) async {
  //   String newStateString = newState ? 'true' : 'false';
  //   await widget.cardService.checkedItems(item.id, item.name, newStateString);
  //   setState(() {
  //     item.state = newStateString;
  //   });
  // }
}

void showChecklistsPage(BuildContext context, ShortCard card, CardService cardService) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChecklistsPage(card: card, cardService: cardService)),
  );
}