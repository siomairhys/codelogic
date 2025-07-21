import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../models/story_model.dart';
import '../viewmodels/definition_lookup.dart';
import '../widgets/term_card.dart';

/// Main dictionary page that loads and displays financial terms
class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

/// State class for DictionaryPage that manages data loading and UI state
class _DictionaryPageState extends State<DictionaryPage> {
  List<DictionaryTerm> terms = [];
  bool isLoading = true;
  String? errorMessage;


  @override
  void initState() {
    super.initState();
    loadTerms(); 
  }

  /// Asynchronously loads dictionary terms from the JSON asset file
  /// Updates the UI state based on success or failure
  Future<void> loadTerms() async {
    try {
      final jsonString = await rootBundle.loadString(
          'assets/Finance_360_FINAL_300_Terms_Dictionary.json');
      
      final List<dynamic> data = json.decode(jsonString);
      
      setState(() {
        // Convert each JSON object to a DictionaryTerm using the fromJson factory
        terms = data.map((e) => DictionaryTerm.fromJson(e)).toList();
        isLoading = false; // Data loading completed successfully
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load terms: $e';
        isLoading = false;
      });
    }
  }

  /// Builds the widget tree for the dictionary page
  /// Shows different UI based on current state (loading, error, or loaded)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Definition Lookup'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(errorMessage!, 
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Reset state and try loading again
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          loadTerms();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              
              // Main app content - shown when data loads successfully
              : ChangeNotifierProvider<DefinitionLookupViewModel>(
                  // Create the ViewModel and provide it to child widgets
                  create: (_) => DefinitionLookupViewModel(allTerms: terms),
                  
                  // Consumer listens for changes in the ViewModel and rebuilds UI
                  child: Consumer<DefinitionLookupViewModel>(
                    builder: (context, vm, _) => Column(
                      children: [
                        // Search bar section
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Book icon to indicate this is a dictionary/reference app
                              const Icon(Icons.book, size: 40),
                              const SizedBox(width: 8),
                              
                              // Search text field that takes up remaining horizontal space
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Search for a term...',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: vm.onQueryChanged,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Expanded(
                          child: vm.filteredTerms.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Enter a financial term to see its definition.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              
                              // Show scrollable list of matching terms
                              : ListView.builder(
                                  itemCount: vm.filteredTerms.length,
                                  itemBuilder: (context, index) {
                                    final term = vm.filteredTerms[index];
                                    return TermCard(
                                      term: term,
                                      searchQuery: vm.query,
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
