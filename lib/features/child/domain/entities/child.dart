// lib/features/child/domain/entities/child.dart
import 'package:equatable/equatable.dart';

class Child extends Equatable {
  final String id;
  final String name;
  final int age;
  final double weight;
  final double height;

  Child({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
  });

  @override
  List<Object?> get props => [id, name, age, weight, height];
}
