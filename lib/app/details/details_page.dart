import 'package:controllyourself/app/add/add_page.dart';
import 'package:controllyourself/app/home/cubit/home_cubit.dart';
import 'package:controllyourself/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('ControllYourself'),
        ),
        backgroundColor: const Color(0xFF80CEFF),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              width: 286,
              height: 48,
              margin: const EdgeInsets.fromLTRB(52, 83, 52, 0),
              decoration: const BoxDecoration(
                color: Color(0xFF4B7890),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    width: 266,
                    height: 33,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9CCA68),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
