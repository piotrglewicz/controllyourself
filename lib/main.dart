import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF80CEFF),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('ControllYourself'),
        ),
        backgroundColor: const Color(0xFF80CEFF),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('tasks')
              .add({'name': 'Test kategorii'});
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (context) {
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Nieoczekiwany błąd');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Poczekaj');
              }
              final documents = snapshot.data!.docs;
              return ListView(children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(document.id)
                          .delete();
                    },
                    child: TaskWidget(document['name']),
                  ),
                ]
              ]);
            });
      }),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget(
    this.name, {
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 30,
      ),
      child: Center(
        child: Container(
          width: 329,
          height: 188,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF4B7890),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 308,
                height: 100,
                margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: const BoxDecoration(
                  color: Color(0xFF8B1313),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: const Center(child: Text('Ile ty masz lat?')),
              ),
              Row(
                children: [
                  Container(
                    width: 226,
                    height: 46,
                    margin: const EdgeInsets.fromLTRB(10, 14, 0, 13),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9CCA68),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(child: Text(name)),
                  ),
                  Container(
                    width: 62,
                    height: 62,
                    margin: const EdgeInsets.fromLTRB(14, 3, 17, 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9CCA68),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Center(child: Text('17')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('ControllYourself'),
        ),
        backgroundColor: const Color(0xFF80CEFF),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 90,
          ),
          child: Center(
            child: Container(
                width: 228,
                height: 300,
                decoration: const BoxDecoration(
                  color: Color(0xFF4B7890),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 178.16,
                      height: 36.53,
                      margin: const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(child: Text('Zadanie')),
                    ),
                    Container(
                      width: 178.16,
                      height: 36.53,
                      margin: const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(child: Text('Opis')),
                    ),
                    Container(
                      width: 178.16,
                      height: 36.53,
                      margin: const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(child: Text('Data ukończenia')),
                    ),
                    Container(
                      width: 178.16,
                      height: 36.53,
                      margin: const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(child: Text('Trudność(opcjonalne')),
                    ),
                  ],
                )),
          ),
        )
      ]),
    );
  }
}
