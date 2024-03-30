import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';

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
        return Colors.black;
      default:
        return null;
    }
  }