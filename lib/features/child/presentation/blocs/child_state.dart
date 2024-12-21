// lib/features/child/presentation/blocs/child_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/child.dart';

abstract class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object?> get props => [];
}

class ChildInitial extends ChildState {}

class ChildLoading extends ChildState {}

class ChildLoaded extends ChildState {
  final List<Child> children;

  const ChildLoaded(this.children);

  @override
  List<Object?> get props => [children];
}

class ChildOperationSuccess extends ChildState {}

class ChildOperationFailure extends ChildState {
  final String message;

  const ChildOperationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
