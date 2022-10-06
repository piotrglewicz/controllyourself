part of 'home_cubit.dart';

class HomeState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  final bool isLoading;
  final String errorMsg;

  HomeState({
    required this.documents,
    required this.isLoading,
    required this.errorMsg,
  });
}
