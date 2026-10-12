import { fileURLToPath } from "node:url";
import { format, resolveConfig } from "prettier";
import { describe, expect, it } from "vitest";

const filepath = fileURLToPath(
  new URL("../../../specification/example/stable/swagger.json", import.meta.url),
);

async function formatSwagger(source: string) {
  const options = await resolveConfig(filepath);
  if (options?.parser !== "json-stringify") {
    throw new Error("Expected the repository configuration to use the json-stringify parser");
  }
  return format(source, { ...options, filepath });
}

describe("Swagger Prettier formatting", () => {
  it.each([
    { description: 'Logical zone for Elastic San resource; example: ["1"].' },
    {
      'quoted "key"': "Both 'single' and \"double\" quotes",
      nested: { values: ['"quoted"', "back\\slash", "line\nbreak", "tab\there"] },
    },
  ])("preserves valid JSON quoting and string values: %j", async (value) => {
    const source = `${JSON.stringify(value, null, 2)}\n`;
    const output = await formatSwagger(source);
    expect(JSON.parse(output)).toEqual(value);
    expect(output).toBe(source);
    expect(await formatSwagger(output)).toBe(output);
  });

  it.each([
    "100.00",
    "-100.00",
    "1e+03",
    "1E-03",
    "9007199254740993",
    "-9223372036854775809",
    "-0",
    "-0.0",
    "1e9999",
    "1e-9999",
    "0.12345678901234567890123456789",
  ])("preserves numeric literal %s", async (literal) => {
    const output = await formatSwagger(`{"value":${literal}}`);
    expect(output).toBe(`{\n  "value": ${literal}\n}\n`);
    expect(() => {
      JSON.parse(output);
    }).not.toThrow();
    expect(await formatSwagger(output)).toBe(output);
  });
});
