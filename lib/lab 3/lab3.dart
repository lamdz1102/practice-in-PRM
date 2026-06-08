import 'dart:async';

// ===============================
// Exercise 1: Product Model & Repository
// ===============================

class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price)';
  }
}

class ProductRepository {
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 1200),
    Product(id: 2, name: 'Mouse', price: 25),
  ];

  final StreamController<Product> _controller =
  StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return _products;
  }

  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

// ===============================
// Exercise 2: User Repository with JSON
// ===============================

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> jsonData = [
      {
        'name': 'Nguyen Van A',
        'email': 'a@gmail.com',
      },
      {
        'name': 'Tran Thi B',
        'email': 'b@gmail.com',
      },
      {
        'name': 'Le Van C',
        'email': 'c@gmail.com',
      },
    ];

    return jsonData.map((json) => User.fromJson(json)).toList();
  }
}

// ===============================
// Exercise 3: Async + Microtask Debugging
// ===============================

void asyncMicrotaskDemo() {
  print('\nExercise 3: Async + Microtask Debugging');

  print('1. Start');

  scheduleMicrotask(() {
    print('2. Microtask');
  });

  Future(() {
    print('3. Future event');
  });

  print('4. End');
}

// ===============================
// Exercise 4: Stream Transformation
// ===============================

Future<void> streamTransformationDemo() async {
  print('\nExercise 4: Stream Transformation');

  final Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  final Stream<int> resultStream = numberStream
      .map((number) => number * number)
      .where((square) => square % 2 == 0);

  await for (final value in resultStream) {
    print('Even square: $value');
  }
}

// ===============================
// Exercise 5: Factory Constructors & Cache
// ===============================

class Settings {
  static final Settings _instance = Settings._internal();

  String theme = 'Light';

  Settings._internal();

  factory Settings() {
    return _instance;
  }
}

void factoryConstructorDemo() {
  print('\nExercise 5: Factory Constructors & Cache');

  final settings1 = Settings();
  final settings2 = Settings();

  settings1.theme = 'Dark';

  print('settings1 theme: ${settings1.theme}');
  print('settings2 theme: ${settings2.theme}');
  print('Are both same instance? ${identical(settings1, settings2)}');
}

// ===============================
// Main Function
// ===============================

Future<void> main() async {
  print('Lab 3 - Advanced Dart Practice Exercises');

  // Exercise 1
  print('\nExercise 1: Product Model & Repository');

  final productRepository = ProductRepository();

  productRepository.liveAdded().listen((product) {
    print('New product added: $product');
  });

  final products = await productRepository.getAll();

  print('All products:');
  for (final product in products) {
    print(product);
  }

  productRepository.addProduct(
    Product(id: 3, name: 'Keyboard', price: 45),
  );

  await Future.delayed(const Duration(milliseconds: 500));
  productRepository.dispose();

  // Exercise 2
  print('\nExercise 2: User Repository with JSON');

  final userRepository = UserRepository();
  final users = await userRepository.fetchUsers();

  for (final user in users) {
    print(user);
  }

  // Exercise 3
  asyncMicrotaskDemo();

  await Future.delayed(const Duration(milliseconds: 500));

  // Exercise 4
  await streamTransformationDemo();

  // Exercise 5
  factoryConstructorDemo();
}