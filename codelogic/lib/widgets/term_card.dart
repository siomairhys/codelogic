import 'package:flutter/material.dart';
import '../models/story_model.dart';
import 'term_detail_popup.dart';

// A card widget that displays a summary of a financial term
class TermCard extends StatelessWidget {
  final DictionaryTerm term;
  final String searchQuery;

  // Constructor for TermCard
  const TermCard({
    required this.term,
    this.searchQuery = '', 
    super.key,
  });

  // Builds the card widget with term preview and tap functionality
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          TermDetailPopup.show(context, term, searchQuery: searchQuery);
        },
        
        // Card content with padding
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with term title and expand icon
              Row(
                children: [
                  // Term title takes up most of the space
                  Expanded(
                    child: Text(
                      term.term,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff1d324f),
                      ),
                    ),
                  ),
                  
                  // Small icon indicating this card is tappable
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                term.definition.length > 120
                    ? '${term.definition.substring(0, 120)}...'
                    : term.definition,
                style: const TextStyle(fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(
                        Color(0xff1d324f).withAlpha((0.1 * 255).toInt()),
                        Colors.white,
                      ), // Light purple background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      term.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff1d324f),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  // Hint text encouraging user to tap for more details
                  Text(
                    'Tap for full definition',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}