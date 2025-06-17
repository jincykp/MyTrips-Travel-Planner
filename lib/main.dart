import 'package:flutter/material.dart';
import 'package:my_trips/SCREENS/splash.dart';
import 'package:my_trips/database/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:my_trips/database/model/trip_model.dart';

import 'database/model/memories_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TripModelAdapter());
  Hive.registerAdapter(MemoryModelAdapter());
  await Hive.initFlutter('hive_db');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScreenSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
