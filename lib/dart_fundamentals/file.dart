Future<String> carCollections() async {
  const responseDelay = Duration(seconds: 3);

  print('CarOwner: We have 10 new car collections.');
  await Future.delayed(responseDelay);

  print('Client: I want the new Mercedes E-Class.');
  await Future.delayed(responseDelay);
  print('CarOwner: Yes, we have the new version. I will give it to you.');
  await Future.delayed(responseDelay);
  return 'Client: I got the car';
}

Future<void> main() async {
  final result = await carCollections();
  print(result);
}
