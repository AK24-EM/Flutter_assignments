class Student {
  String name = '';
  int score = 0;

  void display() => print('$name scored $score');
}

void main() {
  // 1. Arithmetic & Relational Operators
  int modResult = 17 % 4;
  int intDivResult = 17 ~/ 4;
  print('Modulus: $modResult, Integer Division: $intDivResult');
  print('Is 10 >= 10? ${10 >= 10}');

  // 2. Type Test (is, is!) & Type Cast (as)
  dynamic val = "Dart Language";
  if (val is String) {
    String textVal = val as String;
    print('String length: ${textVal.length}');
  }

  // 3. Logical & Ternary Operators
  bool hasTicket = true;
  bool hasId = false;
  print('Has ticket and ID: ${hasTicket && hasId}');
  String status = hasTicket ? "Allowed" : "Denied";
  print('Status: $status');

  // 4. Cascade (..) & Null-Aware Cascade (?..)
  Student()
    ..name = 'John'
    ..score = 95
    ..display();

  Student? nullableStudent;
  nullableStudent
    ?..name = 'Jane'
    ?..display();
}