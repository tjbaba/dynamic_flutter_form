/// Utility function to get alphabetic character from index
/// Returns A, B, C, etc. for indices 0, 1, 2, etc.
/// After Z, continues with AA, AB, AC, etc.
String getCharacterFromIndex(int index) {
  if (index < 0) return 'A';

  String result = '';
  int temp = index;

  do {
    result = String.fromCharCode(65 + (temp % 26)) + result;
    temp = (temp ~/ 26) - 1;
  } while (temp >= 0);

  return result;
}

/// Alternative function for numeric indices (1, 2, 3, etc.)
String getNumericFromIndex(int index) {
  return (index + 1).toString();
}

/// Function to get Roman numerals for indices
String getRomanFromIndex(int index) {
  const List<int> values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
  const List<String> symbols = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'];

  int number = index + 1;
  String result = '';

  for (int i = 0; i < values.length; i++) {
    while (number >= values[i]) {
      result += symbols[i];
      number -= values[i];
    }
  }

  return result;
}

/// Enum for different indexing styles
enum IndexStyle {
  alphabetic,
  numeric,
  roman,
}

/// Get index string based on style
String getIndexString(int index, IndexStyle style) {
  switch (style) {
    case IndexStyle.alphabetic:
      return getCharacterFromIndex(index);
    case IndexStyle.numeric:
      return getNumericFromIndex(index);
    case IndexStyle.roman:
      return getRomanFromIndex(index);
  }
}