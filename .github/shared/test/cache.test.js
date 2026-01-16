import { describe, expect, it } from "vitest";
import { MapCache, MapCache2, ObjectCache, ObjectCache2 } from "../src/cache.js";

describe("MemoryCache", () => {
  it("createAndGetSync", () => {
    /** @type {MapCache<number, string>} */
    const cache = new MapCache();

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
    /** @type {MapCache<number, Promise<string>>} */
    const cache = new MapCache();

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

describe("MemoryCache2", () => {
  it("createAndGetSync", () => {
    /** @type {MapCache2<number, number, string>} */
    const cache = new MapCache2();

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
    /** @type {MapCache2<number, number, Promise<string>>} */
    const cache = new MapCache2();

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
    /** @type {MapCache2<string, string, string>} */
    const cache = new MapCache2();

    const getOrCreateFooBar = () => cache.getOrCreate(42, 7, () => "42-7");
    const getOrCreateBarFoo = () => cache.getOrCreate(7, 42, () => "7-42");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("42-7");
      expect(getOrCreateBarFoo()).toEqual("7-42");
    }
  });
});

describe("ObjectCache", () => {
  it("createAndGetSync", () => {
    /** @type {ObjectCache<string>} */
    const cache = new ObjectCache();

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
    /** @type {ObjectCache<Promise<string>>} */
    const cache = new ObjectCache();

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

describe("ObjectCache2", () => {
  it("createAndGetSync", () => {
    /** @type {ObjectCache2<string>} */
    const cache = new ObjectCache2();

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
    /** @type {ObjectCache2<Promise<string>>} */
    const cache = new ObjectCache2();

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
    /** @type {ObjectCache2<string>} */
    const cache = new ObjectCache2();

    const getOrCreateFooBar = () => cache.getOrCreate("foo", "bar", () => "foo-bar");
    const getOrCreateBarFoo = () => cache.getOrCreate("bar", "foo", () => "bar-foo");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("foo-bar");
      expect(getOrCreateBarFoo()).toEqual("bar-foo");
    }
  });
});
