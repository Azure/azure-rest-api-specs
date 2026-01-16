import { describe, expect, it } from "vitest";
import {
  MemoryCache,
  MemoryCache2,
  StringKeyedMemoryCache,
  StringKeyedMemoryCache2,
} from "../src/memory-cache.js";

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

    for (let i = 0; i < 3; i++) {
      expect(getOrCreate()).toEqual("bar");
    }
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

    for (let i = 0; i < 3; i++) {
      await expect(getOrCreate()).resolves.toEqual("bar");
    }
    expect(createdCount).toEqual(1);
  });
});

describe("MemoryCache2", () => {
  it("createAndGetSync", () => {
    /** @type {MemoryCache2<string, string, string>} */
    const cache = new MemoryCache2();

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
    /** @type {MemoryCache2<string, string, Promise<string>>} */
    const cache = new MemoryCache2();

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
    /** @type {MemoryCache2<string, string, string>} */
    const cache = new MemoryCache2();

    const getOrCreateFooBar = () => cache.getOrCreate("foo", "bar", () => "foo-bar");
    const getOrCreateBarFoo = () => cache.getOrCreate("bar", "foo", () => "bar-foo");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("foo-bar");
      expect(getOrCreateBarFoo()).toEqual("bar-foo");
    }
  });
});

describe("StringKeyedMemoryCache", () => {
  it("createAndGetSync", () => {
    /** @type {StringKeyedMemoryCache<string>} */
    const cache = new StringKeyedMemoryCache();

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
    /** @type {StringKeyedMemoryCache<Promise<string>>} */
    const cache = new StringKeyedMemoryCache();

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

describe("StringKeyedMemoryCache2", () => {
  it("createAndGetSync", () => {
    /** @type {StringKeyedMemoryCache2<string>} */
    const cache = new StringKeyedMemoryCache2();

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
    /** @type {StringKeyedMemoryCache2<Promise<string>>} */
    const cache = new StringKeyedMemoryCache2();

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
    /** @type {StringKeyedMemoryCache2<string>} */
    const cache = new StringKeyedMemoryCache2();

    const getOrCreateFooBar = () => cache.getOrCreate("foo", "bar", () => "foo-bar");
    const getOrCreateBarFoo = () => cache.getOrCreate("bar", "foo", () => "bar-foo");

    for (let i = 0; i < 3; i++) {
      expect(getOrCreateFooBar()).toEqual("foo-bar");
      expect(getOrCreateBarFoo()).toEqual("bar-foo");
    }
  });
});
