String clearSpecialCharacters(String? text) {
  return text != null
      ? text
          .replaceAll(RegExp(r'[^\w\s.,]'), '')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim()
      : '';
}

String formatCurrency(String currency) {
  if (currency == 'USD') {
    return '\$';
  } else if (currency == 'EUR') {
    return '€';
  } else if (currency == 'GBP') {
    return '£';
  } else {
    return ' $currency';
  }
}
