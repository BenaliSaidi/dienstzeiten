import 'package:dienstzeiten/views/calculators.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

late ObjectBox objectbox;
Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(const MaterialApp(home: Calculator()));
}
