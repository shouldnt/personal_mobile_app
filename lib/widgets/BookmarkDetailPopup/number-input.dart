import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  final TextEditingController controller;
  const NumberInput({Key? key, required this.controller}) : super(key: key);

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  bool editing = false;
  final FocusNode focusNode = FocusNode();

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
              if(editing) return;
              setState(() {
                editing = true;
              });
            },
            child: Text(
              widget.controller.text, 
              style: TextStyle(
                color: !editing ? Colors.white : Colors.transparent
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        if(editing) Positioned(
          left: 0,
          right: 0,
          top: -15,
          child: TextField(
            focusNode: focusNode,
            controller: widget.controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
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
            textAlign: TextAlign.end,
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