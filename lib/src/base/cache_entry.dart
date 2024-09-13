// 缓存条目类
class CacheEntry<T> {
  final T? value;
  final DateTime timestamp;

  CacheEntry(this.value) : timestamp = DateTime.now();
}