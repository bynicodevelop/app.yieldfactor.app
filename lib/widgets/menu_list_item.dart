import 'package:flutter/material.dart';

class MenuListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget view;

  const MenuListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.view,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      subtitle: Text(subtitle),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => view,
        ),
      ),
    );
  }
}
