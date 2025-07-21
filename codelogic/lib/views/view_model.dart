// views/definition_lookup_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/definition_lookup.dart';
import '../models/story_model.dart';
import '../widgets/term_card.dart';

class DefinitionLookupView extends StatelessWidget {
  final List<DictionaryTerm> allTerms;
  const DefinitionLookupView({super.key, required this.allTerms});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DefinitionLookupViewModel>(
      create: (_) => DefinitionLookupViewModel(allTerms: allTerms),
      child: Consumer<DefinitionLookupViewModel>(
        builder: (context, vm, _) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                children: [
                  Icon(Icons.book, size: 40),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for a term...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: vm.onQueryChanged,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: vm.filteredTerms.isEmpty
                  ? Center(
                      child: Text(
                          'Enter a financial term to see its definition.'))
                  : ListView.builder(
                      itemCount: vm.filteredTerms.length,
                      itemBuilder: (context, index) {
                        final term = vm.filteredTerms[index];
                        return TermCard(term: term);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}