// @ts-check

import { describe, expect, it } from "vitest";
import { parse, stringify } from "../src/ndjson.js";

describe("ndjson", () => {
  it("primitives, arrays, objects", () => {
    // Cannot round-trip "undefined", but neither can JSON.parse()/JSON.stringify()
    let values = [null, true, 1, "foo", [false, 2, "bar"], { a: true, b: 3, c: "qux" }];

    const stringifiedValues = stringify(values);
    expect(stringifiedValues).toMatchInlineSnapshot(`
      "null
      true
      1
      "foo"
      [false,2,"bar"]
      {"a":true,"b":3,"c":"qux"}"
    `);

    const parsedValues = parse(stringifiedValues);
    expect(parsedValues).toEqual(values);
  });

  it("empty array", () => {
    let values = [];

    const stringifiedValues = stringify(values);
    expect(stringifiedValues).toEqual("");

    const parsedValues = parse(stringifiedValues);
    expect(parsedValues).toEqual(values);
  });
});
