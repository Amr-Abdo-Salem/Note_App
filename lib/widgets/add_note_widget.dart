import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/controller/constans.dart';
import 'package:notes_app/cubits/note_cubit/note_cubit.dart';
import 'package:notes_app/cubits/note_cubit/note_state.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/text_button_widget.dart';
import 'package:notes_app/widgets/textfield_widget.dart';

class AddNoteBottomSheetWidget extends StatefulWidget {
  const AddNoteBottomSheetWidget({super.key});

  @override
  State<AddNoteBottomSheetWidget> createState() =>
      _AddNoteBottomSheetWidgetState();
}

class _AddNoteBottomSheetWidgetState extends State<AddNoteBottomSheetWidget> {
  String? title, body;
  final GlobalKey<FormState> formState = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NotesStates>(
      listener: (context, state) {
        if (state is AddNoteSuccess) {
          BlocProvider.of<NoteCubit>(context).fetchAllNotes();
          Navigator.of(context).pop();
        }
        if (state is AddNoteFailure) {}
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is AddNoteLoading ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
              top: 50,
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formState,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      hintText: 'Title',
                      maxLines: 1,
                      onSaved: (value) {
                        title = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                      hintText: 'Content',
                      maxLines: 6,
                      onSaved: (value) {
                        body = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SizedBox(
                        height:
                            BlocProvider.of<NoteCubit>(context).radiusCircle *
                                2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: kColorsNote.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                currentIndex = index;
                                BlocProvider.of<NoteCubit>(context).color =
                                    kColorsNote[index];
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
                    BlocBuilder<NoteCubit, NotesStates>(
                      builder: (context, state) {
                        return TextButtonWidget(
                          isLoading: state is AddNoteLoading ? true : false,
                          textButton: 'Add',
                          onTap: () {
                            if (formState.currentState!.validate()) {
                              formState.currentState!.save();
                              BlocProvider.of<NoteCubit>(context)
                                  .addNote(NoteModel(
                                titleNote: title!,
                                bodyNote: body!,
                                dateNote: DateFormat("EEE,d/M/y,hh:mm a")
                                    .format(DateTime.now()),
                                color: const Color(0xff66C0AF).value,
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Add Note Success')));
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleAvatarWidget extends StatefulWidget {
  const CircleAvatarWidget(
      {super.key, required this.isChosed, required this.color});
  final bool isChosed;
  final Color color;
  @override
  State<CircleAvatarWidget> createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: widget.isChosed
          ? Stack(
              children: [
                CircleAvatar(
                  backgroundColor: widget.color,
                  radius: BlocProvider.of<NoteCubit>(context).radiusCircle,
                ),
                Positioned(
                  bottom: BlocProvider.of<NoteCubit>(context).radiusCircle / 2,
                  left: BlocProvider.of<NoteCubit>(context).radiusCircle / 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          : CircleAvatar(
              backgroundColor: widget.color,
              radius: BlocProvider.of<NoteCubit>(context).radiusCircle,
            ),
    );
  }
}
