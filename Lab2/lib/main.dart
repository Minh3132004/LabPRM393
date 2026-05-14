import 'dart:async';

void main() async {
  print('--- Exercise 1: Basic Syntax & Data Types ---');
  exercise1();

  print('\n--- Exercise 2: Collections & Operators ---');
  exercise2();

  print('\n--- Exercise 3: Control Flow & Functions ---');
  exercise3();

  print('\n--- Exercise 4: Intro to OOP ---');
  exercise4();

  print('\n--- Exercise 5: Async, Future, Null Safety & Streams ---');
  await exercise5();
}

// --- Exercise 1: Basic Syntax & Data Types ---
void exercise1() {
  // Declare variables using core types
  int age = 20;
  double height = 1.75;
  String name = "Nguyen Van A";
  bool isStudent = true;

  // Use print() and string interpolation ($var, ${expr})
  print("Name: $name");
  print("Age: $age");
  print("Height: ${height}m");
  print("Is Student: $isStudent");
  print("Next year, I will be ${age + 1} years old.");
}

// --- Exercise 2: Collections & Operators ---
void exercise2() {
  // 1. Create a List of integers
  List<int> numbers = [10, 20, 30, 40];

  // 2. Use arithmetic & comparison operators
  int sum = numbers[0] + numbers[1]; // Operator +
  bool isEqual = (numbers[2] == 30); // Operator ==
  bool checkLogic = (sum > 20 && isEqual); // Operator &&

  print("Sum of first two: $sum");
  print("Is third element 30? $isEqual");
  print("Logic check (sum > 20 AND isEqual): $checkLogic");

  // Use conditional operator (ternary)
  String status = sum > 50 ? "High" : "Low";
  print("Status based on sum: $status");

  // 3. Create a Set (unique values)
  Set<String> fruits = {"Apple", "Banana", "Orange"};
  fruits.add("Apple"); // Duplicate Apple will be ignored
  fruits.add("Grape");

  // 4. Create a Map (key-value)
  Map<String, dynamic> person = {
    "id": "SV01",
    "name": "Hoang",
    "score": 8.5
  };

  // Access and indexing
  print("Fruits Set: $fruits");
  print("Person Name from Map: ${person['name']}");
  
  person.remove("id"); // Remove an entry
  print("Map after removing id: $person");
}

// --- Exercise 3: Control Flow & Functions ---
void exercise3() {
  // 1. If/else block to check score
  double score = 8.2;
  if (score >= 8.5) {
    print("Grade: Excellent");
  } else if (score >= 7.0) {
    print("Grade: Good");
  } else {
    print("Grade: Average");
  }

  // 2. Switch case for day of week
  int day = 3;
  switch (day) {
    case 1: print("Monday"); break;
    case 2: print("Tuesday"); break;
    case 3: print("Wednesday"); break;
    default: print("Other day");
  }

  // 3. Loop through a collection using for-in and forEach
  List<String> items = ["Laptop", "Phone", "Tablet"];
  
  print("Using for-in loop:");
  for (var item in items) {
    print("- $item");
  }

  print("Using forEach:");
  items.forEach((element) => print("Item: $element"));

  // 4. Function using normal and arrow syntax
  int sumNormal(int a, int b) {
    return a + b;
  }
  
  // Arrow function syntax
  int multiply(int a, int b) => a * b;

  print("Normal Function Sum (5+10): ${sumNormal(5, 10)}");
  print("Arrow Function Multiply (5*10): ${multiply(5, 10)}");
}

// --- Exercise 4: Intro to OOP ---
// 1. Create a class Car with property and method
class Car {
  String brand;

  Car(this.brand); // Default constructor

  // 2. Named constructor
  Car.named(this.brand);

  void drive() {
    print("$brand is driving...");
  }
}

// 3. Subclass ElectricCar that overrides a method
class ElectricCar extends Car {
  int batteryCapacity;

  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  @override
  void drive() {
    print("$brand (Electric) is driving silently with ${batteryCapacity}kWh...");
  }
}

void exercise4() {
  // 4. Instantiate objects and print results
  Car myCar = Car("Toyota");
  myCar.drive();

  ElectricCar myTesla = ElectricCar("Tesla", 100);
  myTesla.drive();
}

// --- Exercise 5: Async, Future, Null Safety & Streams ---
Future<void> exercise5() async {
  // 1 & 2. Async function using Future + await and simulate loading
  print("Starting data fetch...");
  String data = await fetchData();
  print("Result: $data");

  // 3. Practice null-safety operators (?, ??, !)
  String? nullableName; // Nullable type
  
  // ?? operator (if null use default)
  print("Name: ${nullableName ?? "Guest"}"); 
  
  nullableName = "Dart";
  // ! operator (assert not null)
  print("Name Length: ${nullableName!.length}");

  // 4. Create a simple Stream of integers and listen to values
  print("Listening to Stream...");
  Stream<int> countStream = countNumbers(3);
  await for (int val in countStream) {
    print("Stream value: $val");
  }
  print("Stream completed.");
}

// Function simulating async work
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2)); 
  return "Data loaded successfully!";
}

// Stream generator function
Stream<int> countNumbers(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // Emit values to the stream
  }
}
