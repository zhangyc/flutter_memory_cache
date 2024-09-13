import 'package:flutter_memory_cache/src/fifo.dart';
import 'package:flutter_memory_cache/src/lfu.dart';
import 'package:flutter_memory_cache/src/lru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_memory_cache/flutter_memory_cache.dart';

void main() {
  group('LRU Cache Tests', () {
    test('Stores and retrieves values correctly', () {
      final cache = Cache<String, String>(
         3,
         Duration(seconds: 5),
         LRU(),
      );

      cache.put('key1', 'value1');
      cache.put('key2', 'value2');
      expect(cache.get('key1'), equals('value1'));
      expect(cache.get('key2'), equals('value2'));
    });

    test('Evicts least recently used entry when capacity is reached', () {
      final cache = Cache<String, String>(
         2,
         Duration(seconds: 5),
         LRU(),
      );

      cache.put('key1', 'value1');
      cache.put('key2', 'value2');
      cache.put('key3', 'value3'); // key1 should be evicted

      expect(cache.get('key1'), isNull);
      expect(cache.get('key2'), equals('value2'));
      expect(cache.get('key3'), equals('value3'));
    });

    test('Evicts expired entries', () async {
      final cache = Cache<String, String>(
         3,
         Duration(seconds: 1),
         LRU(),
      );

      cache.put('key1', 'value1');
      await Future.delayed(Duration(seconds: 2)); // Wait for key1 to expire
      expect(cache.get('key1'), isNull);
    });
  });

  group('FIFO Cache Tests', () {
    test('Stores and retrieves values correctly', () {
      final cache = Cache<String, String>(
         3,
         Duration(seconds: 5),
         FIFO(),
      );

      cache.put('key1', 'value1');
      cache.put('key2', 'value2');
      expect(cache.get('key1'), equals('value1'));
      expect(cache.get('key2'), equals('value2'));
    });

    test('Evicts first-in entry when capacity is reached', () {
      final cache = Cache<String, String>(
         2,
         Duration(seconds: 5),
         FIFO(),
      );

      cache.put('key1', 'value1');
      cache.put('key2', 'value2');
      cache.put('key3', 'value3'); // key1 should be evicted

      expect(cache.get('key1'), isNull);
      expect(cache.get('key2'), equals('value2'));
      expect(cache.get('key3'), equals('value3'));
    });
  });

  group('LFU Cache Tests', () {
    test('Stores and retrieves values correctly', () {
      final cache = Cache<String, String>(
         3,
         Duration(seconds: 5),
         LFU(),
      );

      cache.put('key1', 'value1');
      cache.put('key2', 'value2');
      expect(cache.get('key1'), equals('value1'));
      expect(cache.get('key2'), equals('value2'));
    });

    test('Evicts least frequently used entry', () {
      final cache = Cache<String, String>(
         2,
         Duration(seconds: 5),
         LFU(),
      );

      cache.put('key1', 'value1');
      cache.put('key2', 'value2');
      cache.get('key1'); // Access key1 once
      cache.put('key3', 'value3'); // key2 should be evicted because it's the least accessed

      expect(cache.get('key1'), equals('value1'));
      expect(cache.get('key2'), isNull);
      expect(cache.get('key3'), equals('value3'));
    });
  });

  group('TTL (Time to Live) Tests', () {
    test('Expires entries after TTL', () async {
      final cache = Cache<String, String>(
         3,
         Duration(seconds: 1),
         LRU(),
      );

      cache.put('key1', 'value1');
      await Future.delayed(Duration(seconds: 2)); // Wait for key1 to expire
      expect(cache.get('key1'), isNull);
    });

    test('TTL does not affect non-expired entries', () async {
      final cache = Cache<String, String>(
         3,
         Duration(seconds: 5),
         LRU(),
      );

      cache.put('key1', 'value1');
      await Future.delayed(Duration(seconds: 2)); // Wait for some time, but not enough to expire
      expect(cache.get('key1'), equals('value1'));
    });
  });
}
