import 'package:app/services/card_service.dart';
import 'package:app/widgets/card/labels_card.dart';
import 'package:app/widgets/card/members_card.dart';
import 'package:app/widgets/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/utils/date_utils.dart';
import 'package:app/widgets/utils/popup_checklists_utils.dart';
import 'package:app/widgets/card/background_card.dart';

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
  late FocusNode descriptionFocusNode;
  final CardService cardService = CardService();
  late bool _isDueDateLocked;

  late final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.card.name);
    descriptionController = TextEditingController(text: widget.card.desc);
    descriptionFocusNode = FocusNode();
    startDateController = TextEditingController(
        text: widget.card.startDate != null
            ? _dateFormatter.format(widget.card.startDate!)
            : '');
    dueDateController = TextEditingController(
        text: widget.card.endDate != null
            ? _dateFormatter.format(widget.card.endDate!)
            : '');
    _isDueDateLocked = widget.card.dueComplete;
  }

  @override
  void dispose() {
    descriptionFocusNode.dispose();
    super.dispose();
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
                value: 'move',
                child: Text('Move card'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete card'),
              ),
              const PopupMenuItem(
                value: 'background',
                child: Text('Modify background'),
              ),
            ],
            onSelected: (value) {
              if (value == 'move') {
                _showMoveCardDialog(widget.card);
              } else if (value == 'delete') {
                _showDeleteConfirmationDialog(widget.card.id);
              } else if (value == 'background') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BackgroundPopup(
                      shortCard: widget.card,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      onEditingComplete: () async {
                        await cardService.updateCard(
                            widget.card.id, "name", titleController.text);
                        setState(() {
                          print(
                              "card name changed with ${titleController.text}");
                          widget.card.name = titleController.text;
                        });
                      }),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: '   In list: ',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${widget.card.listname}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                        focusNode: descriptionFocusNode,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Add a description"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: startDateController,
                    readOnly: true,
                    onTap: () => selectStartDate(
                        context, startDateController, widget.card, cardService),
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      suffixIcon: Icon(Icons.date_range),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: _isDueDateLocked &&
                            dueDateController.text.isNotEmpty,
                        onChanged: (newValue) {
                          if (dueDateController.text.isNotEmpty) {
                            cardService.updateCard(widget.card.id,
                                "dueComplete", newValue.toString());
                            print("Due date locked: $newValue");
                            setState(() {
                              _isDueDateLocked = newValue!;
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: dueDateController,
                          readOnly: true,
                          enabled: !_isDueDateLocked,
                          onTap: _isDueDateLocked
                              ? null
                              : () => selectDueDate(context, dueDateController,
                                  widget.card, cardService),
                          decoration: InputDecoration(
                            labelText: 'Due Date',
                            suffixIcon: const Icon(Icons.date_range),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _isDueDateLocked
                                    ? Colors.grey
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      _showLabelsPopup(context, widget.card);
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
                      showChecklistsPage(context, widget.card, cardService);
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
                      _showMembersPopup(context, widget.card, cardService);
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

  void _showLabelsPopup(BuildContext context, ShortCard card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LabelsPage(boardId: card.idBoard, card: card),
      ),
    );
  }

  void _showMembersPopup(
      BuildContext context, ShortCard card, CardService cardService) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MembersPage(
            boardId: card.idBoard, card: card, cardService: cardService),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    descriptionFocusNode.addListener(_onDescriptionFocusChange);
  }

  void _onDescriptionFocusChange() {
    if (!descriptionFocusNode.hasFocus) {
      cardService.updateCard(
          widget.card.id, "desc", descriptionController.text);
    }
  }

  void _showMoveCardDialog(ShortCard card) async {
    final List<Lists> listNames = await cardService.getLists(card.idBoard);
    Lists? selectedList;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Move card'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<Lists>(
                hint: Text('Select a list'),
                value: selectedList,
                onChanged: (newValue) {
                  setState(() {
                    selectedList = newValue;
                  });
                },
                items: listNames.map((Lists list) {
                  return DropdownMenuItem<Lists>(
                    value: list,
                    child: Text(list.name),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedList != null) {
                  print("Card moved to ${selectedList!.id}");
                  cardService.updateCard(card.id, "idList", selectedList!.id);
                  Navigator.pop(context);
                }
              },
              child: Text('Move'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String cardId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete card?'),
          content: Text('Are you sure you want to delete this card?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                cardService.deleteCard(cardId);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
