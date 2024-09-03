import "package:eagle_valet_parking/generated/l10n.dart";
import "package:flutter/material.dart";

class InputNumber extends StatelessWidget {
  const InputNumber({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.bodyMedium,
      validator: (value) {
        if (value!.isEmpty) {
          return S.current.requiredField;
        } else if (value.contains(RegExp(r'^[0-9]+$'))) {
          return null;
        } else {
          return S.current.enterValidTicketNumber;
        }
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      ),
    );
  }
}
