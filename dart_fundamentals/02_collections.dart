void main() {
  // 1. List
  List<int> numbers = [10, 20, 30];
  numbers.add(40);
  numbers.remove(10);
  print('Second item in list: ${numbers[1]}');

  // 2. Set
  Set<String> fruits = {"apple", "banana", "apple"};
  print('Unique Set items: $fruits');

  // 3. Map
  Map<String, dynamic> student = {'name': 'Alex', 'grade': 'A'};
  student['age'] = 20;
  print('Student Map: $student');

  // 4. Type Conversion
  int parsedInt = int.parse("123");
  print('Parsed int: $parsedInt');

  double piVal = 45.67;
  String formattedDouble = piVal.toStringAsFixed(1);
  print('Formatted double: $formattedDouble');
}
