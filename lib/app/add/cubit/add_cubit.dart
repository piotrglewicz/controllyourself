// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:controllyourself/repositories/item_repository.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemRepository) : super(const AddState());

  final ItemRepository _itemRepository;

  Future<void> add(
    String name,
    String opis,
    DateTime releaseDate,
  ) async {
    try {
      await _itemRepository.add(
        name,
        opis,
        releaseDate,
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
