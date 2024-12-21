// lib/features/child/presentation/blocs/child_event.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/child.dart';

abstract class ChildEvent extends Equatable {
  const ChildEvent();

  @override
  List<Object?> get props => [];
}

class LoadChildrenEvent extends ChildEvent {}

class AddChildEvent extends ChildEvent {
  final Child child;

  const AddChildEvent(this.child);

  @override
  List<Object?> get props => [child];
}

class UpdateChildEvent extends ChildEvent {
  final Child child;

  const UpdateChildEvent(this.child);

  @override
  List<Object?> get props => [child];
}

class DeleteChildEvent extends ChildEvent {
  final String id;

  const DeleteChildEvent(this.id);

  @override
  List<Object?> get props => [id];
}
