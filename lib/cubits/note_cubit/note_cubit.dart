import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/controller/constans.dart';
import 'package:notes_app/cubits/note_cubit/note_state.dart';
import 'package:notes_app/models/note_model.dart';

class NoteCubit extends Cubit<NotesStates> {
  NoteCubit() : super(NoteInit());
  double radiusCircle = 50;
  bool isChosed = true;
  List<NoteModel> notesList = [];
  List<Color> colorsNote = [
    const Color(0xff66C0AF),
    const Color(0xffAC3931),
    const Color(0xffE5D352),
    const Color(0xffD9E76C),
    const Color(0xff537D8D),
    const Color(0xff482C3D),
  ];
  Color color = const Color(0xff66C0AF);
  addNote(NoteModel noteModel) async {
    noteModel.color = color.value;
    emit(AddNoteLoading());
    try {
      var box = Hive.box<NoteModel>(kNoteBox);
      await box.add(noteModel);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(e.toString()));
    }
  }

//__________________________get Notes___________________________________________
  fetchAllNotes() async {
    var box = Hive.box<NoteModel>(kNoteBox);
    notesList = box.values.toList();
    emit(NoteSuccess());
  }
}
