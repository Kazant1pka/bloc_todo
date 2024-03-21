import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/storage_repository.dart';
import 'package:todo/domain/todo.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({
    required StorageRepository storageRepository,
  })  : _storageRepository = storageRepository,
        super(const StatsState()) {
    on<StatsSubscriprionRequsted>(_onSubscriprionRequsted);
  }

  final StorageRepository _storageRepository;

  Future<void> _onSubscriprionRequsted(
    StatsSubscriprionRequsted event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    await emit.forEach<List<Todo>>(
      _storageRepository.getTodos(),
      onData: (todos) {
        return state.copyWith(
          status: StatsStatus.success,
          completedTodos: todos.where((element) => element.isCompleted).length,
          activeTodos: todos.where((element) => !element.isCompleted).length,
        );
      },
      onError: (_, __) => state.copyWith(status: StatsStatus.failure),
    );
  }
}
