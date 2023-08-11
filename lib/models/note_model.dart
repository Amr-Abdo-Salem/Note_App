import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String titleNote;
  @HiveField(1)
  String bodyNote;
  @HiveField(2)
  final String dateNote;
  @HiveField(3)
  int color;

  NoteModel({
    required this.titleNote,
    required this.bodyNote,
    required this.dateNote,
    required this.color,
  });
}
