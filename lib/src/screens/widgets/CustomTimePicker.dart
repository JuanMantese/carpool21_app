import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final Function(String) onTimeChanged;
  final TimeOfDay? initialTime;
  final EdgeInsetsGeometry padding;

  CustomTimePicker({
    super.key,
    required this.labelText,
    this.icon = Icons.access_time,
    required this.onTimeChanged,
    this.initialTime,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.onTimeChanged(picked.format(context));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Icon(widget.icon),
        ),
        child: Text(
          selectedTime != null ? selectedTime!.format(context) : '',
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}