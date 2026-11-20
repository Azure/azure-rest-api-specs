/**
 * Caches values in memory with a single key of any type.
 */
export class KeyedCache<K, V> {
  #map: Map<K, V> = new Map();

  /**
   * Returns cached value, initializing if necessary
   * @returns cached value
   * @example
   * const result = cache.getOrCreate(42, async () => await doWork(42));
   */
  getOrCreate(key: K, factory: () => V): V {
    let value = this.#map.get(key);

    if (value === undefined) {
      value = factory();
      this.#map.set(key, value);
    }

    return value;
  }
}

/**
 * Caches values in memory with an ordered pair of keys of any types.
 */
export class KeyedPairCache<K1, K2, V> {
  // Two-layer nested cache

  #cache1: KeyedCache<K1, KeyedCache<K2, V>> = new KeyedCache();

  /**
   * Returns cached value, initializing if necessary.
   * Keys are ordered, so (key1, key2) != (key2, key1).
   * @returns cached value
   * @example
   * const result = cache.getOrCreate(42, 7 async () => await doWork(42, 7));
   */
  getOrCreate(key1: K1, key2: K2, factory: () => V): V {
    // key1 => cache for the next layer
    const cache2 = this.#cache1.getOrCreate(key1, () => new KeyedCache());

    // key2 => final value
    return cache2.getOrCreate(key2, factory);
  }
}
