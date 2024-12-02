import 'package:daily_quotes_app/model/sharedquotes_manager.dart';
import 'package:flutter/material.dart';

class SharedQuotesScreen extends StatelessWidget {
  const SharedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedQuotes = SharedQuotesManager.instance.sharedQuotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shared Quotes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ), // Custom title color
        ),
        backgroundColor: Colors.black, // AppBar background color
        iconTheme:
            const IconThemeData(color: Colors.white), // Adjusts icon color
      ),
      body: sharedQuotes.isEmpty
          ? const Center(
              child: Text(
                'No shared quotes yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: sharedQuotes.length,
              itemBuilder: (context, index) {
                final quote = sharedQuotes[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      quote.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      '- ${quote.author}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
