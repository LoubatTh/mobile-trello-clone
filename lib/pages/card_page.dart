import 'package:flutter/material.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/card/card_list.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CardList(
          key: const Key('cardList'),
          listId: listId,
        ),
      ),
    );
  }
}
