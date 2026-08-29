sealed class Shape {}

class Square extends Shape {
  final double side;
  Square(this.side);
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double w, h;
  Rectangle(this.w, this.h);
}

void main() {
  Object response = (statusCode: 200, data: {"user": "Alice"});

  Shape currentShape = Circle(5.0);


  double area = switch (currentShape) {
    Square(:final side) => side * side,
    Circle(:final radius) => 3.14159 * radius * radius,
    Rectangle(:final w, :final h) => w * h,
  };

  print('Calculated Area: $area');

  var entries = [
    (id: 1, info: ['Admin', 'Active']),
    (id: 2, info: ['User', 'Pending']),
  ];

  int userAge = 15;


}