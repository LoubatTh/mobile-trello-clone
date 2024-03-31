import 'package:app/widgets/card_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/models/card_model.dart';

class BackgroundPopup extends StatefulWidget {
  final ShortCard shortCard;

  const BackgroundPopup({super.key, required this.shortCard});

  @override
  // ignore: library_private_types_in_public_api
  _BackgroundPopupState createState() => _BackgroundPopupState();
}

class _BackgroundPopupState extends State<BackgroundPopup> {
  bool _addBackground = false;
  String _dropdownValue = 'full';
  String _selectedColor = 'RED';

  final List<String> _colors = ['RED', 'GREEN', 'BLUE', 'YELLOW', 'ORANGE','PURPLE','SKY', 'LIME', 'PINK', 'BLACK']; // Utilisez des noms en majuscules

  @override
  void initState() {
    super.initState();
    if (widget.shortCard.cover != null && widget.shortCard.cover!.color != null && widget.shortCard.cover!.color != 'null') {
      _addBackground = true;
      _dropdownValue = widget.shortCard.cover!.size;
      _selectedColor = widget.shortCard.cover!.color!.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Background Settings'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _addBackground,
                  onChanged: (value) {
                    setState(() {
                      _addBackground = value ?? false;
                      if (!_addBackground) {
                        _dropdownValue = 'full';
                      } else {
                        if (widget.shortCard.cover != null) {
                          _dropdownValue = widget.shortCard.cover!.size;
                        }
                      }
                    });
                  },
                ),
                const Text('Add background'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Type:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            DropdownButton<String>(
              value: _dropdownValue,
              onChanged: _addBackground
                  ? (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue ?? 'full';
                      });
                    }
                  : null,
              items: <String>['full', 'normal']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: _addBackground ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Color:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            DropdownButton<String>(
              value: _selectedColor,
              onChanged: _addBackground
                  ? (String? newValue) {
                      setState(() {
                        _selectedColor = newValue ?? '';
                      });
                    }
                  : null,
              items: _colors
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: _addBackground ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if(_addBackground) {
              widget.shortCard.cover = Cover(
                color: _selectedColor.toLowerCase(),
                size: _dropdownValue, 
              );
              cardService.updateCover(widget.shortCard.id, _selectedColor.toLowerCase(), _dropdownValue);
            } else {
              widget.shortCard.cover = null;
              cardService.removeCover(widget.shortCard.id);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}