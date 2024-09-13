// LRU策略实现
import 'dart:collection';

import 'base/cache_entry.dart';
import 'base/cache_eviction_policy.dart';

class LRU<K> implements CacheEvictionPolicy<K> {
  final LinkedHashMap<K, CacheEntry> _accessOrder = LinkedHashMap();

  @override
  void recordAccess(K key) {
    // 每次访问时，将条目移到最近访问的位置
    final entry = _accessOrder.remove(key);
    if (entry != null) {
      _accessOrder[key] = entry;
    }
  }

  @override
  void recordInsertion(K key) {
    // 插入条目时，将其添加到最近使用位置
    _accessOrder[key] = CacheEntry(null); // 占位符
  }

  @override
  K? evict(LinkedHashMap<K, CacheEntry> cacheMap) {
    // 移除最久未访问的条目（队列开头）
    if (_accessOrder.isNotEmpty) {
      final keyToEvict = _accessOrder.keys.first;
      _accessOrder.remove(keyToEvict);
      return keyToEvict;
    }
    return null;
  }
}