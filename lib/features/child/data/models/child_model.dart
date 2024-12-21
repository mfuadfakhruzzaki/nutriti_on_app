// lib/features/child/data/models/child_model.dart
import '../../domain/entities/child.dart';

class ChildModel extends Child {
  ChildModel({
    required String id,
    required String name,
    required int age,
    required double weight,
    required double height,
  }) : super(
          id: id,
          name: name,
          age: age,
          weight: weight,
          height: height,
        );

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
    };
  }
}
