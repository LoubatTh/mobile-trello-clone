import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Dev-600',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70)),
      backgroundColor: Colors.white10,
    );
  }
}
