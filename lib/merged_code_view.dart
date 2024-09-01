import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MergedCodeView extends StatelessWidget {
  final String mergedCode;

  const MergedCodeView({required this.mergedCode});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: mergedCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Merged code copied to clipboard'),
        backgroundColor: Colors.blueGrey[700],
      ),
    );
  }

  Map<String, int> _getCodeStats() {
    int lines = mergedCode.split('\n').length;
    int chars = mergedCode.length;
    int words = mergedCode.split(RegExp(r'\s+')).length;
    return {'lines': lines, 'characters': chars, 'words': words};
  }

  @override
  Widget build(BuildContext context) {
    final stats = _getCodeStats();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merged Code', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy, size: 28),
            onPressed: () => _copyToClipboard(context),
            tooltip: 'Copy merged code',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blueGrey[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Lines', stats['lines']!),
                _buildStatItem('Characters', stats['characters']!),
                _buildStatItem('Words', stats['words']!),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[850],
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    mergedCode,
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 14,
                      color: Colors.greenAccent[100],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
