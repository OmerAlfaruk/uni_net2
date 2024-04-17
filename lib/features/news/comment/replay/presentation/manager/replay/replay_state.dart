part of 'replay_cubit.dart';

abstract class NewsReplayState extends Equatable {
  const NewsReplayState();
}

class ReplayInitial extends NewsReplayState {
  @override
  List<Object> get props => [];
}

class ReplayLoading extends NewsReplayState {
  @override
  List<Object> get props => [];
}
class ReplayLoaded extends NewsReplayState {
  final List<ReplayEntity2> replays;

  ReplayLoaded({required this.replays});

  @override
  List<Object> get props => [replays];
}
class ReplayFailure extends NewsReplayState {
  @override
  List<Object> get props => [];
}

