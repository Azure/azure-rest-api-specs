import { format } from "prettier";
import { describe, expect, it } from "vitest";
import swaggerPlugin from "./prettier-swagger-plugin.js";

const options = {
  parser: "json-swagger",
  plugins: [swaggerPlugin],
  printWidth: 20,
};

describe("Swagger JSON formatter", () => {
  it.each([
    [
      "quoted description",
      { description: 'The secret type is "Opaque" or "kubernetes.io/tls".' },
    ],
    ["quoted property name", { 'a "quoted" key': "value" }],
    [
      "mixed quotes and escapes",
      { description: 'It\'s "quoted" with a \\ and a\nnewline.' },
    ],
    [
      "nested values",
      { values: [true, false, null, { unicode: "\u2028\u2029" }] },
    ],
  ])("preserves valid JSON and is idempotent for %s", async (_name, value) => {
    const output = await format(JSON.stringify(value), options);

    expect(JSON.parse(output)).toEqual(value);
    expect(await format(output, options)).toBe(output);
  });

  it("preserves numeric literals without rounding or removing trailing zeros", async () => {
    const input = '{"values":[100.00,12345678901234567890,-0,1.2300e+5]}';
    const output = await format(input, options);

    expect(JSON.parse(output)).toEqual(JSON.parse(input));
    for (const literal of [
      "100.00",
      "12345678901234567890",
      "-0",
      "1.2300e+5",
    ]) {
      expect(output).toContain(literal);
    }
    expect(await format(output, options)).toBe(output);
  });
});
