import { readFile } from "node:fs/promises";
import { describe, expect, it } from "vitest";
import { stringify } from "yaml";
import { DELETED_LABEL, parseLabelCatalog, planLabels } from "../src/label-catalog.ts";
import type { ExistingLabel, LabelCatalog, LabelDefinition } from "../src/label-catalog.ts";

const marker: LabelDefinition = {
  name: DELETED_LABEL,
  color: "123456",
  description: "A label was removed",
};
const bug: LabelDefinition = { name: "bug", color: "abcdef", description: "" };
const catalog: LabelCatalog = { unconfiguredLabels: "preserve", labels: [marker, bug] };
const existing = (label: LabelDefinition, id = 1): ExistingLabel => ({
  ...label,
  id,
  node_id: `label-${id}`,
});

describe("label catalog", () => {
  it("validates the checked-in migration catalog without enabling replacement", async () => {
    const parsed = parseLabelCatalog(
      await readFile(new URL("../../labels.yaml", import.meta.url), "utf8"),
    );
    expect(parsed.unconfiguredLabels).toBe("preserve");
    expect(parsed.labels).toContainEqual(expect.objectContaining({ name: DELETED_LABEL }));
    expect(parsed.labels).toContainEqual(
      expect.objectContaining({ name: "BreakingChange-Approved-Benign" }),
    );
  });

  it("rejects duplicate YAML keys rather than accepting the last value", () => {
    expect(() =>
      parseLabelCatalog("unconfiguredLabels: preserve\nunconfiguredLabels: replace\n"),
    ).toThrow("Invalid label YAML");
  });

  it.each([
    { ...catalog, unconfiguredLabels: undefined },
    { ...catalog, unconfiguredLabels: "delete" },
    { ...catalog, labels: [] },
    { ...catalog, labels: [bug] },
    { ...catalog, labels: [marker, bug, { ...bug, name: "BUG" }] },
    { ...catalog, labels: [marker, { ...bug, name: "" }] },
    { ...catalog, labels: [marker, { ...bug, name: "a".repeat(51) }] },
    { ...catalog, labels: [marker, { ...bug, color: "12345" }] },
    { ...catalog, labels: [marker, { ...bug, color: "#123456" }] },
    { ...catalog, labels: [marker, { ...bug, color: 123456 }] },
    { ...catalog, labels: [marker, { ...bug, description: "x".repeat(101) }] },
    { ...catalog, labels: [marker, { ...bug, summary: "unexpected property" }] },
  ])("rejects invalid definitions or policy: %j", (invalid) => {
    expect(() => parseLabelCatalog(stringify(invalid))).toThrow();
  });

  it("round-trips special characters and multiline descriptions", () => {
    const special = {
      ...catalog,
      labels: [
        marker,
        { name: 'a: "quote" / #tag', color: "001234", description: "first\nsecond" },
      ],
    };
    expect(parseLabelCatalog(stringify(special))).toEqual(special);
  });
});

describe("label planning", () => {
  it("reports creates, updates, and unknown labels without planning implicit deletion", () => {
    const oldBug = existing({ ...bug, color: "ffffff" });
    const unknown = existing({ ...bug, name: "unconfigured" }, 2);
    expect(planLabels(catalog, [oldBug, unknown])).toEqual({
      create: [marker],
      update: [{ before: oldBug, after: bug }],
      unconfigured: [unknown],
      unchanged: 0,
    });
  });

  it("normalizes GitHub name/color case and null descriptions without changing definitions", () => {
    const actual = { ...existing(bug), name: "BUG", color: "ABCDEF", description: null };
    expect(planLabels(catalog, [existing(marker, 2), actual])).toEqual({
      create: [],
      update: [],
      unconfigured: [],
      unchanged: 2,
    });
    expect(actual.description).toBeNull();
  });

  it("rejects an ambiguous live inventory", () => {
    expect(() =>
      planLabels(catalog, [existing(bug), existing({ ...bug, name: "BUG" }, 2)]),
    ).toThrow("duplicate label names");
  });

  it("produces the same ordered plan regardless of catalog and API order", () => {
    const other = existing({ ...bug, name: "other" }, 3);
    const another = existing({ ...bug, name: "another" }, 4);
    expect(planLabels(catalog, [other, another])).toEqual(
      planLabels({ ...catalog, labels: [...catalog.labels].reverse() }, [another, other]),
    );
  });
});
