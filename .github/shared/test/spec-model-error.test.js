// @ts-check

import { describe, expect, it } from "vitest";
import { SpecModelError } from "../src/spec-model-error.js";

describe("SpecModelError", () => {
  it("builds full message from message and options", () => {
    let message = "test message";
    let options = {};

    expect(new SpecModelError(message, options)).toMatchInlineSnapshot(
      `[SpecModelError: test message]`,
    );

    options.source = "/test/source.json";
    expect(new SpecModelError(message, options)).toMatchInlineSnapshot(`
      [SpecModelError: test message
      	Problem File: /test/source.json]
    `);

    options.readme = "/test/readme.md";
    expect(new SpecModelError(message, options)).toMatchInlineSnapshot(`
      [SpecModelError: test message
      	Problem File: /test/source.json
      	Readme: /test/readme.md]
    `);

    options.tag = "2025-01-01";
    expect(new SpecModelError(message, options)).toMatchInlineSnapshot(`
      [SpecModelError: test message
      	Problem File: /test/source.json
      	Readme: /test/readme.md
      	Tag: 2025-01-01]
    `);

    options.cause = new TypeError("inner error");
    expect(new SpecModelError(message, options)).toMatchInlineSnapshot(`
      [SpecModelError: test message
      	Problem File: /test/source.json
      	Readme: /test/readme.md
      	Tag: 2025-01-01
      	Cause: TypeError: inner error]
    `);
  });
});
