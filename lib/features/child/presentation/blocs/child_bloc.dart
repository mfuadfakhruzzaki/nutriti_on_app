// lib/features/child/presentation/blocs/child_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'child_event.dart';
import 'child_state.dart';
import '../../domain/usecases/get_children.dart';
import '../../domain/usecases/add_child.dart';
import '../../domain/usecases/update_child.dart';
import '../../domain/usecases/delete_child.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final GetChildrenUseCase getChildrenUseCase;
  final AddChildUseCase addChildUseCase;
  final UpdateChildUseCase updateChildUseCase;
  final DeleteChildUseCase deleteChildUseCase;

  ChildBloc({
    required this.getChildrenUseCase,
    required this.addChildUseCase,
    required this.updateChildUseCase,
    required this.deleteChildUseCase,
  }) : super(ChildInitial()) {
    on<LoadChildrenEvent>(_onLoadChildren);
    on<AddChildEvent>(_onAddChild);
    on<UpdateChildEvent>(_onUpdateChild);
    on<DeleteChildEvent>(_onDeleteChild);
  }

  Future<void> _onLoadChildren(
      LoadChildrenEvent event, Emitter<ChildState> emit) async {
    emit(ChildLoading());
    final failureOrChildren = await getChildrenUseCase(NoParams());

    failureOrChildren.fold(
      (failure) {
        emit(ChildOperationFailure(_mapFailureToMessage(failure)));
      },
      (children) {
        emit(ChildLoaded(children));
      },
    );
  }

  Future<void> _onAddChild(
      AddChildEvent event, Emitter<ChildState> emit) async {
    emit(ChildLoading());
    final failureOrChild =
        await addChildUseCase(AddChildParams(child: event.child));

    failureOrChild.fold(
      (failure) {
        emit(ChildOperationFailure(_mapFailureToMessage(failure)));
      },
      (child) {
        // Optionally reload children after adding
        add(LoadChildrenEvent());
        emit(ChildOperationSuccess());
      },
    );
  }

  Future<void> _onUpdateChild(
      UpdateChildEvent event, Emitter<ChildState> emit) async {
    emit(ChildLoading());
    final failureOrChild =
        await updateChildUseCase(UpdateChildParams(child: event.child));

    failureOrChild.fold(
      (failure) {
        emit(ChildOperationFailure(_mapFailureToMessage(failure)));
      },
      (child) {
        // Optionally reload children after updating
        add(LoadChildrenEvent());
        emit(ChildOperationSuccess());
      },
    );
  }

  Future<void> _onDeleteChild(
      DeleteChildEvent event, Emitter<ChildState> emit) async {
    emit(ChildLoading());
    final failureOrVoid =
        await deleteChildUseCase(DeleteChildParams(id: event.id));

    failureOrVoid.fold(
      (failure) {
        emit(ChildOperationFailure(_mapFailureToMessage(failure)));
      },
      (_) {
        // Optionally reload children after deleting
        add(LoadChildrenEvent());
        emit(ChildOperationSuccess());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Terjadi kesalahan server. Silakan coba lagi.';
    } else if (failure is ConnectionFailure) {
      return 'Tidak ada koneksi internet. Silakan periksa jaringan Anda.';
    } else {
      return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}
