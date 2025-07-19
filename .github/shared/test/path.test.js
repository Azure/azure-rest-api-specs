// @ts-check

import { tmpdir } from "os";
import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { relativeCwd, resolveCwd } from "../src/path.js";

describe("relativeCwd", () => {
  it("relative to current dir by default", () => {
    const abs = resolve("foo.json");
    expect(relativeCwd(abs)).toEqual("foo.json");
  });

  it("relative to options.cwd if set", () => {
    const abs = resolve(tmpdir(), "foo.json");
    expect(relativeCwd(abs, { cwd: tmpdir() })).toEqual("foo.json");
  });
});

describe("resolveCwd", () => {
  it("resolves against current dir by default", () => {
    expect(resolveCwd("foo.json")).toEqual(resolve("foo.json"));
  });

  it("resolves against options.cwd if set", () => {
    expect(resolveCwd("foo.json", { cwd: tmpdir() })).toEqual(resolve(tmpdir(), "foo.json"));
  });
});
