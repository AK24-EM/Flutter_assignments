
class DatabaseManager {
  late final String connectionString = _initConnection();

  String _initConnection() {
    print('Connecting to Database...');
    return "postgres://localhost:5432/db";
  }
}

Never failWithUnreachable(String reason) {
  throw ArgumentError("Fatal Application Error: $reason");
}

void processInput(Object? input) {
  if (input == null) {
    failWithUnreachable("Input cannot be null");
  }

  print('Input type promoted length: ${input.toString().length}');
}

class Cache {
  String? _cachedData; 

  void validateCache() {
   
    final localData = _cachedData;
    if (localData != null) {
      print('Cache data length: ${localData.length}');
    }
  }
}

void main() {
  late String unassignedText;

  Map<String, List<int>?>? complexData;


  int scoreCount = complexData?['scores']?.length ?? -1;
  print('Scores count: $scoreCount');

  String? conditionalNullable = "Dart 3 Sound Null Safety";

  if (conditionalNullable != null) {
    print(conditionalNullable!.toUpperCase());
  }
}