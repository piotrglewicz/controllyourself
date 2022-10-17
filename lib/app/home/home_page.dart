import 'package:controllyourself/app/add/add_page.dart';
import 'package:controllyourself/app/details/details_page.dart';
import 'package:controllyourself/app/home/cubit/home_cubit.dart';
import 'package:controllyourself/app/itemModel/item_model.dart';
import 'package:controllyourself/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
      body: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ItemRepository())..start(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.errorMsg.isNotEmpty) {
            return const Center(
              child: Text('Coś poszło nie tak'),
            );
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = state.documents;
          return ListView(
            children: [
              for (final document in documents) ...[
                Dismissible(
                  background: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(100),
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ),
                  key: ValueKey(document),
                  onDismissed: (direction) {
                    context.read<HomeCubit>().remove(documentID: document.id);
                  },
                  child: _ListViewItem(
                    itemModel: document,
                  ),
                )
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    required this.itemModel,
    super.key,
  });

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              id: itemModel.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Center(
          child: Container(
            width: 329,
            height: 188,
            decoration: const BoxDecoration(
              color: Color(0xFF4B7890),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  width: 309,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B1313),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(itemModel.name),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 14, 0, 13),
                      width: 226,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Text('Test'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(14, 3, 17, 8),
                      width: 62,
                      height: 62,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9CCA68),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text('18'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
