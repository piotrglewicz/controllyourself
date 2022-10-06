import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
          documents: [],
          errorMsg: '',
          isLoading: false,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      HomeState(
        documents: [],
        errorMsg: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((data) {
      emit(
        HomeState(
          documents: data.docs,
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

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
