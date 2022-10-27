import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    required this.name,
    required this.id,
    required this.opis,
    required this.releaseDate,
    required this.level,
  });

  final String id;
  final String name;
  final String opis;
  final DateTime releaseDate;
  final String level;

  String daysLeft() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String relaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}
