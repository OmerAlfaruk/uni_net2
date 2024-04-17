import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/post/comment/replay/presentation/widgets/edit_replay_main_widget.dart';
import 'package:uni_link/features/post/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/post/comment/replay/presentation/manager/replay/replay_cubit.dart';


import 'package:uni_link/injection_container.dart' as di;

class EditReplayPage extends StatelessWidget {
  final ReplayEntity replay;

  const EditReplayPage({Key? key, required this.replay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReplayCubit>(
      create: (context) => di.sl<ReplayCubit>(),
      child: EditReplayMainWidget(replay: replay),
    );
  }
}
