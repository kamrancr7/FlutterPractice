import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String address;
  final bool isFavourite;
  final String userId;
  final String email;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.address,
      @required this.userId,
      @required this.email,
      this.isFavourite = false});
}
