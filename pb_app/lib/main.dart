import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pb_app/dto.dart';
import 'package:pb_app/utils.dart';
import 'package:pb_app/workflows.dart';
import 'package:pocketbase/pocketbase.dart';

final workflows = AppWorkflows();

void main() async {
  final userAuth = await workflows.authenticate();
  debugPrint(userAuth.user?.id);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final results = workflows.getAndroidSubmissions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: results,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          print(snapshot.data!.items.firstOrNull?.data);

          final androidSubmissions = snapshot.data!.items
              .map((it) => AndroidSubmissionDto.fromRecord(it));

          return ListView(
            children: [
              for (final submission in androidSubmissions)
                Row(
                  children: [
                    Checkbox(value: submission.approved, onChanged: (_) {}),
                    Text(submission.name),
                    Spacer(),
                    Image.network(
                      submission.lockScreenUrl,
                      height: 100,
                    ),
                    Image.network(
                      submission.homeScreenUrl,
                      height: 100,
                    ),
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
