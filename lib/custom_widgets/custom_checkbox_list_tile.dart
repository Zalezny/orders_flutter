import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  final bool? initValue;
  final Text? text;
  final Function(bool?) onChanged;

  const CustomCheckboxListTile(
      {super.key, this.initValue, this.text, required this.onChanged});

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  bool _isChecked = false;

  @override
  void initState() {
    _isChecked = widget.initValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Platform.isIOS
            ? CupertinoCheckbox(
                activeColor: Theme.of(context).colorScheme.primary,
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue ?? false;
                    widget.onChanged(newValue);
                  });
                })
            : Checkbox(
                activeColor: Theme.of(context).colorScheme.primary,
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue ?? false;
                    widget.onChanged(newValue);
                  });
                }),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => setState(() {
            _isChecked = !_isChecked;
          }),
          child: widget.text ?? const SizedBox(),
        )
      ],
    );
  }
}
