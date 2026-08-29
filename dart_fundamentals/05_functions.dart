// 1. Positional, Optional, Named, & Default Parameters
void buildUser(String id, {required String username, String role = "guest"}) {
  print('ID: $id, User: $username, Role: $role');
}

// 2. Arrow Function (=>)
int square(int n) => n * n;

// 3. First-Class Functions & Anonymous Functions
void executeAction(Function action) {
  action();
}

// 4. Lexical Closures
Function makeAdder(int addBy) {
  return (int i) => i + addBy;
}

void main() {
  // Call buildUser with required parameters
  buildUser('U101', username: 'alex_dev');

  // Demonstrate arrow function
  print('Square of 4: ${square(4)}');

  // Pass an anonymous function into executeAction()
  executeAction(() => print("Executing..."));

  // Create an 'add5' closure and evaluate
  var add5 = makeAdder(5);
  print('add5(10): ${add5(10)}');
}