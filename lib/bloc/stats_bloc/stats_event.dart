part of 'stats_bloc.dart';

sealed class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object> get props => [];
}

final class StatsSubscriprionRequsted extends StatsEvent {
  const StatsSubscriprionRequsted();
}
