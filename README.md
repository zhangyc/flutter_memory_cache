flutter_memory_cache
flutter_memory_cache is a lightweight and customizable memory cache solution for Flutter applications, supporting multiple caching strategies like LRU (Least Recently Used), FIFO (First In, First Out), and LFU (Least Frequently Used). With easy-to-set TTL (Time to Live) options, it helps to optimize performance by reducing the need for frequent network or database requests.

Features
Multiple caching strategies: Choose from LRU, FIFO, or LFU to suit your use case.
TTL (Time to Live): Set an expiration time for cache entries.
High Performance: Efficient memory management to keep your app running smoothly.
Flexible: Easily configurable for different caching needs.
Getting started
Prerequisites
Dart SDK 2.12+
Flutter 2.0+
To use this package, include it in your pubspec.yaml file:

yaml
复制代码
dependencies:
flutter_memory_cache: ^1.0.0
Then, run:

bash
复制代码
flutter pub get
Usage
Here’s a quick example of how to use flutter_memory_cache:

dart
复制代码
import 'package:flutter_memory_cache/flutter_memory_cache.dart';

void main() {
// Create a cache with a capacity of 3 entries and LRU strategy
final cache = Cache<String, String>(
capacity: 3,
ttl: Duration(seconds: 5),
policy: LRU(),
);

cache.put('key1', 'value1');
cache.put('key2', 'value2');
cache.put('key3', 'value3');

print(cache.get('key1')); // Outputs: value1
Future.delayed(Duration(seconds: 6), () {
print(cache.get('key1')); // Outputs: null (key1 has expired)
});
}
Supported Strategies:
LRU (Least Recently Used): Removes the least recently accessed item when capacity is reached.
FIFO (First In First Out): Removes the oldest added item when capacity is reached.
LFU (Least Frequently Used): Removes the least accessed item when capacity is reached.
Additional information
For more details, examples, and contribution guidelines, check out the repository.

Feel free to file issues and suggest new features on the GitHub page. Contributions are welcome!
