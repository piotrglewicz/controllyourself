import 'package:bloc/bloc.dart';
import 'package:controllyourself/app/itemModel/item_model.dart';
import 'package:controllyourself/repositories/item_repository.dart';
part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._itemRepository) : super(DetailsState(itemModel: null));

  final ItemRepository _itemRepository;

  Future<void> getItemId(String id) async {
    final itemModel = await _itemRepository.get(id: id);
    emit(DetailsState(itemModel: itemModel));
  }
}
