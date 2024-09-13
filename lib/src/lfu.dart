// LFU策略实现
import 'dart:collection';

import 'base/cache_entry.dart';
import 'base/cache_eviction_policy.dart';

class LFU<K> implements CacheEvictionPolicy<K> {
  final Map<K, int> _frequencyMap = {};

  @override
  void recordAccess(K key) {
    _frequencyMap[key] = (_frequencyMap[key] ?? 0) + 1;
  }

  @override
  void recordInsertion(K key) {
    _frequencyMap[key] = 1; // 初次插入频率为1
  }

  @override
  K? evict(LinkedHashMap<K, CacheEntry> cacheMap) {
    if (_frequencyMap.isNotEmpty) {
      // 移除访问频率最低的条目
      final keyToEvict = _frequencyMap.entries.reduce((a, b) => a.value < b.value ? a : b).key;
      _frequencyMap.remove(keyToEvict);
      return keyToEvict;
    }
    return null;
  }
}