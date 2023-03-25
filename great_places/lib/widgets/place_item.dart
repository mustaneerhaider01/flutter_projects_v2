import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/place_detail_screen.dart';

class PlaceItem extends StatelessWidget {
  final String id;
  final String title;
  final File image;
  final String address;

  const PlaceItem({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: FileImage(image),
        radius: 25,
      ),
      title: Text(title),
      subtitle: Text(address),
      onTap: () {
        Navigator.of(context).pushNamed(
          PlaceDetailScreen.routeName,
          arguments: id,
        );
      },
    );
  }
}
