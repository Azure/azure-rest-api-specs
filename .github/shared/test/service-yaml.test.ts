import { describe, expect, it } from "vitest";
import { parseServiceYaml } from "../src/service-yaml.ts";

describe("service manifest parsing", () => {
  it("keeps extra fields while validating the version list", () => {
    const result = parseServiceYaml(
      "name: Foo\nversions:\n  - version: 2026-01-01\n    source: typespec\n    swagger-files: [foo.json]\n",
    );
    expect(result).toMatchObject({
      success: true,
      value: {
        name: "Foo",
        versions: [{ version: "2026-01-01", source: "typespec", "swagger-files": ["foo.json"] }],
      },
    });
    expect(parseServiceYaml("versions:\n  - version: old\n")).toMatchObject({ success: true });
  });

  it.each([
    ["versions: [", "not valid YAML"],
    ["versions: false", "versions:"],
    ["null", "<root>:"],
    ["versions:\n  - source: swagger", "versions.0.version:"],
  ])("reports actionable errors for %s", (source, expected) => {
    const result = parseServiceYaml(source);
    expect(result.success).toBe(false);
    if (result.success) throw new Error("Expected malformed manifest");
    expect(result.error).toContain(expected);
  });
});
