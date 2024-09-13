
import 'dart:collection';

import 'cache_entry.dart';
// 缓存策略接口
abstract class CacheEvictionPolicy<K> {
  void recordAccess(K key);
  void recordInsertion(K key);
  K? evict(LinkedHashMap<K, CacheEntry> cacheMap);
}
