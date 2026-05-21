import 'dart:async';

// Exercise 1: Product Model & Repository

class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

class ProductRepository {
  final StreamController<Product> _controller =
  StreamController<Product>.broadcast();

  // Simulate fetching product list one time
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      Product(id: 1, name: 'Milk', price: 10.5),
      Product(id: 2, name: 'Bread', price: 5.0),
      Product(id: 3, name: 'Egg', price: 3.0),
    ];
  }

  // Return stream for listening to newly added products
  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  // Add new product to stream
  void addProduct(Product product) {
    _controller.add(product);
  }

  // Close stream controller
  void dispose() {
    _controller.close();
  }
}

void main() async {
  final repo = ProductRepository();

  print('Exercise 1: Product Model & Repository');

  // Get all products one time using Future
  final products = await repo.getAll();

  print('Product list:');
  for (var product in products) {
    print('${product.id} - ${product.name} - \$${product.price}');
  }

  // Listen to live added products using Stream
  repo.liveAdded().listen((product) {
    print('New product added: ${product.name} - \$${product.price}');
  });

  // Simulate adding products in real time
  repo.addProduct(Product(id: 4, name: 'Cheese', price: 7.5));
  repo.addProduct(Product(id: 5, name: 'Butter', price: 6.0));

  // Wait a little before closing stream
  await Future.delayed(Duration(seconds: 1));
  repo.dispose();
}