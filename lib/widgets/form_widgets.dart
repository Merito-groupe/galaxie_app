import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
    required this.labelText,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdownField({
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}

class CustomMultiSelectField extends StatelessWidget {
  final String labelText;
  final List<String> availableItems;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onChanged;

  CustomMultiSelectField({
    required this.labelText,
    required this.availableItems,
    required this.selectedItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      child: Column(
        children: availableItems.map((item) {
          return CheckboxListTile(
            title: Text(item),
            value: selectedItems.contains(item),
            onChanged: (bool? value) {
              if (value == true) {
                selectedItems.add(item);
              } else {
                selectedItems.remove(item);
              }
              onChanged(selectedItems);
            },
          );
        }).toList(),
      ),
    );
  }
}

class CustomTimePickerField extends StatelessWidget {
  final String labelText;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  CustomTimePickerField({
    required this.labelText,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(labelText),
      trailing: Text('${selectedTime.format(context)}'),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        if (picked != null) {
          onTimeSelected(picked);
        }
      },
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  CustomPasswordField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
