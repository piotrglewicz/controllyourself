import 'package:controllyourself/app/add/add_page.dart';
import 'package:controllyourself/app/home/cubit/home_cubit.dart';
import 'package:controllyourself/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(52, 83, 52, 0),
      ),
    );
  }
}
