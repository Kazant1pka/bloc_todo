import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/bootstrap.dart';
import 'package:todo/data/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = Storage(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(storageData: todosApi);
}
