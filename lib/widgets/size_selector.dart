import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const SizeSelector(
      {super.key, required this.onSizeSelected, required this.sizes});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String selectedSize = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.sizes.map((size) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(size),
            selected: selectedSize == size,
            onSelected: (bool selected) {
              setState(() {
                selectedSize = selected ? size : "";
                widget.onSizeSelected(selectedSize);
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
