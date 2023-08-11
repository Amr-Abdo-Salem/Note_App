abstract class NotesStates {}

class NoteInit extends NotesStates {}

class AddNoteLoading extends NotesStates {}

class AddNoteSuccess extends NotesStates {}

class AddNoteFailure extends NotesStates {
  final String erroraddMessage;

  AddNoteFailure(this.erroraddMessage);
}

class NoteLoading extends NotesStates {}

class NoteSuccess extends NotesStates {}

class NoteFailure extends NotesStates {
  final String errorMessage;

  NoteFailure(this.errorMessage);
}
