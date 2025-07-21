class DictionaryTerm {
  final String term;
  final String definition;
  final String category;

  DictionaryTerm({
    required this.term,
    required this.definition,
    required this.category,
  });

  factory DictionaryTerm.fromJson(Map<String, dynamic> json) {
    return DictionaryTerm(
      term: json['Term'] as String,
      definition: json['Definition'] as String,
      category: json['Category'] as String,
    );
  }
}