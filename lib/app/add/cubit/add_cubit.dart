import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(const AddState());

  String? name;
  String? opis;

  Future<void> add(name, opis) async {
    try {
      FirebaseFirestore.instance.collection('tasks').add(
        {
          'name': name,
          'opis': opis,
        },
      );
      emit(
        const AddState(save: true),
      );
    } catch (error) {
      emit(
        AddState(
          erorrMsg: error.toString(),
        ),
      );
    }
  }
}
