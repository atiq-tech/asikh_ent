import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.title});
  String title;

  Size get preferredSize {
    return const Size.fromHeight(50.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          size: 22.0,
          color: Colors.white,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.indigo,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
