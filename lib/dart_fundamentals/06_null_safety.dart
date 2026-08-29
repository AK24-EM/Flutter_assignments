class UserProfile {
  // 1. late Keyword
  late String bio;

  void initBio() {
    bio = "Developer from NYC";
  }
}

// 2. Never Type
Never throwFatalError(String msg) {
  throw Exception("Fatal Error: $msg");
}

void main() {
  UserProfile user = UserProfile();
  user.initBio();
  print('User bio: ${user.bio}');

  // 3. Non-Nullable vs Nullable Types (?)
  int nonNullable = 10;
  int? nullableVal;
  print('Non-nullable: $nonNullable, Nullable: $nullableVal');

  // 4. If-Null Operator (??) & Null-Aware Assignment (??=)
  int result = nullableVal ?? 0;
  print('Result using ??: $result');

  nullableVal ??= 5;
  print('Nullable value after ??=: $nullableVal');

  // 5. Null-Aware Access (?.) & Bang Operator (!)
  String? text;
  print('Safe access on null: ${text?.length}');

  text = "Dart";
  print('Bang operator access: ${text!.length}');

  // 6. Type Promotion
  Object data = "Smart Cast";
  if (data is String) {
    print(data.toUpperCase());
  }
}