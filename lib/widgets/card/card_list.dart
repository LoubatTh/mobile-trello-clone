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
                  buildCardWidget(card),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildCardWidget(ShortCard card) {
    if (card.cover!.size == 'full') {
      Color? bannerColor = getColor(card.cover!.color!);
      return material.Card(
        color: bannerColor ?? Colors.transparent,
        child: buildCardContent(card),
      );
    } else {
      return material.Card(
        child: buildCardContent(card),
      );
    }
  }

  Widget buildCardContent(ShortCard card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.space_dashboard_rounded, size: 20),
          title: Text(card.name, style: const TextStyle(fontSize: 14)),
        ),
        if (card.desc.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(card.desc),
          ),
        _buildChecklistInfo(card),
        _buildMemberAvatars(card.members, card.cover, card.labels),
        ],
    );
  }

  Widget _buildChecklistInfo(ShortCard card) {
    if (card.idChecklists != null && card.idChecklists!.length > 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.check_box, color: Colors.green),
            const SizedBox(width: 8),
            Text('${card.idChecklists!.length} Checklists'),
          ],
        ),
      );
    } else if (card.idChecklists != null && card.idChecklists!.length == 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.check_box, color: Colors.green),
            const SizedBox(width: 8),
            Text(
                '${card.checklists!.first.name} : ${card.checklists!.first.getItemsChecked()}/${card.checklists!.first.items.length}'),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

Widget _buildMemberAvatars(List<Member>? members, Cover? cover, List<Label>? labels) {
  Color? bannerColor;
  if (cover != null && cover.size != 'full' && cover.color != null) {
    bannerColor = getColor(cover.color!);
  }

  final double labelsContainerWidth = 250.0; // Taille fixe pour le container des labels

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: bannerColor ?? Colors.transparent,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: labelsContainerWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (labels != null && labels.isNotEmpty)
                  for (var label in labels)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      margin: const EdgeInsets.only(right: 4.0),
                      decoration: BoxDecoration(
                        color: getColor(label.color) ?? Colors.transparent,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        label.name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.0), // Espacement entre le container des labels et le container des avatars
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (members != null && members.isNotEmpty)
                  for (var member in members)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${member.avatarUrl}/60.png"),
                        radius: 16.0,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  material.Color? getColor(String s) {
    switch (s) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      case 'purple':
        return Colors.purple;
      case 'blue':
        return Colors.blue;
      case 'sky':
        return Colors.lightBlue;
      case 'lime':
        return Colors.lime;
      case 'pink':
        return Colors.pink;
      case 'black':
        return Colors.grey;
      default:
        return null;
    }
  }
}