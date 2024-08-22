import 'package:flutter/material.dart';

class AddKeyValueBottomSheet extends StatefulWidget {
  const AddKeyValueBottomSheet({super.key});

  @override
  _AddKeyValueBottomSheetState createState() => _AddKeyValueBottomSheetState();
}

class _AddKeyValueBottomSheetState extends State<AddKeyValueBottomSheet> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add New Key-Value Pair',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal[700],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _keyController,
            decoration: InputDecoration(
              labelText: 'Key',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.teal[50],
              prefixIcon: const Icon(Icons.vpn_key, color: Colors.teal),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(
              labelText: 'Value',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.teal[50],
              prefixIcon: const Icon(Icons.label, color: Colors.teal),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.teal,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final key = _keyController.text;
                  final value = _valueController.text;

                  if (key.isNotEmpty && value.isNotEmpty) {
                    Navigator.of(context).pop({'key': key, 'value': value});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

