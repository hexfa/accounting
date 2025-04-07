import 'package:flutter/material.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(child: Text('منوی اصلی')),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('تغییر زبان'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('تغییر تم'),
          onTap: () {},
        ),
      ],
    );
  }
}
