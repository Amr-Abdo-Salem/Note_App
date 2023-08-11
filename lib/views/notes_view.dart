import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit.dart';
import 'package:notes_app/cubits/note_cubit/note_state.dart';
import 'package:notes_app/widgets/add_note_widget.dart';
import 'package:notes_app/widgets/appbar_widget.dart';
import 'package:notes_app/widgets/notes_listview_widget.dart';

class NodesView extends StatefulWidget {
  const NodesView({super.key});

  @override
  State<NodesView> createState() => _NodesViewState();
}

class _NodesViewState extends State<NodesView> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            AppBarWidget(
              appBarTitle: 'Notes',
              iconData: Icons.search,
              onPress: () {},
            ),
            BlocConsumer<NoteCubit, NotesStates>(
              listener: (context, state) {
                if (state is AddNoteSuccess) {
                  BlocProvider.of<NoteCubit>(context).fetchAllNotes();
                }
              },
              builder: (context, state) {
                return const NotesListViewWidgwt();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              context: context,
              builder: (context) {
                return const AddNoteBottomSheetWidget();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
