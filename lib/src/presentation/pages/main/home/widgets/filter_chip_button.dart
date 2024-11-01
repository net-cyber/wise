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
      selected: isSelected,
      showCheckmark: false,
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      backgroundColor: isSelected ? Colors.grey[200] : Colors.transparent,
      selectedColor: Colors.transparent,
      shape: isSelected 
        ? const StadiumBorder()
        : StadiumBorder(
            side: BorderSide(color: Colors.grey[300]!),
          ),
      onSelected: (_) => onSelected?.call(),
    );
  }
}