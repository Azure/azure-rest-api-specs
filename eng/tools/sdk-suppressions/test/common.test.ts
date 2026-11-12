import { afterEach, expect, it, vi } from "vitest";
import { parseYamlContent } from "../src/common.ts";
import { validateSdkSuppressionsFile } from "../src/sdkSuppressions.ts";

afterEach(() => {
  vi.restoreAllMocks();
});

it("passes parsed suppressions to schema validation", () => {
  const parsed = parseYamlContent("suppressions: {}", "sdk-suppressions.yaml");

  expect(parsed).toEqual({
    result: { suppressions: {} },
    message: "The file has been successfully parsed.",
  });
  expect(validateSdkSuppressionsFile(parsed.result).result).toBe(true);
});

it.each(["", "# no suppressions", "null", "false", "0"])(
  "preserves empty-content handling for %j",
  (content) => {
    const log = vi.spyOn(console, "info").mockImplementation(() => {});
    const parsed = parseYamlContent(content, "sdk-suppressions.yaml");

    expect(parsed).toEqual({
      result: null,
      message:
        "The file in the sdk-suppressions.yaml has been successfully parsed, but it is an empty file.",
    });
    expect(log).toHaveBeenCalledWith(parsed.message);
  },
);

it.each([
  { content: "true", result: true },
  { content: "42", result: 42 },
  { content: "text", result: "text" },
  { content: "- item", result: ["item"] },
])("leaves schema validation to reject $content", ({ content, result }) => {
  vi.spyOn(console, "error").mockImplementation(() => {});
  const parsed = parseYamlContent(content, "sdk-suppressions.yaml");

  expect(parsed.result).toEqual(result);
  expect(validateSdkSuppressionsFile(parsed.result)).toEqual({
    result: false,
    message: "This suppression file is a valid yaml but the schema is wrong: data must be object",
  });
});

it("reports parse failures without treating them as empty files", () => {
  const log = vi.spyOn(console, "error").mockImplementation(() => {});
  const parsed = parseYamlContent("suppressions: [", "sdk-suppressions.yaml");

  expect(parsed.result).toBeUndefined();
  expect(parsed.message).toContain(
    "The file parsing failed in the sdk-suppressions.yaml. Details: YAMLParseError:",
  );
  expect(log).toHaveBeenCalledWith(parsed.message);
});
