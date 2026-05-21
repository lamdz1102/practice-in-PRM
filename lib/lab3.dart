// import 'dart:async';
//
// // Exercise 1: Product Model & Repository
//
// class Product {
//   final int id;
//   final String name;
//   final double price;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//   });
// }
//
// class ProductRepository {
//   final StreamController<Product> _controller =
//   StreamController<Product>.broadcast();
//
//
//   Future<List<Product>> getAll() async {
//     await Future.delayed(Duration(seconds: 1));
//
//     return [
//       Product(id: 1, name: 'Milk', price: 10.5),
//       Product(id: 2, name: 'Bread', price: 5.0),
//       Product(id: 3, name: 'Egg', price: 3.0),
//     ];
//   }
//
//   // Return stream for listening to newly added products
//   Stream<Product> liveAdded() {
//     return _controller.stream;
//   }
//
//   // Add new product to stream
//   void addProduct(Product product) {
//     _controller.add(product);
//   }
//
//   // Close stream controller
//   void dispose() {
//     _controller.close();
//   }
// }
//
// void main() async {
//   final repo = ProductRepository();
//
//   print('Exercise 1: Product Model & Repository');
//
//   // Get all products one time using Future
//   final products = await repo.getAll();
//
//   print('Product list:');
//   for (var product in products) {
//     print('${product.id} - ${product.name} - \$${product.price}');
//   }
//
//   // Listen to live added products using Stream
//   repo.liveAdded().listen((product) {
//     print('New product added: ${product.name} - \$${product.price}');
//   });
//
//   // Simulate adding products in real time
//   repo.addProduct(Product(id: 4, name: 'Cheese', price: 7.5));
//   repo.addProduct(Product(id: 5, name: 'Butter', price: 6.0));
//
//   // Wait a little before closing stream
//   await Future.delayed(Duration(seconds: 1));
//   repo.dispose();
// }

// Exercise 2: User Repository with JSON

// class User {
//   final String name;
//   final String email;
//
//   User({
//     required this.name,
//     required this.email,
//   });
//
//   // Convert JSON map to User object
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name'],
//       email: json['email'],
//     );
//   }
// }
//
// class UserRepository {
//   // Simulate fetching JSON data from API
//   Future<List<User>> getUsers() async {
//     await Future.delayed(Duration(seconds: 1));
//
//     final List<Map<String, dynamic>> jsonData = [
//       {
//         'name': 'Anna',
//         'email': 'anna@gmail.com',
//       },
//       {
//         'name': 'Ben',
//         'email': 'ben@gmail.com',
//       },
//       {
//         'name': 'Chris',
//         'email': 'chris@gmail.com',
//       },
//     ];
//
//     return jsonData.map((json) => User.fromJson(json)).toList();
//   }
// }
//
// void main() async {
//   final repo = UserRepository();
//
//   print('Exercise 2: User Repository with JSON');
//
//   final users = await repo.getUsers();
//
//   for (var user in users) {
//     print('${user.name} - ${user.email}');
//   }
// }

// import 'dart:async';
//
// void main() {
//   runEx3();
// }
//
// // Exercise 3: Async + Microtask Debugging
// void runEx3() {
//   print('Exercise 3: Async + Microtask Debugging');
//   print('A - Start synchronous code');
//   scheduleMicrotask(() {
//     print('C - Microtask runs before Future event');
//   });
//   Future(() {
//     print('D - Future runs from event queue');
//   });
//   print('B - End synchronous code');
// }

// Exercise 4: Stream Transformation
void main() {
  runEx4();
}
void runEx4(){
  print('Exercise 4: Stream Transformation');

  Stream.fromIterable([1, 2, 3, 4, 5])
  // Transform each number to its square
      .map((number) => number * number)
  // Keep only even squared numbers
      .where((number) => number % 2 == 0)
  // Listen and print each emitted value
      .listen((value) {
    print('Emitted value: $value');
  });
}