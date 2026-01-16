/**
 * @template V
 */
export class StringKeyedMemoryCache {
  /** @type {Record<string, V>} */
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
  #map = Object.create(null);

  /**
   * Returns cached value, initializing if necessary
   *
   * @param {string} key
   * @param {() => V} factory
   * @returns {V} cached value
   *
   * @example
   * const text = cache.getOrCreate(path, async () => await readFile(path));
   */
  getOrCreate(key, factory) {
    let value = this.#map[key];

    if (value === undefined) {
      value = factory();
      this.#map[key] = value;
    }

    return value;
  }
}

/**
 * Caches values in memory with a single key.
 *
 * @template K, V
 */
export class MemoryCache {
  /** @type {Map<K, V>} */
  #map = new Map();

  /**
   * Returns cached value, initializing if necessary
   *
   * @param {K} key
   * @param {() => V} factory
   * @returns {V} cached value
   *
   * @example
   * const text = cache.getOrCreate(path, async () => await readFile(path));
   */
  getOrCreate(key, factory) {
    let value = this.#map.get(key);

    if (value === undefined) {
      value = factory();
      this.#map.set(key, value);
    }

    return value;
  }
}

/**
 * Caches values in memory with an ordered pair of keys.
 *
 * @template K1, K2, V
 */
export class MemoryCache2 {
  // Two-layer nested cache
  /** @type {MemoryCache<K1, MemoryCache<K2, V>>} */
  #cache1 = new MemoryCache();

  /**
   * Returns cached value, initializing if necessary.
   * Keys are ordered, meaning (key1, key2) != (key2, key1).
   *
   * @param {K1} key1
   * @param {K2} key2
   * @param {() => V} factory
   * @returns {V} cached value
   *
   * @example
   * const text = cache.getOrCreate(folder, file, async () => await readFile(resolve(folder, file)));
   */
  getOrCreate(key1, key2, factory) {
    // key1 => cache for the next layer
    const cache2 = this.#cache1.getOrCreate(key1, () => new MemoryCache());

    // key2 => final value
    return cache2.getOrCreate(key2, factory);
  }
}
