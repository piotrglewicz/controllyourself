import 'package:controllyourself/app/add/cubit/add_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    super.key,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? name;
  String? opis;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state.save) {
            Navigator.of(context).pop();
          }
          if (state.erorrMsg.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.erorrMsg),
              ),
            );
          }
        },
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text('ControllYourself'),
                ),
                backgroundColor: const Color(0xFF80CEFF),
                actions: [
                  IconButton(
                    onPressed: name == null
                        ? null
                        : () {
                            context.read<AddCubit>().add(
                                  name,
                                  opis,
                                );
                          },
                    icon: const Icon(Icons.check),
                  ),
                ],
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
                              margin:
                                  const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9CCA68),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintText: 'Zadanie',
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      name = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 178.16,
                              height: 36.53,
                              margin:
                                  const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9CCA68),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintText: 'Opis',
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      opis = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 178.16,
                              height: 36.53,
                              margin:
                                  const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9CCA68),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child:
                                  const Center(child: Text('Data ukończenia')),
                            ),
                            Container(
                              width: 178.16,
                              height: 36.53,
                              margin:
                                  const EdgeInsets.fromLTRB(25, 32.25, 25, 0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9CCA68),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Center(
                                  child: Text('Trudność(opcjonalne)')),
                            ),
                          ],
                        )),
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
