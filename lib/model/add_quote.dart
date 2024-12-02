// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';

// // class Quote {
// //   final String text;
// //   final String author;

// //   Quote({required this.text, required this.author});
// // }

// // class QuoteManager {
// //   final ValueNotifier<List<Quote>> quotesNotifier = ValueNotifier([]);

// //   // Future<void> loadQuotes() async {
// //   //   try {
// //   //     final String jsonString =
// //   //         await rootBundle.loadString("assets/quotes.json");
// //   //     final List<dynamic> jsonData = json.decode(jsonString);
// //   //     final quotes = jsonData
// //   //         .map((item) =>
// //   //             Quote(text: item["quoteText"], author: item["quoteAuthor"]))
// //   //         .toList();
// //   //     quotesNotifier.value = quotes;
// //   //   } catch (e) {
// //   //     debugPrint("Error loading quotes: $e");
// //   //   }
// //   // }

// //   Future<void> loadQuotes() async {
// //   try {
// //     final String jsonString = await rootBundle.loadString('assets/quotes.json');
// //     final List<dynamic> jsonData = json.decode(jsonString);
// //     final quotes = jsonData
// //         .map((item) => Quote(text: item['quoteText'], author: item['quoteAuthor']))
// //         .toList();

// //     // Debugging logs
// //     debugPrint("Quotes loaded: ${quotes.length}"); // Check the number of quotes loaded
// //     quotesNotifier.value = quotes; // Update the notifier
// //   } catch (e) {
// //     debugPrint("Error loading quotes: $e");
// //   }
// // }

// // Quote getDailyQuote() {
// //   final quotes = quotesNotifier.value;
// //   if (quotes.isNotEmpty) {
// //     return quotes[DateTime.now().day % quotes.length];
// //   }
// //   return Quote(text: "No quote available", author: "Unknown");
// // }

// //   // Quote getDailyQuote() {
// //   //   final quotes = quotesNotifier.value;
// //   //   return quotes[DateTime.now().day % quotes.length];
// //   // }
// // }

// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';

// class Quote {
//   final String text;
//   final String author;

//   Quote({required this.text, required this.author});
// }

// class QuoteManager {
//   // ValueNotifier to hold and manage the list of quotes
//   ValueNotifier<List<Quote>> quotesNotifier = ValueNotifier([]);

//   // Load quotes from the JSON file
//   Future<void> loadQuotes() async {
//     try {
//       final String jsonString =
//           await rootBundle.loadString('assets/quotes.json');
//       final List<dynamic> jsonData = json.decode(jsonString);
//       final quotes = jsonData.map((item) {
//         return Quote(
//           text: item['quoteText'],
//           author: item['quoteAuthor'],
//         );
//       }).toList();

//       quotesNotifier.value = quotes; // Update ValueNotifier
//     } catch (e) {
//       debugPrint("Error loading quotes: $e");
//     }
//   }

//   // Get the daily quote based on the current day
//   Quote getDailyQuote() {
//     final quotes = quotesNotifier.value;
//     if (quotes.isNotEmpty) {
//       return quotes[DateTime.now().day % quotes.length];
//     }
//     return Quote(
//       text: "No quote available",
//       author: "Unknown",
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Quote class to hold the text and author
class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});
}

class QuoteManager {
  // ValueNotifier to hold and manage the list of quotes
  ValueNotifier<List<Quote>> quotesNotifier = ValueNotifier([]);

  // Load quotes from the JSON file
  Future<void> loadQuotes() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/quotes.json');
      debugPrint(
          "JSON Loaded Successfully: ${jsonString.substring(0, 100)}"); // Print first 100 characters of JSON for debugging

      final List<dynamic> jsonData = json.decode(jsonString);
      final quotes = jsonData.map((item) {
        return Quote(
          text: item['quoteText'],
          author: item['quoteAuthor'],
        );
      }).toList();

      quotesNotifier.value =
          quotes; // Update the notifier with the loaded quotes
      debugPrint(
          "Quotes Loaded: ${quotes.length}"); // Confirm number of quotes loaded
    } catch (e) {
      debugPrint("Error loading quotes: $e"); // Log the error if loading fails
    }
  }

  // Get the daily quote based on the current day
  Quote getDailyQuote() {
    final quotes = quotesNotifier.value;
    if (quotes.isNotEmpty) {
      // Cycle through quotes based on the current day
      return quotes[DateTime.now().day % quotes.length];
    }
    return Quote(
      text: "No quote available", // Fallback if no quotes are loaded
      author: "Unknown",
    );
  }
}
