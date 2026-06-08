// Lab 2 – Dart Essentials Practice Lab

// ===============================
// Exercise 4: Intro to OOP
// ===============================

class Car {
  String brand;

  // Constructor thường
  Car(this.brand);

  // Named constructor
  Car.named({required this.brand});

  void showInfo() {
    print('This is a car from $brand');
  }
}

class ElectricCar extends Car {
  int batteryCapacity;

  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  // Override method từ class cha
  @override
  void showInfo() {
    print('This is an electric car from $brand with $batteryCapacity kWh battery');
  }
}

// ===============================
// Exercise 5: Async Function
// ===============================

Future<String> loadData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data loaded successfully';
}

// Arrow function
int square(int number) => number * number;

// Normal function
int add(int a, int b) {
  return a + b;
}

Future<void> main() async {
  print('===== Lab 2 – Dart Essentials Practice Lab =====');

  // ===============================
  // Exercise 1: Basic Syntax & Data Types
  // ===============================

  print('\nExercise 1: Basic Syntax & Data Types');

  int age = 20;
  double height = 1.65;
  String name = 'Tiona';
  bool isStudent = true;

  print('Name: $name');
  print('Age: $age');
  print('Height: $height m');
  print('Is student: $isStudent');
  print('$name is $age years old and her height is ${height * 100} cm');

  // ===============================
  // Exercise 2: Collections & Operators
  // ===============================

  print('\nExercise 2: Collections & Operators');

  List<int> numbers = [1, 2, 3, 4, 5];

  print('Original list: $numbers');
  print('First number: ${numbers[0]}');

  numbers.add(6);
  print('After add 6: $numbers');

  numbers.remove(3);
  print('After remove 3: $numbers');

  int a = 10;
  int b = 5;

  print('a + b = ${a + b}');
  print('a - b = ${a - b}');
  print('a == b: ${a == b}');
  print('a > b && b > 0: ${a > b && b > 0}');

  String result = a > b ? 'a is greater than b' : 'a is not greater than b';
  print(result);

  Set<String> fruits = {'Apple', 'Banana', 'Orange', 'Apple'};
  print('Set of fruits: $fruits');

  Map<String, int> scores = {
    'Math': 90,
    'English': 85,
    'Science': 88,
  };

  print('Scores map: $scores');
  print('Math score: ${scores['Math']}');

  scores['History'] = 80;
  print('After adding History: $scores');

  // ===============================
  // Exercise 3: Control Flow & Functions
  // ===============================

  print('\nExercise 3: Control Flow & Functions');

  int score = 85;

  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else if (score >= 70) {
    print('Grade: C');
  } else {
    print('Grade: F');
  }

  String day = 'Monday';

  switch (day) {
    case 'Monday':
      print('Today is Monday');
      break;
    case 'Tuesday':
      print('Today is Tuesday');
      break;
    case 'Wednesday':
      print('Today is Wednesday');
      break;
    default:
      print('Another day');
  }

  print('For loop:');
  for (int i = 0; i < numbers.length; i++) {
    print(numbers[i]);
  }

  print('For-in loop:');
  for (int number in numbers) {
    print(number);
  }

  print('forEach loop:');
  numbers.forEach((number) {
    print(number);
  });

  print('Add function: ${add(5, 3)}');
  print('Square function: ${square(4)}');

  // ===============================
  // Exercise 4: Intro to OOP
  // ===============================

  print('\nExercise 4: Intro to OOP');

  Car car1 = Car('Toyota');
  car1.showInfo();

  Car car2 = Car.named(brand: 'Honda');
  car2.showInfo();

  ElectricCar electricCar = ElectricCar('Tesla', 75);
  electricCar.showInfo();

  // ===============================
  // Exercise 5: Async, Future, Null Safety & Streams
  // ===============================

  print('\nExercise 5: Async, Future, Null Safety & Streams');

  print('Loading data...');
  String data = await loadData();
  print(data);

  String? nullableName;
  print('Nullable name: $nullableName');

  String displayName = nullableName ?? 'Guest';
  print('Display name using ?? : $displayName');

  nullableName = 'Dart Student';
  print('Nullable name length using ! : ${nullableName.length}');

  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Stream values:');
  await for (int value in numberStream) {
    print('Stream emitted: $value');
  }

  print('\n===== Lab 2 completed successfully =====');
}