import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Icon _icon;
  final void Function() _onPressed;

  RoundButton({required Icon icon, required void Function() onPressed})
      : _icon = icon,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.all(0.0),
      icon: _icon,
      onPressed: _onPressed,
    );
  }
}
