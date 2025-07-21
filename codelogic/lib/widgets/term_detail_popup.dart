import 'package:flutter/material.dart';
import '../models/story_model.dart';

/// Modal popup that displays complete term information with keyword highlighting
class TermDetailPopup extends StatelessWidget {
  final DictionaryTerm term;
  final String searchQuery;

  const TermDetailPopup({
    super.key,
    required this.term,
    this.searchQuery = '',
  });

  // Searches for the query string and highlights all matches with yellow background
  Widget _buildHighlightedText(String text, String query, TextStyle baseStyle) {
    // If no search query, return regular text
    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }

    // List to hold text segments (normal and highlighted)
    final List<TextSpan> spans = [];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    
    int start = 0;
    int index = lowerText.indexOf(lowerQuery);
    
    // Loop through all occurrences of the search term
    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: baseStyle,
        ));
      }
      
      // Add the highlighted match with special styling
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: baseStyle.copyWith(
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));
      
      // Move past the current match and search for next occurrence
      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }
    
    // Add any remaining text after the last match
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: baseStyle,
      ));
    }
    
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  /// Builds the popup dialog UI
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildHighlightedText(
                    term.term,
                    searchQuery,
                    const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                
                // Close button in top-right corner
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  tooltip: 'Close',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Category display as a styled chip/badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              ),
              child: Text(
                'Category: ${term.category}',
                style: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Definition:',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 8),
            // Definition content area - scrollable for long definitions
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  // Definition text with keyword highlighting
                  child: _buildHighlightedText(
                    term.definition,
                    searchQuery,
                    const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Action buttons row at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),

                const SizedBox(width: 8),
                // Primary action button with icon and custom styling
                ElevatedButton.icon(
                  onPressed: () {
                    // Placeholder functionality - shows confirmation message
                    // TODO: Implement actual bookmarking, sharing, or other features
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${term.term} bookmarked!'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.bookmark),
                  label: const Text('Bookmark'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Static utility method to display the popup
  // Makes it easy to show the popup from anywhere in the app
  static void show(BuildContext context, DictionaryTerm term, {String searchQuery = ''}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TermDetailPopup(
        term: term,
        searchQuery: searchQuery,
      ),
    );
  }
}
