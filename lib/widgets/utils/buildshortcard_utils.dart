import 'package:app/models/card_model.dart';
import 'package:app/widgets/utils/color_utils.dart';
import 'package:flutter/material.dart';

Widget buildCardContent(ShortCard card) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(card.cover != null && card.cover!.size == 'normal' && card.cover!.color != null)
        Container(
          height: 45,
          decoration: BoxDecoration(
              color: getColor(card.cover!.color!),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
          ),
        ),
      if (card.labels != null && card.labels!.isNotEmpty)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _buildLabels(card.labels),
        ),
      ListTile(
        leading: const Icon(Icons.space_dashboard_rounded, size: 20),
        title: Text(card.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      if (card.desc.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(card.desc),
        ),
      if (card.checklists != null && card.checklists!.isNotEmpty)
        _buildChecklistInfo(card),
      const SizedBox(height: 4.0),
      if (card.members != null && card.members!.isNotEmpty)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _buildAvatarMembers(card.members),
        ),
        const SizedBox(height: 4.0),
    ],
  );
}

Widget _buildLabels(List<Label>? labels) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
    child: Row(
      children: [
        for (var label in labels ?? [])
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: getColor(label.color),
            ),
          ),
      ],
    ),
  );
}

  Widget _buildChecklistInfo(ShortCard card) {
    if (card.idChecklists != null && card.idChecklists!.length > 1) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
        child: Row(
          children: [
            const SizedBox(width: 10),
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
            const SizedBox(width: 6),
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