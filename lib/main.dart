import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sample_app/database/database_helper.dart';
import 'package:todo_sample_app/providers/tasks_provider.dart';
import 'package:todo_sample_app/screens/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: DatabaseHelper.instance.database, // 非同期処理
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          // データベースの初期化が完了したらプロバイダを提供
          return ChangeNotifierProvider(
            create: (_) => TaskProvider(database: snapshot.data!),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: TasksScreen(),
            ),
          );
        } else {
          // データベースの初期化中またはエラーが発生した場合
          return MaterialApp(
            home: Scaffold(
              body: snapshot.hasError
                  ? Text('Error: ${snapshot.error}')
                  : CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
