
import 'dart:collection';

import 'base/cache_entry.dart';
import 'base/cache_eviction_policy.dart';
// FIFO策略实现
class FIFO<K> implements CacheEvictionPolicy<K> {
  final Queue<K> _fifoQueue = Queue();

  @override
  void recordAccess(K key) {
    // FIFO不关注访问顺序，无需更新
  }

  @override
  void recordInsertion(K key) {
    _fifoQueue.addLast(key);
  }

  @override
  K? evict(LinkedHashMap<K, CacheEntry> cacheMap) {
    if (_fifoQueue.isNotEmpty) {
      return _fifoQueue.removeFirst();
    }
    return null;
  }
}