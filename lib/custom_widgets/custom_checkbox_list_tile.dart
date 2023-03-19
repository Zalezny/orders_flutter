import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomCheckboxListTile extends StatefulWidget {
  bool? initValue = false;
  Text? text;
  Function(bool?) onChanged;

  CustomCheckboxListTile(
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
          Checkbox(
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
