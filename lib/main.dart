import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FruitsFormPage(),
    );
  }
}

class FruitsFormPage extends StatefulWidget {
  @override
  _FruitsFormPageState createState() => _FruitsFormPageState();
}

class _FruitsFormPageState extends State<FruitsFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _fruits = [];
  String _newFruit = '';

  void _addFruit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _fruits.add(_newFruit);
        _newFruit = ''; // フォームをクリア
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruits List Form'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Add a fruit'),
              onSaved: (value) {
                _newFruit = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a fruit';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addFruit,
            child: Text('Add Fruit'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _fruits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: ValueKey('${_fruits[index]}_$index'), // ValueKeyを使用
                  title: Text(_fruits[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
