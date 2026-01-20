import { describe, expect, it } from "vitest";
import { MemoryCache } from "../src/memory-cache.js";

describe("MemoryCache", () => {
  it("createAndGetSync", () => {
    /** @type {MemoryCache<string, string>} */
    const cache = new MemoryCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate("foo", () => {
        createdCount++;
        return "bar";
      });

    expect(getOrCreate()).toEqual("bar");
    expect(getOrCreate()).toEqual("bar");
    expect(getOrCreate()).toEqual("bar");
    expect(createdCount).toEqual(1);
  });

  it("createAndGetAsync", async () => {
    /** @type {MemoryCache<string, Promise<string>>} */
    const cache = new MemoryCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate("foo", async () => {
        await Promise.resolve();
        createdCount++;
        return "bar";
      });

    await expect(getOrCreate()).resolves.toEqual("bar");
    await expect(getOrCreate()).resolves.toEqual("bar");
    await expect(getOrCreate()).resolves.toEqual("bar");
    expect(createdCount).toEqual(1);
  });
});
