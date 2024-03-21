import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/stats_bloc/stats_bloc.dart';
import 'package:todo/data/storage_repository.dart';
import 'package:todo/l10n/l10n.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StatsBloc(storageRepository: context.read<StorageRepository>())
            ..add(const StatsSubscriprionRequsted()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<StatsBloc>().state;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statsAppBarTitle),
      ),
      body: Column(
        children: [
          ListTile(
            key: const Key('statsView_completed'),
            leading: const Icon(Icons.check_rounded),
            title: Text(l10n.statsCompletedTodoCountLabel),
            trailing: Text(
              '${state.completedTodos}',
              style: textTheme.headlineSmall,
            ),
          ),
          ListTile(
            key: const Key('statsView_active'),
            leading: const Icon(Icons.radio_button_unchecked_rounded),
            title: Text(l10n.statsActiveTodoCountLabel),
            trailing: Text(
              '${state.activeTodos}',
              style: textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
