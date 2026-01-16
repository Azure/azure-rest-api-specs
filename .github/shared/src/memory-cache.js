/**
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
