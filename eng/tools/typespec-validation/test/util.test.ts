import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";
import process from "process";

describe("normalize", function () {
  it("should succeed if normalized . and normalized cwd matches", async function () {
    let host = new TsvTestHost();
    const dotResult = host.normalizePath(".");
    const cwdResult = host.normalizePath(process.cwd());
    assert(dotResult === cwdResult);
  });

  it("should succeed if /foo/bar/ is normalized", async function () {
    let host = new TsvTestHost();
    const result = host.normalizePath("/foo/bar/").replace(/^[a-zA-Z]:/g, "");
    assert(result === "/foo/bar");
  });

  it("should succeed if /foo/bar is normalized", async function () {
    let host = new TsvTestHost();
    const result = host.normalizePath("/foo/bar").replace(/^[a-zA-Z]:/g, "");
    assert(result === "/foo/bar");
  });
});
