import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/edit_note_view.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget({
    required this.node,
    super.key,
  });
  final NoteModel node;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNoteView(
                noteModel: node,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(node.color),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  node.titleNote,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                  ),
                  child: Text(
                    node.bodyNote,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xffA07433),
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    node.delete();
                    BlocProvider.of<NoteCubit>(context).fetchAllNotes();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Delete Note Success')));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 24,
                ),
                child: Text(
                  node.dateNote,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xffA07433),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
