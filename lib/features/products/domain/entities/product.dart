import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String image;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, description, price, image];
}
