import 'package:flutter/material.dart';

class InputDataWidget extends StatelessWidget {
  const InputDataWidget({
    required this.inputDataController,
    required this.namaData,
    required this.hintText,
    required this.maxLength,
    super.key,
  });

  final TextEditingController inputDataController;
  final String namaData;
  final String hintText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            namaData,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: TextField(
            controller: inputDataController,
            maxLength: maxLength,
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
