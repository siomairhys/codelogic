# Financial Dictionary App

A comprehensive Flutter application that provides quick access to financial terms and definitions. This app serves as a digital financial dictionary, helping users understand complex financial concepts with ease.

## 📱 What This App Does

This is a **Financial Definition Lookup App** that allows users to:

- **Search Financial Terms**: Instantly search through 300+ financial terms
- **Get Detailed Definitions**: Access comprehensive explanations of financial concepts
- **Category-Based Organization**: Terms are organized by financial categories (Budgeting & Saving, Investments, etc.)
- **Smart Search with Highlighting**: Search terms are highlighted in both titles and definitions
- **Interactive Interface**: Tap on term cards to view detailed popup definitions
- **Bookmark Feature**: Save important terms for quick reference (placeholder functionality)

## 🏗️ Architecture & Design Patterns

### **MVVM Architecture**
The app follows the Model-View-ViewModel (MVVM) pattern for clean separation of concerns:

- **Models** (`models/story_model.dart`): Data structures for financial terms
- **Views** (`views/`): UI components and pages
- **ViewModels** (`viewmodels/definition_lookup.dart`): Business logic and state management
- **Widgets** (`widgets/`): Reusable UI components

### **State Management**
- Uses **Provider** for state management
- Implements **ChangeNotifier** pattern for reactive UI updates
- Real-time search filtering without performance issues

## 🔧 Technical Implementation

### **Key Features Implemented:**

1. **Data Loading & Error Handling**
   - Loads 300+ terms from JSON asset file
   - Graceful error handling with retry functionality
   - Loading states with progress indicators

2. **Advanced Search Functionality**
   - Real-time search filtering
   - Case-insensitive search
   - Keyword highlighting in search results
   - Search through term names

3. **Rich UI Components**
   - Custom term cards with preview text
   - Modal popups for detailed definitions
   - Category badges and visual indicators
   - Responsive design for different screen sizes

4. **Text Highlighting System**
   - Dynamic keyword highlighting in search results
   - Yellow highlighting for matched search terms
   - Works in both term titles and definitions

### **File Structure:**
```
lib/
├── main.dart                          # App entry point
├── models/
│   └── story_model.dart               # DictionaryTerm data model
├── views/
│   └── dictionary_page.dart          # Main dictionary interface
├── viewmodels/
│   └── definition_lookup.dart        # Search logic & state management
└── widgets/
    ├── term_card.dart                # Individual term display cards
    └── term_detail_popup.dart        # Detailed term popup modal

assets/
└── Finance_360_FINAL_300_Terms_Dictionary.json  # Financial terms database (1367 lines)
```

## 📊 Data Source

The app uses a comprehensive JSON dataset located in the `assets/` folder:

### **Asset File:**
- **File**: `Finance_360_FINAL_300_Terms_Dictionary.json`
- **Size**: 1,367 lines of structured financial data
- **Content**: 300+ carefully curated financial terms and definitions
- **Categories**: Budgeting & Saving, Investments, Credit & Debt, Insurance, and more
- **Format**: Clean, structured JSON for easy parsing and extensibility

### **Data Structure:**
Each financial term in the JSON file follows this format:
```json
{
  "Term": "Assets",
  "Definition": "Anything of value that you own, like cash, property, or investments.",
  "Category": "Budgeting & Saving"
}
```

### **Asset Configuration:**
The JSON file is properly configured in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/Finance_360_FINAL_300_Terms_Dictionary.json
```

### **Data Loading Process:**
1. App loads JSON file from assets using `rootBundle.loadString()`
2. JSON data is parsed and converted to `DictionaryTerm` objects
3. Terms are stored in memory for fast search and filtering
4. Error handling ensures graceful fallback if asset loading fails

## 🎨 UI/UX Features

### **Design Elements:**
- **Material Design 3** with custom color scheme
- **Deep Purple** theme with professional appearance
- **Card-based layout** for easy scanning
- **Intuitive search interface** with book icon
- **Responsive typography** for readability

### **User Experience:**
- **Instant search results** as you type
- **Preview definitions** on term cards
- **Expandable detailed view** via modal popups
- **Visual feedback** with highlighting and animations
- **Error states** with retry options

