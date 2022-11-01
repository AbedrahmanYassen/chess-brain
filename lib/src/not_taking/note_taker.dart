import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoteTakingWidget extends StatefulWidget {
  late double dx;
  late double dy;
  late Widget child;

  bool changePosition = false;
  NoteTakingWidget(
      {super.key, required this.dx, required this.dy, required this.child});

  @override
  State<NoteTakingWidget> createState() => _NoteTakingWidgetState();
}

class _NoteTakingWidgetState extends State<NoteTakingWidget> {
  late Offset offset;
  bool showContentOftheNote = false;
  @override
  void initState() {
    // TODO: implement initState
    offset = Offset(widget.dx, widget.dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          if (widget.changePosition == true) {
            widget.dx = details.localPosition.dx;
            widget.dy = details.localPosition.dy;
          }
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned(
            child: IconButton(
              splashColor: Colors.blue,
              splashRadius: double.minPositive,
              onPressed: () {
                setState(() {
                  showContentOftheNote = (showContentOftheNote) ? false : true;
                });
              },
              icon: const Icon(
                Icons.message,
                color: Color.fromARGB(255, 235, 214, 24),
                size: 20,
              ),
            ),
            top: widget.dy,
            left: widget.dx,
          ),
          if (showContentOftheNote)
            Positioned(
              left: widget.dx + 30,
              top: widget.dy + 30,
              child: const NoteTakerPopup(),
            ),
        ],
      ),
    );
  }
}

class NoteTextField extends StatefulWidget {
  const NoteTextField({super.key});

  @override
  State<NoteTextField> createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 188, 170, 5),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      width: 150,
      // height: 100,
      child: TextField(
        controller: controller,
        maxLines: null,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          enabledBorder: getInputBorder(),
          focusedBorder: getInputBorder(),
        ),
      ),
    );
  }

  InputBorder getInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow),
        borderRadius: BorderRadius.all(Radius.circular(5)));
  }
}

class NoteTakerPopup extends StatelessWidget {
  const NoteTakerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 20,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 172, 156, 4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.save,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
        const NoteTextField(),
      ],
    );
  }
}
