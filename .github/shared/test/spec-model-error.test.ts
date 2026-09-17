import { describe, expect, it } from "vitest";
import { SpecModelError } from "../src/spec-model-error.ts";

describe("SpecModelError", () => {
  it("builds full message from message and options", () => {
    const message = "test message";
    const options: NonNullable<ConstructorParameters<typeof SpecModelError>[1]> = {};

    let error = new SpecModelError(message, options);
    expect(error).toMatchInlineSnapshot(`[SpecModelError: test message]`);
    expect(error.message).toEqual(message);

    options.source = "/test/source.json";
    error = new SpecModelError(message, options);
    expect(error).toMatchInlineSnapshot(`
      [SpecModelError: test message
        Problem File: /test/source.json]
    `);
    expect(error.source).toEqual("/test/source.json");

    options.readme = "/test/readme.md";
    error = new SpecModelError(message, options);
    expect(error).toMatchInlineSnapshot(`
      [SpecModelError: test message
        Problem File: /test/source.json
        Readme: /test/readme.md]
    `);
    expect(error.readme).toEqual("/test/readme.md");

    options.tag = "2025-01-01";
    error = new SpecModelError(message, options);
    expect(error).toMatchInlineSnapshot(`
      [SpecModelError: test message
        Problem File: /test/source.json
        Readme: /test/readme.md
        Tag: 2025-01-01]
    `);
    expect(error.tag).toEqual("2025-01-01");

    options.cause = new TypeError("inner error");
    error = new SpecModelError(message, options);
    expect(error).toMatchInlineSnapshot(`
      [SpecModelError: test message
        Problem File: /test/source.json
        Readme: /test/readme.md
        Tag: 2025-01-01
        Cause: TypeError: inner error]
    `);
    expect(error.cause).toEqual(options.cause);
  });
});
