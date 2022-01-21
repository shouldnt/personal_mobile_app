import 'package:flutter/material.dart';

class NameInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isCreate;
  const NameInput({Key? key, required this.controller, this.isCreate = false}) : super(key: key);

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  bool editing = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if(!focusNode.hasFocus) {
        setState(() {
          editing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              setState(() {
                editing = true;
              });
            },
            child: Text(
              widget.controller.text == '' && widget.isCreate 
              ? 'Tap to change title...'
              : widget.controller.text,
              style: TextStyle(color: editing ? Colors.transparent : Colors.white),
            ),
          ),
        ),
        if(editing) Positioned(
          left: 0,
          right: 0,
          top: -15,
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            focusNode: focusNode,
            controller: widget.controller,
            autofocus: true,
            onEditingComplete: () {
              setState(() {
                editing = false;
              });
            },
            onSubmitted: (value) {
              setState(() {
                editing = false;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 00),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}