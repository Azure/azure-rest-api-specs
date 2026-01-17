import { describe, expect, it } from "vitest";
import { KeyedCache, KeyedPairCache, StringKeyCache, StringKeyPairCache } from "../src/cache.js";

describe("KeyedCache", () => {
  it("createAndGetSync", () => {
    /** @type {KeyedCache<number, string>} */
    const cache = new KeyedCache();

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
    /** @type {KeyedCache<number, Promise<string>>} */
    const cache = new KeyedCache();

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
    /** @type {KeyedPairCache<number, number, string>} */
    const cache = new KeyedPairCache();

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
    /** @type {KeyedPairCache<number, number, Promise<string>>} */
    const cache = new KeyedPairCache();

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
    /** @type {KeyedPairCache<string, string, string>} */
    const cache = new KeyedPairCache();

    const getOrCreateFooBar = () => cache.getOrCreate(42, 7, () => "42-7");
    const getOrCreateBarFoo = () => cache.getOrCreate(7, 42, () => "7-42");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("42-7");
      expect(getOrCreateBarFoo()).toEqual("7-42");
    }
  });
});

describe("StringKeyCache", () => {
  it("createAndGetSync", () => {
    /** @type {StringKeyCache<string>} */
    const cache = new StringKeyCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate("foo", () => {
        createdCount++;
        return "bar";
      });

    for (let i = 0; i < 3; i++) {
      expect(getOrCreate()).toEqual("bar");
    }
    expect(createdCount).toEqual(1);
  });

  it("createAndGetAsync", async () => {
    /** @type {StringKeyCache<Promise<string>>} */
    const cache = new StringKeyCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate("foo", async () => {
        await Promise.resolve();
        createdCount++;
        return "bar";
      });

    for (let i = 0; i < 3; i++) {
      await expect(getOrCreate()).resolves.toEqual("bar");
    }
    expect(createdCount).toEqual(1);
  });
});

describe("StringKeyPairCache", () => {
  it("createAndGetSync", () => {
    /** @type {StringKeyPairCache<string>} */
    const cache = new StringKeyPairCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate("foo", "bar", () => {
        createdCount++;
        return "baz";
      });

    for (let i = 0; i < 3; i++) {
      expect(getOrCreate()).toEqual("baz");
    }
    expect(createdCount).toEqual(1);
  });

  it("createAndGetAsync", async () => {
    /** @type {StringKeyPairCache<Promise<string>>} */
    const cache = new StringKeyPairCache();

    let createdCount = 0;
    const getOrCreate = () =>
      cache.getOrCreate("foo", "bar", async () => {
        await Promise.resolve();
        createdCount++;
        return "baz";
      });

    for (let i = 0; i < 3; i++) {
      await expect(getOrCreate()).resolves.toEqual("baz");
    }
    expect(createdCount).toEqual(1);
  });

  it("keys are ordered", () => {
    /** @type {StringKeyPairCache<string>} */
    const cache = new StringKeyPairCache();

    const getOrCreateFooBar = () => cache.getOrCreate("foo", "bar", () => "foo-bar");
    const getOrCreateBarFoo = () => cache.getOrCreate("bar", "foo", () => "bar-foo");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("foo-bar");
      expect(getOrCreateBarFoo()).toEqual("bar-foo");
    }
  });
});
