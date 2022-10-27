import 'package:controllyourself/app/add/cubit/add_cubit.dart';
import 'package:controllyourself/app/itemModel/item_model.dart';
import 'package:controllyourself/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    super.key,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

const List<String> difficultyLevel = <String>[
  'Łatwy',
  'Średni',
  'Trudny',
];

class _AddPageState extends State<AddPage> {
  String? name;
  String? opis;
  DateTime? releaseDate;
  String? level;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ItemRepository()),
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
                                  name!,
                                  opis!,
                                  releaseDate!,
                                  level!,
                                );
                          },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: _AddPageBody(
                onNameChange: (newValue) {
                  setState(
                    () {
                      name = newValue;
                    },
                  );
                },
                onOpisChange: (newValue) {
                  setState(
                    () {
                      opis = newValue;
                    },
                  );
                },
                onDateChange: (newValue) {
                  setState(
                    () {
                      releaseDate = newValue;
                    },
                  );
                },
                selectedDateFormat: releaseDate == null
                    ? null
                    : DateFormat.yMMMMEEEEd().format(releaseDate!),
                selectedLevel: (newValue) {
                  setState(() {
                    level = newValue;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  _AddPageBody({
    required this.onNameChange,
    required this.onOpisChange,
    required this.onDateChange,
    required this.selectedDateFormat,
    required this.selectedLevel,
    super.key,
  });
  final Function(String) onNameChange;
  final Function(String) onOpisChange;
  final Function(DateTime?) onDateChange;
  final String? selectedDateFormat;
  var selectedLevel;

  String dropDownValue = 'Łatwy';

  var items = [
    'Łatwy',
    'Średni',
    'Trudny',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
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
                    child: Center(
                      child: TextField(
                        onChanged: onNameChange,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Zadanie',
                        ),
                      ),
                    ),
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
                    child: Center(
                      child: TextField(
                        onChanged: onOpisChange,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'opis',
                        ),
                      ),
                    ),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(
                            (0xFF9CCA68),
                          ),
                          onPrimary: Colors.black),
                      onPressed: (() async {
                        final pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );
                        onDateChange(pickDate);
                      }),
                      child: Text(selectedDateFormat ?? 'Wybierz date'),
                    ),
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
                    child: Center(
                        child: DropdownButton(
                            value: dropDownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: selectedLevel)),
                  ),
                ],
              )),
        ),
      )
    ]);
  }
}
