import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit.dart';
import 'package:notes_app/cubits/note_cubit/note_state.dart';
import 'package:notes_app/widgets/note_item_widget.dart';

class NotesListViewWidgwt extends StatelessWidget {
  const NotesListViewWidgwt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<NoteCubit, NotesStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListView.builder(
              itemCount: state is NoteSuccess
                  ? BlocProvider.of<NoteCubit>(context).notesList.length
                  : 0,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return NoteItemWidget(
                  node: BlocProvider.of<NoteCubit>(context).notesList[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
