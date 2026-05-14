import 'dart:async';
import 'dart:convert';

void main() async {
  print('--- Exercise 1: Product Model & Repository ---');
  await exercise1();

  print('\n--- Exercise 2: User Repository with JSON ---');
  await exercise2();

  print('\n--- Exercise 3: Async + Microtask Debugging ---');
  exercise3();
  // Wait a bit for async tasks in Exercise 3 to complete
  await Future.delayed(const Duration(milliseconds: 100));

  print('\n--- Exercise 4: Stream Transformation ---');
  await exercise4();

  print('\n--- Exercise 5: Factory Constructors & Cache ---');
  exercise5();
}

// --- Exercise 1: Product Model & Repository ---
class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

class ProductRepository {
  // StreamController.broadcast() allows multiple listeners
  final StreamController<Product> _controller = StreamController<Product>.broadcast();

  // Simulate fetching products from a server
  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(1, 'Laptop', 1500),
      Product(2, 'Smartphone', 800),
    ];
  }

  // Stream for real-time updates
  Stream<Product> liveAdded() => _controller.stream;

  // Add a new product and emit to stream
  void addProduct(Product p) {
    _controller.add(p);
  }
}

Future<void> exercise1() async {
  final repo = ProductRepository();

  // Listen to the stream
  repo.liveAdded().listen((product) {
    print('New product added live: $product');
  });

  // Get current products
  final products = await repo.getAll();
  print('All products: $products');

  // Add new items to trigger stream
  repo.addProduct(Product(3, 'Tablet', 500));
  repo.addProduct(Product(4, 'Smartwatch', 250));
  
  await Future.delayed(const Duration(milliseconds: 500));
}

// --- Exercise 2: User Repository with JSON ---
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  // Factory constructor for JSON deserialization
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'] as String,
      json['email'] as String,
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

Future<void> exercise2() async {
  // Simulated JSON from API
  String jsonResponse = '''
  [
    {"name": "Nguyen Van A", "email": "a@gmail.com"},
    {"name": "Tran Thi B", "email": "b@gmail.com"}
  ]
  ''';

  List<dynamic> decodedData = jsonDecode(jsonResponse);
  List<User> users = decodedData.map((json) => User.fromJson(json)).toList();

  print('Parsed Users from JSON:');
  for (var user in users) {
    print('- $user');
  }
}

// --- Exercise 3: Async + Microtask Debugging ---
void exercise3() {
  print('1. Start of Exercise 3');

  // Event Queue
  Future(() {
    print('4. Future callback (Event Queue)');
  });

  // Microtask Queue (Higher priority)
  scheduleMicrotask(() {
    print('3. Microtask callback (Microtask Queue)');
  });

  print('2. End of Exercise 3 (Synchronous)');

  /* 
    Explanation: 
    Microtasks run after synchronous code but before any tasks in the Event Queue.
  */
}

// --- Exercise 4: Stream Transformation ---
Future<void> exercise4() async {
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Transforming numbers (Square of evens):');

  await numberStream
      .map((n) => n * n) // 1, 4, 9, 16, 25
      .where((n) => n % 2 == 0) // 4, 16
      .forEach((result) {
        print('Emitted value: $result');
      });
}

// --- Exercise 5: Factory Constructors & Cache ---
class Settings {
  static Settings? _instance;

  // Private constructor
  Settings._internal();

  // Factory constructor for Singleton pattern
  factory Settings() {
    _instance ??= Settings._internal();
    return _instance!;
  }

  void showConfig() => print('Application settings loaded.');
}

void exercise5() {
  var s1 = Settings();
  var s2 = Settings();

  s1.showConfig();

  // Verify singleton
  bool isSame = identical(s1, s2);
  print('Are s1 and s2 the same instance? $isSame'); // Expected: true
}
