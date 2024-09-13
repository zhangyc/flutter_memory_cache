library flutter_memory_cache;

import 'dart:collection';

import 'src/base/cache_entry.dart';
import 'src/base/cache_eviction_policy.dart';

// 通用缓存工具，支持策略切换
class Cache<K, V> {
  final int capacity;
  final Duration ttl;
  final CacheEvictionPolicy<K> _policy; // 策略接口
  final LinkedHashMap<K, CacheEntry<V>> _cacheMap = LinkedHashMap();

  Cache(this.capacity, this.ttl, this._policy);

  V? get(K key) {
    if (_cacheMap.containsKey(key)) {
      final entry = _cacheMap.remove(key);
      if (entry != null && !_isExpired(entry)) {
        // 记录访问并重新插入
        _policy.recordAccess(key);
        _cacheMap[key] = entry;
        return entry.value;
      } else {
        _cacheMap.remove(key); // 移除过期条目
      }
    }
    return null;
  }

  void put(K key, V value) {
    if (_cacheMap.length >= capacity) {
      // 容量满了，使用策略移除旧条目
      final keyToEvict = _policy.evict(_cacheMap);
      if (keyToEvict != null) {
        _cacheMap.remove(keyToEvict);
      }
    }
    _policy.recordInsertion(key);
    _cacheMap[key] = CacheEntry(value);
  }

  bool _isExpired(CacheEntry<V> entry) {
    return DateTime.now().difference(entry.timestamp) > ttl;
  }

  @override
  String toString() {
    return _cacheMap.toString();
  }
}

