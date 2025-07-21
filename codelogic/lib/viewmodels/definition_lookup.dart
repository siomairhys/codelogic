import 'package:flutter/material.dart';
import '../models/story_model.dart';

/// This class is responsible for managing the list of terms and the current search query
class DefinitionLookupViewModel extends ChangeNotifier {
  final List<DictionaryTerm> allTerms;
  
  /// Filtered list of terms that match the current search query
  List<DictionaryTerm> filteredTerms = [];
  
  /// This variable is updated whenever the user types in the search box
  String query = "";

  /// Complete list of dictionary terms to search through
  DefinitionLookupViewModel({required this.allTerms});

  void onQueryChanged(String newQuery) {
    // Update the current query
    query = newQuery;
    
    if (query.isEmpty) {
      filteredTerms = [];
    } else {
      filteredTerms = allTerms
          .where((term) =>
              term.term.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } 
    notifyListeners();
  }
}