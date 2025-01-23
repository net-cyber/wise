import 'package:flutter/material.dart';

class FilterChipButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback? onSelected;

  const FilterChipButton({
    super.key,
    this.isSelected = false,
    required this.label,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      color: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      backgroundColor: isSelected ? Theme.of(context).colorScheme.surface : Colors.transparent,
      selectedColor: Colors.transparent,
      shape: isSelected 
        ? const StadiumBorder()
        : StadiumBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
      onSelected: (_) => onSelected?.call(),
    );
  }
}