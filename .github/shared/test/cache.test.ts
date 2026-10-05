import { describe, expect, it } from "vitest";
import { KeyedCache, KeyedPairCache } from "../src/cache.ts";

describe("KeyedCache", () => {
  it("createAndGetSync", () => {
    const cache: KeyedCache<number, string> = new KeyedCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate(42, () => {
        createdCount++;
        return "foo";
      });

    for (let i = 0; i < 3; i++) {
      expect(getOrCreate()).toEqual("foo");
    }
    expect(createdCount).toEqual(1);
  });

  it("createAndGetAsync", async () => {
    const cache: KeyedCache<number, Promise<string>> = new KeyedCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate(42, async () => {
        await Promise.resolve();
        createdCount++;
        return "foo";
      });

    for (let i = 0; i < 3; i++) {
      await expect(getOrCreate()).resolves.toEqual("foo");
    }
    expect(createdCount).toEqual(1);
  });
});

describe("KeyedPairCache", () => {
  it("createAndGetSync", () => {
    const cache: KeyedPairCache<number, number, string> = new KeyedPairCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate(42, 7, () => {
        createdCount++;
        return "foo";
      });

    for (let i = 0; i < 3; i++) {
      expect(getOrCreate()).toEqual("foo");
    }
    expect(createdCount).toEqual(1);
  });

  it("createAndGetAsync", async () => {
    const cache: KeyedPairCache<number, number, Promise<string>> = new KeyedPairCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate(42, 7, async () => {
        await Promise.resolve();
        createdCount++;
        return "foo";
      });

    for (let i = 0; i < 3; i++) {
      await expect(getOrCreate()).resolves.toEqual("foo");
    }
    expect(createdCount).toEqual(1);
  });

  it("keys are ordered", () => {
    const cache: KeyedPairCache<number, number, string> = new KeyedPairCache();

    const getOrCreateFooBar = () => cache.getOrCreate(42, 7, () => "42-7");
    const getOrCreateBarFoo = () => cache.getOrCreate(7, 42, () => "7-42");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("42-7");
      expect(getOrCreateBarFoo()).toEqual("7-42");
    }
  });
});
