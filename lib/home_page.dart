import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'file_merger.dart';
import 'merged_code_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedPath;
  String _mergedCode = '';

  Future<void> _selectFolder() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      setState(() {
        _selectedPath = result;
      });
    }
  }

  Future<void> _mergeCode() async {
    if (_selectedPath != null) {
      String mergedCode = await FileMerger.mergeFilesInFolder(_selectedPath!);
      setState(() {
        _mergedCode = mergedCode;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MergedCodeView(mergedCode: _mergedCode),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Merger', style: TextStyle(fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.folder_open, size: 80, color: Colors.blueGrey[300]),
              SizedBox(height: 30),
              Text(
                'Supported languages:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: FileMerger.supportedExtensions.values
                    .toSet()
                    .map((lang) => Chip(
                          label: Text(lang),
                          backgroundColor: Colors.blueGrey[700],
                        ))
                    .toList(),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _selectFolder,
                child: Text('Select Folder', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              if (_selectedPath != null)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _selectedPath!,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _selectedPath != null ? _mergeCode : null,
                child: Text('Merge Code', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
