import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> options;
  final IconData? prefixIcon;
  final bool? alignLabelWithHint;
  final Function(T?)? onChanged;
  final Function(T) displayName;
  const AppDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.options,
    this.onChanged,
    this.prefixIcon,
    this.alignLabelWithHint,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: options
          .map(
            (e) => DropdownMenuItem<T>(value: e, child: AppText(text: displayName(e))),
          )
          .toList(),
      value: value,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      iconEnabledColor: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        label: label.isNotEmpty ? Text(label, style: TextStyle(color: Theme.of(context).colorScheme.outline)) : null,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).colorScheme.outlineVariant,
              )
            : null,
        alignLabelWithHint: alignLabelWithHint ?? false,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
    );
  }
}
