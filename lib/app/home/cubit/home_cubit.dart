import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllyourself/app/itemModel/item_model.dart';
import 'package:controllyourself/repositories/item_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._itemRepository)
      : super(HomeState(
          documents: [],
          errorMsg: '',
          isLoading: false,
        ));

  final ItemRepository _itemRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      HomeState(
        documents: [],
        errorMsg: '',
        isLoading: true,
      ),
    );

    _streamSubscription = _itemRepository.getItemStrem().listen((data) {
      emit(
        HomeState(
          documents: data,
          isLoading: false,
          errorMsg: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          HomeState(
            documents: [],
            isLoading: false,
            errorMsg: error.toString(),
          ),
        );
      });
  }

  Future<void> remove({required String documentID}) async {
    await _itemRepository.delete(id: documentID);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
