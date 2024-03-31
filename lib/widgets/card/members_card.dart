import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';
import 'package:app/services/card_service.dart';

class MembersPage extends StatefulWidget {
  final String boardId;
  final ShortCard card;
  final CardService cardService;

  const MembersPage({
    super.key,
    required this.boardId,
    required this.card,
    required this.cardService,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  List<ShortMember>? members;
  CardService cardService = CardService();

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      final fetchedMembers = await cardService.getMembers(widget.boardId);
      setState(() {
        members = fetchedMembers;
      });
    } catch (e) {
      print('Erreur lors de la récupération des membres : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: members == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: members!.length,
              itemBuilder: (context, index) {
                final member = members![index];
                final bool isChecked =
                    widget.card.idMembers!.contains(member.id);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage("${member.avatarUrl}/60.png"),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          member.fullName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    leading: Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue ?? false) {
                            widget.card.idMembers!.add(member.id);
                            print("Membre ${member.id} coché");
                          } else {
                            widget.card.idMembers!.remove(member.id);
                            print("Membre ${member.id} décoché");
                          }
                          cardService.updateMember(widget.card);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}