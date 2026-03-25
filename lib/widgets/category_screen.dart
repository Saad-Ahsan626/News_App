import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelected;

  const CategoryScreen({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: Icon(
        icon,
        size: 18,
        color: isSelected ? Colors.white : const Color(0xFF000666),
      ),
      label: Text(label.toUpperCase()),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: const Color(0xFF000666),
      labelStyle: GoogleFonts.workSans(
        color: isSelected ? Colors.white : const Color(0xFF000666),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      backgroundColor: const Color(0xFFF2F3FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      side: BorderSide.none,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
