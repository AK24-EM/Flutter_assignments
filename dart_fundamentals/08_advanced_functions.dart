class APIConfig {
  final String endpoint;
  final int timeoutSeconds;
  final bool enableLogs;


  APIConfig({
    required this.endpoint,
    this.timeoutSeconds = 30,
    this.enableLogs = false,
  });
}


void sendNotification(
  String recipient, [
  String message = "Default Hello",
], {
  bool urgent = false,
  required String sender,
}) {
  print('From: $sender -> To: $recipient | Msg: $message | Urgent: $urgent');
}

List<int> customMap(List<int> list, int Function(int) action) {
  List<int> result = [];
  for (var item in list) {
    result.add(action(item));
  }
  return result;
}

Function createCounter() {
  int count = 0; 
  return () {
    count++;
    return count;
  };
}

void main() {

}