import 'package:controllyourself/app/details/cubit/details_cubit.dart';
import 'package:controllyourself/app/itemModel/item_model.dart';
import 'package:controllyourself/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('ControllYourself'),
        ),
        backgroundColor: const Color(0xFF80CEFF),
      ),
      body: BlocProvider(
        create: (context) => DetailsCubit(ItemRepository())..getItemId(id),
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final document = state.itemModel;
            if (document == null) {
              return const CircularProgressIndicator();
            }
            return ListView(
              children: [
                Center(
                  child: _ListViewDetails(
                    itemModel: document,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListViewDetails extends StatelessWidget {
  const _ListViewDetails({
    required this.itemModel,
    super.key,
  });

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                child: Center(
                  child: Text(itemModel.name),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              width: 286,
              height: 202,
              margin: const EdgeInsets.fromLTRB(51, 42, 53, 0),
              decoration: const BoxDecoration(
                color: Color(0xFF4B7890),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      width: 266,
                      height: 187,
                      margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(itemModel.opis),
                      )),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: 48,
              width: 286,
              margin: const EdgeInsets.fromLTRB(51, 42, 53, 0),
              decoration: const BoxDecoration(
                color: Color(0xFF4B7890),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 33,
                    width: 266,
                    margin: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9CCA68),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        itemModel.relaseDateFormatted(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
