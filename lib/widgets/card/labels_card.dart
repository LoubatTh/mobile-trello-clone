import 'package:app/models/card_model.dart';
import 'package:app/services/card_service.dart';
import 'package:app/widgets/utils/color_utils.dart';
import 'package:flutter/material.dart';

class LabelsPage extends StatefulWidget {
  final String boardId;
  final ShortCard card;

  const LabelsPage({super.key, required this.boardId, required this.card});

  @override
  // ignore: library_private_types_in_public_api
  _LabelsPageState createState() => _LabelsPageState();
}

class _LabelsPageState extends State<LabelsPage> {
  List<Label>? labels;
  CardService cardService = CardService();

  @override
  void initState() {
    super.initState();
    _fetchLabels();
  }

  Future<void> _fetchLabels() async {
    try {
      final fetchedLabels = await cardService.getLabels(widget.boardId);
      setState(() {
        labels = fetchedLabels;
      });
    } catch (e) {
      // Gérer les erreurs d'appel API ici
      print('Erreur lors de la récupération des étiquettes : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Labels'),
      ),
      body: labels == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: labels!.length,
              itemBuilder: (context, index) {
                final label = labels![index];
                final bool isChecked = widget.card.idLabels!.contains(label.id);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(
                      label.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        // Vous pouvez ajouter ici la logique pour modifier l'état de la case
                        setState(() {
                          // Mettez à jour card.idLabels en fonction du label.id et newValue
                          if (newValue ?? false) {
                            widget.card.idLabels!.add(label.id);
                          } else {
                            widget.card.idLabels!.remove(label.id);
                          }
                        });
                      },
                    ),
                    tileColor: getColor(label.color),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
