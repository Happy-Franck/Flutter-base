import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String image;
  final int price;
  final String description;
  final bool like;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.like,
  });
}
