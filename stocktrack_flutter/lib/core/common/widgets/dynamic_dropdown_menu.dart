import 'package:flutter/material.dart';

class DropdownInputWidget extends StatelessWidget {
  const DropdownInputWidget({
    required this.inputDataController,
    required this.label,
    required this.hintText,
    required this.maxLength,
    required this.dropdownItems,
    required this.onDropdownChanged,
    required this.dropdownValue,
    super.key,
  });

  final TextEditingController inputDataController;
  final String label;
  final String hintText;
  final int maxLength;
  final List<dynamic> dropdownItems;
  final void Function(dynamic) onDropdownChanged;
  final dynamic dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: DropdownButtonFormField(
            value: dropdownValue,
            onChanged: (dynamic value) {
              onDropdownChanged(value);

              // Update the controller if needed.
              inputDataController.text = value.toString();
            },
            items: dropdownItems
                .map<DropdownMenuItem<dynamic>>(
                  (dynamic value) => DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(value.toString()),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              hintText: hintText,
              counterStyle: const TextStyle(
                height: double.minPositive,
              ),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}
