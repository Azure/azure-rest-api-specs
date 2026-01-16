/**
 * Caches values in memory with a single key of any type.
 *
 * `ObjectCache` is faster for string keys.
 *
 * @template K, V
 */
export class MapCache {
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
   * const result = cache.getOrCreate(42, async () => await doWork(42));
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
 * Caches values in memory with an ordered pair of keys of any types.
 *
 * `ObjectCache2` is faster for string keys.
 *
 * @template K1, K2, V
 */
export class MapCache2 {
  // Two-layer nested cache
  /** @type {MapCache<K1, MapCache<K2, V>>} */
  #cache1 = new MapCache();

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
   * const result = cache.getOrCreate(42, 7 async () => await doWork(42, 7));
   */
  getOrCreate(key1, key2, factory) {
    // key1 => cache for the next layer
    const cache2 = this.#cache1.getOrCreate(key1, () => new MapCache());

    // key2 => final value
    return cache2.getOrCreate(key2, factory);
  }
}

/**
 * Caches values in memory with a single string key.
 *
 * `MapCache` is slower but supports keys of any type.
 *
 * @template V
 */
export class ObjectCache {
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
 * Caches values in memory with an ordered pair of string keys.
 *
 * `MapCache2` is slower but supports keys of any type.
 *
 * @template V
 */
export class ObjectCache2 {
  // Two-layer nested cache
  /** @type {ObjectCache<ObjectCache<V>>} */
  #cache1 = new ObjectCache();

  /**
   * Returns cached value, initializing if necessary.
   * Keys are ordered, meaning (key1, key2) != (key2, key1).
   *
   * @param {string} key1
   * @param {string} key2
   * @param {() => V} factory
   * @returns {V} cached value
   *
   * @example
   * const text = cache.getOrCreate(folder, file, async () => await readFile(resolve(folder, file)));
   */
  getOrCreate(key1, key2, factory) {
    // key1 => cache for the next layer
    const cache2 = this.#cache1.getOrCreate(key1, () => new ObjectCache());

    // key2 => final value
    return cache2.getOrCreate(key2, factory);
  }
}
