void main() {
  // 1. var Keyword
  var cityName = "Tokyo";
  print('cityName: $cityName, type: ${cityName.runtimeType}');

  // 2. Object vs dynamic
  Object objVal = 42;
  // objVal.someNonExistentMethod(); // Un-commenting this causes a compile-time error

  dynamic dynVal = "Hello";
  dynVal = 100;
  try {
    // Calling String method on an int causes a runtime error
    print(dynVal.toUpperCase());
  } catch (e) {
    print('Runtime error caught on dynamic object: $e');
  }

  // 3. final vs const
  // 'final' is initialized at runtime, so DateTime.now() works fine.
  final DateTime now = DateTime.now();

  // 'const' requires compile-time evaluation. DateTime.now() is determined at runtime,
  // which is why const cannot accept it.
  const double pi = 3.14159;
  print('Current time (final): $now');
  print('Pi constant (const): $pi');

  // 4. int & double
  int age = 25;
  double temperature = 98.6;
  print('Division result: ${temperature / age}');

  // 5. String & Interpolation
  String firstName = "Ada";
  String lastName = "Lovelace";
  String fullName = "$firstName $lastName";
  print('User: $fullName (Length: ${fullName.length})');

  // 6. bool
  bool isLoggedIn = false;
  isLoggedIn = !isLoggedIn;
  print('isLoggedIn toggled: $isLoggedIn');

  // 7. Runes & UTF-32
  String emojiStr = '🎯';
  print('Code units: ${emojiStr.codeUnits}');
  print('Runes: ${emojiStr.runes.toList()}');
}