import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/controller/constans.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/add_note_widget.dart';
import 'package:notes_app/widgets/appbar_widget.dart';
import 'package:notes_app/widgets/textfield_widget.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  String? title, body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          bottom: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            AppBarWidget(
              appBarTitle: 'Edit Note',
              iconData: Icons.check,
              onPress: () {
                widget.noteModel.titleNote =
                    title ?? widget.noteModel.titleNote;
                widget.noteModel.bodyNote = body ?? widget.noteModel.bodyNote;
                widget.noteModel.save();
                BlocProvider.of<NoteCubit>(context).fetchAllNotes();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edited Note Successed')));
                Navigator.of(context).pop();
                // Future.delayed(const Duration(seconds: 1), () {
                //   Navigator.of(context).pop();
                // });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
              ),
              child: TextFormFieldWidget(
                hintText: widget.noteModel.titleNote,
                maxLines: 1,
                onSaved: (value) {
                  title = value;
                },
                // ignore: non_constant_identifier_names
                onChange: (Value) {
                  title = Value;
                },
              ),
            ),
            TextFormFieldWidget(
              hintText: widget.noteModel.bodyNote,
              maxLines: 6,
              onSaved: (value) {
                body = value;
              },
              onChange: (value) {
                body = value;
              },
            ),
            ListColorsWidgit(
              noteModel: widget.noteModel,
            ),
          ],
        ),
      ),
    );
  }
}

class ListColorsWidgit extends StatefulWidget {
  const ListColorsWidgit({
    super.key,
    required this.noteModel,
  });
  final NoteModel noteModel;

  @override
  State<ListColorsWidgit> createState() => _ListColorsWidgitState();
}

class _ListColorsWidgitState extends State<ListColorsWidgit> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = kColorsNote.indexOf(Color(widget.noteModel.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: SizedBox(
          height: BlocProvider.of<NoteCubit>(context).radiusCircle * 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kColorsNote.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  currentIndex = index;
                  BlocProvider.of<NoteCubit>(context).color =
                      kColorsNote[index];
                  widget.noteModel.color = kColorsNote[index].value;
                  setState(() {});
                },
                child: CircleAvatarWidget(
                  isChosed: currentIndex == index,
                  color: kColorsNote[index],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
