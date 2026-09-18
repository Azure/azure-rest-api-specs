import { describe, expect, it, vi } from "vitest";
import { parseYaml } from "../src/yaml.ts";

describe("parseYaml", () => {
  it("preserves core scalars, timestamps, and string keys such as on", () => {
    expect(
      parseYaml(`
on: [pull_request]
date: 2026-09-18
quoted-date: "2026-09-18"
enabled: true
count: 42
yes-value: yes
empty:
`),
    ).toEqual({
      on: ["pull_request"],
      date: new Date("2026-09-18"),
      "quoted-date": "2026-09-18",
      enabled: true,
      count: 42,
      "yes-value": "yes",
      empty: null,
    });
  });

  it("preserves failsafe strings and distinguishes omitted from quoted empty values", () => {
    expect(
      parseYaml(
        `
date: 2026-09-18
enabled: true
count: 42
null-value: null
tilde: ~
empty:
quoted-empty: ""
explicit-empty: !!str
items: [42, true, null, ""]
`,
        { schema: "failsafe" },
      ),
    ).toEqual({
      date: "2026-09-18",
      enabled: "true",
      count: "42",
      "null-value": "null",
      tilde: "~",
      empty: null,
      "quoted-empty": "",
      "explicit-empty": "",
      items: ["42", "true", "null", ""],
    });
  });

  const merged = `
defaults: &defaults
  enabled: true
  count: 42
config:
  <<: *defaults
  count: 7
`;

  it("supports merge keys and explicit overrides in the core schema", () => {
    expect(parseYaml(merged)).toEqual({
      defaults: { enabled: true, count: 42 },
      config: { enabled: true, count: 7 },
    });
  });

  it("does not interpret merge keys in the failsafe schema", () => {
    expect(parseYaml(merged, { schema: "failsafe" })).toEqual({
      defaults: { enabled: "true", count: "42" },
      config: { "<<": { enabled: "true", count: "42" }, count: "7" },
    });
  });

  it.each(["core", "failsafe"] as const)("handles empty input with %s schema", (schema) => {
    expect(parseYaml("", { schema })).toBeUndefined();
    expect(parseYaml("# only a comment\n", { schema })).toBeUndefined();
    expect(parseYaml('""', { schema })).toBe("");
    expect(parseYaml("---\n", { schema })).toBeNull();
  });

  it("preserves an explicit null in the core schema", () => {
    expect(parseYaml("null")).toBeNull();
  });

  it.each(["core", "failsafe"] as const)("rejects invalid %s documents", (schema) => {
    for (const content of [
      "values: [",
      "key: first\nkey: second",
      "value: *undefined",
      "value: !unknown text",
      "---\nfirst: value\n---\nsecond: value",
    ]) {
      expect(() => parseYaml(content, { schema })).toThrow();
    }
  });

  it.each(["!!bool true", "!!int 42", "!!timestamp 2026-09-18"])(
    "rejects non-failsafe explicit tags: %s",
    (value) => {
      expect(() => parseYaml(`value: ${value}`, { schema: "failsafe" })).toThrow(/Unresolved tag/);
    },
  );

  it("reports non-fatal parser warnings", () => {
    const warning = vi.spyOn(process, "emitWarning").mockImplementation(() => {});
    try {
      expect(parseYaml("%YAML 1.3\n---\nvalue: text")).toEqual({ value: "text" });
      expect(warning).toHaveBeenCalledOnce();
    } finally {
      warning.mockRestore();
    }
  });
});
