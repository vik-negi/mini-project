import "package:flutter/material.dart";

class PopupMenuBtn extends StatelessWidget {
  const PopupMenuBtn({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(onSelected: (value) {
      print(value);
    }, itemBuilder: (context) {
      return [
        for (var i = 0; i < items.length; i++) popMenuItm(items[i], items[i]),
      ];
    });
  }

  PopupMenuItem<String> popMenuItm(name, value) {
    return PopupMenuItem(
      child: Text(name),
      value: value,
    );
  }
}
