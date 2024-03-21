import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/storage_repository.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/page/home_page.dart';
import 'package:todo/theme/theme.dart';

class App extends StatelessWidget {
  const App({required this.todosRepository, super.key});

  final StorageRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todosRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
