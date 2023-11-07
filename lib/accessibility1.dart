import 'package:flutter/material.dart';

class FieldTrackDataModel {
  late String identifier; // Add necessary properties
  late String captureType; // Add necessary properties
  String result = ''; // Initialize the result property
}

class YourPage extends StatelessWidget {
  final List<FieldTrackDataModel> fieldTrackDataModels = []; // Initialize with data

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            for (FieldTrackDataModel field in fieldTrackDataModels)
              TextFieldWithTracking(field: field),
          ],
        ),
      ),
    );
  }
}

class TextFieldWithTracking extends StatefulWidget {
  final FieldTrackDataModel field;

  const TextFieldWithTracking({
    required this.field,
  });

  @override
  _TextFieldWithTrackingState createState() => _TextFieldWithTrackingState();
}

class _TextFieldWithTrackingState extends State<TextFieldWithTracking> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.field.result);

    _controller.addListener(() {
      // Listen to changes in the text field
      widget.field.result = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onEditingComplete: () {
        // Handle editing complete event
        String newValue = _controller.text;
        if (newValue.isEmpty) {
          widget.field.result = _controller.text;
        } else {
          widget.field.result = newValue;
        }

        // Update tracked field details
        setFieldTrackData(widget.field);
      },
    );
  }

  void setFieldTrackData(FieldTrackDataModel field) {
    // Implement your logic to send the updated tracked field data
  }
}
//
// void main() {
//   runApp(YourPage());
// }
