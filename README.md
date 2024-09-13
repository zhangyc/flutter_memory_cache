# flutter_memory_cache

`flutter_memory_cache` is a lightweight and customizable in-memory cache solution for Flutter applications. It supports various caching strategies such as LRU (Least Recently Used), FIFO (First In First Out), and LFU (Least Frequently Used). With easy-to-set TTL (Time To Live) options, it helps optimize performance by reducing frequent network or database requests.

## Features

- **Multiple Caching Strategies**: Choose between LRU, FIFO, or LFU to suit your use case.
- **TTL (Time To Live)**: Set expiration time for cache entries.
- **High Performance**: Efficient memory management to keep your app running smoothly.
- **Flexible**: Easy to configure to meet different caching needs.

## Getting Started

### Prerequisites

- Dart SDK 2.12+
- Flutter 2.0+

To use this package, include it in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_memory_cache: ^0.0.1
```  
## Usage

To use `flutter_memory_cache`, follow these steps:

1. **Add the dependency**: Run the following command to get the package:
    ```bash
    flutter pub get
    ```

2. **Usage Example**:

    ```dart
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

      print(cache.get('key1')); // Output: value1

      Future.delayed(Duration(seconds: 6), () {
        print(cache.get('key1')); // Output: null (key1 has expired)
      });
    }
    ```

3. **Supported Policies**:

    - **LRU (Least Recently Used)**: Removes the least recently accessed item when the capacity limit is reached.
    - **FIFO (First In First Out)**: Removes the earliest added item when the capacity limit is reached.
    - **LFU (Least Frequently Used)**: Removes the least frequently accessed item when the capacity limit is reached.

4. **Additional Information**:

    For more details, examples, and contribution guidelines, please refer to the [GitHub repository](https://github.com/your-repository/flutter_memory_cache). Feel free to raise issues and suggest new features. Contributions are welcome!
