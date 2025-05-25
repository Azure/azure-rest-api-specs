// @ts-check

import { describe, expect, it } from "vitest";
import { SpecModelError } from "../src/spec-model-error.js";

describe("SpecModelError", () => {
  it("toString`", () => {
    let error = new SpecModelError("test message");
    expect(error.toString()).toMatchInlineSnapshot(
      `"SpecModelError: test message"`,
    );

    error.source = "/test/source.json";
    expect(error.toString()).toMatchInlineSnapshot(`
      "SpecModelError: test message
      	Problem File: /test/source.json"
    `);

    error.readme = "/test/readme.md";
    expect(error.toString()).toMatchInlineSnapshot(`
      "SpecModelError: test message
      	Problem File: /test/source.json
      	Readme: /test/readme.md"
    `);

    error.tag = "2025-01-01";
    expect(error.toString()).toMatchInlineSnapshot(`
      "SpecModelError: test message
      	Problem File: /test/source.json
      	Readme: /test/readme.md
      	Tag: 2025-01-01"
    `);
  });
});
