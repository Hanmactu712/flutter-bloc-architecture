import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? value;
  final IconData? prefixIcon;
  final bool? alignLabelWithHint;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool disabled;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final String? errorText;
  const AppTextField({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
    this.prefixIcon,
    this.alignLabelWithHint,
    this.obscureText = false,
    this.disabled = false,
    this.inputFormatters,
    this.controller,
    this.maxLines = 1,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: controller != null ? null : value,
      controller: controller,
      enabled: !disabled,
      obscureText: obscureText,
      maxLines: maxLines,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        label: label.isNotEmpty ? Text(label, style: TextStyle(color: Theme.of(context).colorScheme.outline)) : null,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Theme.of(context).colorScheme.outlineVariant) : null,
        alignLabelWithHint: alignLabelWithHint ?? false,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
        errorText: errorText,
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.error)),
        errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.error)),
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
    );
  }
}
