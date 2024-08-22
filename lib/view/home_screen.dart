import 'package:flutter/material.dart';
import '../data_base/data_base_helper.dart';
import 'add_key_value_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> keyValuePairs = [];

  @override
  void initState() {
    super.initState();
    fetchKeyValuePairs();
  }

  Future<void> fetchKeyValuePairs() async {
    final data = await DatabaseHelper.instance.getKeyValuePairs();
    setState(() {
      keyValuePairs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key-Values', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: keyValuePairs.isEmpty
          ? _buildEmptyState()
          : _buildKeyValueList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, String>>(
            context: context,
            builder: (context) => AddKeyValueBottomSheet(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            backgroundColor: Colors.teal[50],
          );

          if (result != null) {
            await DatabaseHelper.instance.insertKeyValue(result);
            fetchKeyValuePairs();
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 100, color: Colors.teal[200]),
          const SizedBox(height: 20),
          const Text(
            'No key-value added yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyValueList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: keyValuePairs.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.teal[50],
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              'Key: ${keyValuePairs[index]['key']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Value: ${keyValuePairs[index]['value']}',
              style: TextStyle(fontSize: 16, color: Colors.teal[900]),
            ),
          ),
        );
      },
    );
  }
}

