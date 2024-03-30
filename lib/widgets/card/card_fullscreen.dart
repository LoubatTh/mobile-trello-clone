import 'package:app/widgets/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/utils/date_utils.dart';
import 'package:app/widgets/utils/popup_checklists_utils.dart';

class CardDetailScreen extends StatefulWidget {
  final ShortCard card;

  const CardDetailScreen({super.key, required this.card});

  @override
  // ignore: library_private_types_in_public_api
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startDateController;
  late TextEditingController dueDateController;
  late bool _isDueDateLocked;

  late final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.card.name);
    descriptionController = TextEditingController(text: widget.card.desc);
    startDateController = TextEditingController(
        text: widget.card.startDate != null
            ? _dateFormatter.format(widget.card.startDate!)
            : '');
    dueDateController = TextEditingController(
        text: widget.card.endDate != null
            ? _dateFormatter.format(widget.card.endDate!)
            : '');
    _isDueDateLocked = widget.card.dueComplete; // Initialiser à false par défaut
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Action à effectuer lors du clic sur le bouton "Ajouter un membre"
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Option 1'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Option 2'),
              ),
              // Ajoutez ici d'autres options du menu contextuel
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ajouter une bannière de couverture
            Container(
              height: widget.card.cover?.color != null ? 200 : 80,
              color: widget.card.cover?.color != null
                  ? getColor(widget.card.cover!.color!)
                  : Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        widget.card.name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: '   In list: ',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${widget.card.listname}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Add a description"),
                        onChanged: (value) {
                          setState(() {
                            widget.card.desc = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: startDateController,
                    readOnly: true,
                    onTap: () => selectStartDate(
                        context, startDateController, widget.card),
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      suffixIcon: Icon(Icons.date_range),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: _isDueDateLocked,
                        onChanged: (newValue) {
                          setState(() {
                            _isDueDateLocked = newValue!;
                          });
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: dueDateController,
                          readOnly: true,
                          enabled: !_isDueDateLocked,
                          onTap: _isDueDateLocked
                              ? null
                              : () => selectDueDate(
                                  context, dueDateController, widget.card),
                          decoration: InputDecoration(
                            labelText: 'Due Date',
                            suffixIcon: const Icon(Icons.date_range),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isDueDateLocked
                                      ? Colors.grey
                                      : Theme.of(context).colorScheme.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Ajouter ici d'autres détails de la carte
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8), // Ajout du padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Action à effectuer lors du clic sur "Labels..."
                      _showLabelsPopup(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Labels...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      showChecklistsPage(context,widget.card);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Checklists...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // Action à effectuer lors du clic sur "Members..."
                      _showMembersPopup(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Members...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

void _showLabelsPopup(BuildContext context) {
  // Afficher la pop-up des labels ici
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Labels...'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Afficher chaque label de la carte
              for (var label in widget.card.labels!)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: getColor(label.color),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label.name,
                    style: TextStyle(color: Colors.white),
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
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}


  void _showMembersPopup(BuildContext context) {
    // Afficher la pop-up des membres ici
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Members...'),
          content: const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Ajouter ici la liste des membres
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
