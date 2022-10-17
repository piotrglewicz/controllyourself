import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controllyourself/app/itemModel/item_model.dart';

class ItemRepository {
  Stream<List<ItemModel>> getItemStrem() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .map((querrySnapshot) {
      return querrySnapshot.docs.map((document) {
        return ItemModel(
          id: document.id,
          name: document['name'],
          opis: document['opis'],
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  Future<ItemModel> get({required String id}) async {
    final document =
        await FirebaseFirestore.instance.collection('tasks').doc(id).get();

    return ItemModel(
      id: document.id,
      name: document['name'],
      opis: document['opis'],
    );
  }
}
