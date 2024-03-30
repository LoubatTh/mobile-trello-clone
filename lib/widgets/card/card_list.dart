import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:app/services/card_service.dart';
import 'package:app/widgets/card/card_fullscreen.dart';
import 'package:app/widgets/utils/color_utils.dart';

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
                  Column(
                    children: [
                      buildClickableCardWidget(context, card),
                      const SizedBox(height: 8.0),
                    ],
                  )
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildClickableCardWidget(BuildContext context, ShortCard card) {
    if (card.cover!.size == 'full') {
      Color? bannerColor = getColor(card.cover!.color!);
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(card: card),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: bannerColor ?? Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (card.cover != null) 
                  buildCardContent(card),
              ],
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(card: card),
            ),
          );
        },
        child: Container(
          child: buildCardContent(card),
        ),
      );
    }
  }

  Widget buildCardContent(ShortCard card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopCard(card.members, card.cover, card.labels),
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
        _buildAvatarMembers(card.members),
        const SizedBox(height: 8.0),
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
            const Icon(Icons.check_box, color: Colors.green),
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

Widget _buildTopCard(
  List<Member>? members, Cover? cover, List<Label>? labels) {
  Color? bannerColor;

  bool fullCover = cover?.size == 'full';

  if (!fullCover && cover?.color != null) {
    bannerColor = getColor(cover!.color!);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!fullCover && cover != null)
        Container(
          width: double.infinity,
          height: 45,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: bannerColor ?? Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      if (!fullCover && cover != null)
        const SizedBox(height: 8.0),
      if (!fullCover && cover != null)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (labels != null && labels.isNotEmpty)
                for (var label in labels)
                  Container(
                    width: 40.0,
                    height: 20.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      color: getColor(label.color) ?? Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
            ],
          ),
        ),
      if (!fullCover && cover != null) const SizedBox(height: 8.0),
    ],
  );
}

Widget _buildAvatarMembers(List<Member>? members) {
  return SingleChildScrollView(
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
  );
}
}

