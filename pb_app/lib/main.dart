import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pb_app/config.dart';
import 'package:pb_app/dto.dart';
import 'package:pb_app/modals.dart';
import 'package:pb_app/submission_form.dart';
import 'package:pb_app/workflows.dart';

void main() async {
  if (Config.skipLogin) {
    final userAuth = await Workflows.authenticate();
    debugPrint(userAuth.user?.id);
  }

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
      builder: (context, child) => ToastProvider(child: child!),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final results = Workflows.getAndroidSubmissions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Submissions'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (Config.skipLogin) {
            SubmissionFormScreen.show(context);
          } else {
            Workflows.createAndroidSubmission(context);
          }
        },
      ),
      body: FutureBuilder(
        future: results,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // TODO: make ticket about leaving @collectionId, @collectionName in payload
          print(snapshot.data!.items.firstOrNull?.data);
          // OR TODO: make ticket about typing this List<RecordModel>
          print(snapshot.data!.items.firstOrNull?.expand);

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
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'submitted by ',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(width: 5),
                            Image.network(
                              submission.createdBy.avatarUrl,
                              height: 25,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              submission.createdBy.name,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
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
