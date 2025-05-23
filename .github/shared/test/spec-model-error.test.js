// @ts-check

import { describe, expect, it } from "vitest";
import { SpecModelError } from "../src/spec-model-error.js";

describe("SpecModelError", () => {
  it("can be turned to a string", () => {
    const error = new SpecModelError("message", {
      readme: "readme",
      tag: "tag",
      source: "source",
    });
    expect(error.toString()).toMatchInlineSnapshot(`
      "SpecModelError: message
      	Problem File: source
      	Readme: readme
      	Tag: tag"
    `);
  });
});
