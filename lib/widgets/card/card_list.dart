import 'package:app/widgets/utils/buildshortcard_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:app/services/card_service.dart';
import 'package:app/widgets/card/card_fullscreen.dart';
import 'package:app/widgets/utils/color_utils.dart';
import 'package:flutter/services.dart';

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
    if (card.cover != null && card.cover!.size == 'full') {
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
                if (card.cover?.color != null) buildCardContent(card),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white12,
            child: buildCardContent(card),
          ),
        ),
      );
    }
  }
}
