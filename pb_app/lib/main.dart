import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pb_app/dto.dart';
import 'package:pb_app/workflows.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final results = workflows.getAndroidSubmissions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Submissions'),
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
                // TODO: show the user name of that who created this record
                Card(
                  margin: const EdgeInsets.all(15),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          submission.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Checkbox(value: submission.approved, onChanged: (_) {}),
                            Image.network(
                              submission.lockScreenUrl,
                              height: 250,
                            ),
                            Image.network(
                              submission.homeScreenUrl,
                              height: 250,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
