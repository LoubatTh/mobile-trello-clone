import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:app/services/card_service.dart';

class CardList extends StatelessWidget {
  const CardList({required Key key, required this.listId}) : super(key: key);

  final String listId;

  @override
  Widget build(BuildContext context) {
    final Future<List<ShortCard>> cards = getCards(listId);

    return FutureBuilder<List<ShortCard>>(
      future: cards,
      builder: (BuildContext context, AsyncSnapshot<List<ShortCard>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final cardList = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var card in cardList)
                  material.Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.space_dashboard_rounded, size: 20),
                          title: Text(card.name, style: const TextStyle(fontSize: 14)),
                        ),
                        if (card.desc.isNotEmpty) // Vérifie si la description est non vide
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(card.desc),
                          ),
                        _buildChecklistInfo(card),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end, // Alignement à droite
                                  children: [
                                    _buildMemberAvatars(card.members),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildChecklistInfo(ShortCard card) {
    if (card.idChecklists != null && card.idChecklists!.length > 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.check_box, color: Colors.green), // Logo de la case à cocher
            const SizedBox(width: 8),
            Text('${card.idChecklists!.length} Checklists'),
          ],
        ),
      );
    } else if (card.idChecklists != null && card.idChecklists!.length == 1) {
      // Si une seule checklist est présente
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.check_box, color: Colors.green), // Logo de la case à cocher
            const SizedBox(width: 8),
            Text('${card.checklists!.first.name} : ${card.checklists!.first.getItemsChecked()}/${card.checklists!.first.items.length}' ),
          ],
        ),
      );
    } else {
      // Si aucune checklist n'est présente
      return const SizedBox.shrink();
    }
  }

  Widget _buildMemberAvatars(List<Member>? members) {
    if (members == null || members.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: members.map((member) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage("${member.avatarUrl}/60.png"),
            radius: 16,
          ),
        );
      }).toList(),
    );
  }
}