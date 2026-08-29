void main() {
  // 1. if / else if / else
  int score = 85;
  String grade;
  if (score >= 90) {
    grade = 'A';
  } else if (score >= 80) {
    grade = 'B';
  } else if (score >= 70) {
    grade = 'C';
  } else {
    grade = 'F';
  }
  print('Grade: $grade');

  // 2. switch Statement & Switch Patterns (Dart 3+)
  Object shape = (10, 20); // Record type
  switch (shape) {
    case (int w, int h):
      print('Rectangle $w x $h');
      break;
    default:
      print('Unknown shape');
  }

  // 3. Loops (for, for-in, while, do-while)
  List<String> items = ['A', 'B', 'C'];

  for (int i = 0; i < items.length; i++) {
    print('Standard for loop item: ${items[i]}');
  }

  for (var item in items) {
    print('For-in loop item: $item');
  }

  int wCount = 1;
  while (wCount <= 3) {
    print('While count: $wCount');
    wCount++;
  }

  int dwCount = 1;
  do {
    print('Do-while count: $dwCount');
    dwCount++;
  } while (dwCount <= 1);

  // 4. break, continue, assert
  for (int i = 1; i <= 10; i++) {
    if (i == 5) continue;
    if (i == 8) break;
    print('Loop index: $i');
  }

  int speed = 50;
  assert(speed <= 100, "Speed limit exceeded");
  print('Speed assert passed: $speed');
}