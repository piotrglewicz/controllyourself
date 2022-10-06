import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controllyourself/app/add/add_page.dart';
import 'package:controllyourself/app/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (context) {
        return BlocProvider(
          create: (context) => HomeCubit()..start(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.errorMsg.isNotEmpty) {
                return Center(
                  child: Text(
                    'Nieoczekiwany błąd: ${state.errorMsg}',
                  ),
                );
              }
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = state.documents;
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
            },
          ),
        );
      }),
    );
  }
}

class TaskWidget extends StatefulWidget {
  const TaskWidget(
    this.name, {
    super.key,
  });

  final String name;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
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
                    child: Center(child: Text(widget.name)),
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
