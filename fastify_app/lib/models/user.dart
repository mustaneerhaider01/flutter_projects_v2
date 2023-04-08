import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String? name;
  final String email;
  final String? image;

  AppUser({
    required this.uid,
    required this.email,
    this.name,
    this.image,
  });
}
