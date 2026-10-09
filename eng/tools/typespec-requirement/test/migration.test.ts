import { describe, expect, it, vi } from "vitest";
import { isTypeSpecGenerated } from "../src/migration.ts";

describe("TypeSpec-generated marker", () => {
  it.each([
    ['{"info":{"x-typespec-generated":[{"emitter":"@azure-tools/typespec-autorest"}]}}', true],
    ['{"info":{"x-typespec-generated":false}}', true],
    ['{"info":{"x-typespec-generated":null}}', false],
    ['{"info":null}', false],
    ['{"info":{}}', false],
    ["null", false],
    ["{}", false],
  ])("Recognizes the marker in %s", (content, expected) => {
    expect(isTypeSpecGenerated(content, "swagger.json", vi.fn())).toBe(expected);
  });

  it("Reports malformed JSON instead of using a marker found in invalid content", () => {
    const warning = vi.fn();
    expect(
      isTypeSpecGenerated('{"info":{"x-typespec-generated":true}', "broken.json", warning),
    ).toBe(false);
    expect(warning).toHaveBeenCalledWith(
      expect.stringContaining("OpenAPI 'broken.json' cannot be parsed"),
    );
  });
});
