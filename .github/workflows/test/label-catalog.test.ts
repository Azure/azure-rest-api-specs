import { describe, expect, it } from "vitest";
import { stringify } from "yaml";
import {
  ARCHIVE_DESCRIPTION,
  ARCHIVE_PREFIX,
  existingLabelSchema,
  labelDefinitionSchema,
  parseLabelCatalog,
  planLabels,
} from "../src/label-catalog.ts";
import type { ExistingLabel, LabelCatalog, LabelDefinition } from "../src/label-catalog.ts";

const canonical: LabelDefinition = {
  name: "canonical",
  color: "123456",
  description: "A label was removed",
};
const bug: LabelDefinition = { name: "bug", color: "abcdef", description: "" };
const catalog: LabelCatalog = { unconfiguredLabels: "preserve", labels: [canonical, bug] };
const existing = (label: LabelDefinition, id = 1): ExistingLabel => ({
  ...label,
  id,
  node_id: `label-${id}`,
  archived_at: null,
});

describe("label catalog", () => {
  it("rejects duplicate YAML keys rather than accepting the last value", () => {
    expect(() =>
      parseLabelCatalog("unconfiguredLabels: preserve\nunconfiguredLabels: archive\n"),
    ).toThrow("Invalid label YAML");
  });

  it.each([
    { ...catalog, unconfiguredLabels: undefined },
    { ...catalog, unconfiguredLabels: "delete" },
    { ...catalog, unconfiguredLabels: "replace" },
    { ...catalog, labels: [] },
    { ...catalog, labels: [canonical, bug, { ...bug, name: "BUG" }] },
    { ...catalog, labels: [canonical, { ...bug, name: "" }] },
    { ...catalog, labels: [canonical, { ...bug, name: "Archived: bug" }] },
    { ...catalog, labels: [canonical, { ...bug, name: "a".repeat(51) }] },
    { ...catalog, labels: [canonical, { ...bug, color: "12345" }] },
    { ...catalog, labels: [canonical, { ...bug, color: "#123456" }] },
    { ...catalog, labels: [canonical, { ...bug, color: 123456 }] },
    { ...catalog, labels: [canonical, { ...bug, description: "x".repeat(101) }] },
    { ...catalog, labels: [canonical, { ...bug, summary: "unexpected property" }] },
  ])("rejects invalid definitions or policy: %j", (invalid) => {
    expect(() => parseLabelCatalog(stringify(invalid))).toThrow();
  });

  it("round-trips special characters and multiline descriptions", () => {
    const special = {
      ...catalog,
      labels: [
        canonical,
        { name: 'a: "quote" / #tag', color: "001234", description: "first\nsecond" },
      ],
    };
    expect(parseLabelCatalog(stringify(special))).toEqual(special);
  });

  it("does not require a generic deleted-label marker", () => {
    expect(
      parseLabelCatalog(stringify({ unconfiguredLabels: "archive", labels: [bug] })).labels,
    ).toEqual([bug]);
  });
  it.each(
    [
      [{ ...bug, aliases: ["BUG"] }],
      [{ ...bug, aliases: ["old", "OLD"] }],
      [{ ...bug, aliases: ["archived: old"] }],
      [
        { ...bug, aliases: ["old"] },
        { ...canonical, aliases: ["OLD"] },
      ],
      [bug, { ...canonical, aliases: ["bug"] }],
    ].map((labels) => ({ labels })),
  )("rejects ambiguous or configured aliases", ({ labels }) => {
    expect(() => parseLabelCatalog(stringify({ unconfiguredLabels: "archive", labels }))).toThrow();
  });
});

describe("alias migration planning", () => {
  const config: LabelCatalog = {
    unconfiguredLabels: "archive",
    labels: [{ ...bug, aliases: ["old"] }],
  };
  it("plans migration to the canonical label before archiving an active alias", () => {
    const before = existing({ ...bug, name: "old" });
    const plan = planLabels(config, [before]);
    expect(plan.migrate).toEqual([{ before, target: bug.name }]);
    expect(plan.archive).toEqual([{ before, name: "archived: old" }]);
    expect(plan.delete).toEqual([]);
  });
  it("recognizes aliases already renamed by the archive lifecycle", () => {
    const before = {
      ...existing({ ...bug, name: "archived: old", description: ARCHIVE_DESCRIPTION }),
      archived_at: "2000-01-01T00:00:00Z",
    };
    const plan = planLabels(config, [before]);
    expect(plan.migrate).toEqual([{ before, target: bug.name }]);
    expect(plan.delete).toEqual([before]);
  });
  it("does not migrate in preserve mode", () => {
    const plan = planLabels({ ...config, unconfiguredLabels: "preserve" }, [
      existing({ ...bug, name: "old" }),
    ]);
    expect(plan.migrate).toEqual([]);
  });
});

describe("label planning", () => {
  it("reports creates, updates, and unknown labels without planning implicit deletion", () => {
    const oldBug = existing({ ...bug, color: "ffffff" });
    const unknown = existing({ ...bug, name: "unconfigured" }, 2);
    expect(planLabels(catalog, [oldBug, unknown])).toEqual({
      create: [canonical],
      update: [{ before: oldBug, after: bug }],
      archive: [],
      delete: [],
      migrate: [],
      unconfigured: [unknown],
      unchanged: 0,
    });
  });

  it("normalizes GitHub name/color case and null descriptions without changing definitions", () => {
    const actual = { ...existing(bug), name: "BUG", color: "ABCDEF", description: null };
    expect(planLabels(catalog, [existing(canonical, 2), actual])).toEqual({
      create: [],
      update: [],
      archive: [],
      delete: [],
      migrate: [],
      unconfigured: [],
      unchanged: 2,
    });
    expect(actual.description).toBeNull();
  });

  describe("archive lifecycle planning", () => {
    const archiveCatalog: LabelCatalog = { ...catalog, unconfiguredLabels: "archive" };
    const now = new Date("2026-10-15T00:00:00.000Z");
    const archived: ExistingLabel = {
      ...existing({ ...bug, name: "archived: retired" }, 3),
      description: ARCHIVE_DESCRIPTION,
      archived_at: "2026-10-01T00:00:00.000Z",
    };

    it("archives new unconfigured labels without deleting them or changing assignments", () => {
      const active = {
        ...archived,
        name: "retired",
        archived_at: null,
        description: "Original description",
      };
      const plan = planLabels(archiveCatalog, [active], now);
      expect(plan.archive).toEqual([{ before: active, name: "archived: retired" }]);
      expect(plan.delete).toEqual([]);
    });

    it.each([
      ["2026-10-01T00:00:00.001Z", false],
      ["2026-10-01T00:00:00.000Z", true],
      ["2026-09-30T23:59:59.999Z", true],
      ["2026-10-16T00:00:00.000Z", false],
    ])("deletes only after 14 full days (archived at %s)", (archived_at, expired) => {
      const label = { ...archived, archived_at };
      const plan = planLabels(archiveCatalog, [label], now);
      expect(plan.archive).toEqual([]);
      expect(plan.delete).toEqual(expired ? [label] : []);
    });

    it.each([null, "", "Manually archived", `${ARCHIVE_DESCRIPTION} `])(
      "leaves already archived labels without our exact warning alone: %s",
      (description) => {
        const plan = planLabels(archiveCatalog, [{ ...archived, description }], now);
        expect(plan.archive).toEqual([]);
        expect(plan.delete).toEqual([]);
      },
    );

    it("restores configured labels even if their metadata already matches", () => {
      const label = { ...existing(bug), archived_at: archived.archived_at };
      const plan = planLabels(archiveCatalog, [label], now);
      expect(plan.update).toEqual([{ before: label, after: bug }]);
      expect(plan.archive).toEqual([]);
      expect(plan.delete).toEqual([]);
    });

    it("preserves even expired managed archives during migration", () => {
      const plan = planLabels(catalog, [archived], now);
      expect(plan.archive).toEqual([]);
      expect(plan.delete).toEqual([]);
    });

    it("requires valid native timestamps rather than inferring an archive date", () => {
      expect(() => existingLabelSchema.parse({ ...archived, archived_at: "not a date" })).toThrow();
      expect(() => existingLabelSchema.parse({ ...archived, archived_at: undefined })).toThrow();
    });

    it("keeps the managed warning within GitHub's description limit", () => {
      expect(() =>
        labelDefinitionSchema.parse({ ...bug, description: ARCHIVE_DESCRIPTION }),
      ).not.toThrow();
    });

    it.each(["preserve", "archive"] as const)(
      "restores the original identity rather than creating a duplicate in %s mode",
      (policy) => {
        const before = { ...archived, name: "ARCHIVED: BUG" };
        const plan = planLabels({ ...catalog, unconfiguredLabels: policy }, [before], now);
        expect(plan.create).toEqual([canonical]);
        expect(plan.update).toEqual([{ before, after: bug }]);
        expect(plan.unconfigured).toEqual([]);
        expect(plan.delete).toEqual([]);
      },
    );

    it("recognizes a managed prefix even if the label was manually restored", () => {
      const before = { ...archived, name: "archived: bug", archived_at: null };
      const plan = planLabels(catalog, [before], now);
      expect(plan.update).toEqual([{ before, after: bug }]);
      expect(plan.create).toEqual([canonical]);
    });

    it("does not confuse an unmanaged prefixed label with a configured original", () => {
      const manual = { ...archived, name: "archived: bug", description: "Manual archive" };
      const plan = planLabels(archiveCatalog, [manual], now);
      expect(plan.create).toEqual([bug, canonical]);
      expect(plan.update).toEqual([]);
      expect(plan.archive).toEqual([]);
      expect(plan.delete).toEqual([]);
    });

    it.each([false, true])(
      "fails on an active/archive name collision (configured=%s)",
      (configured) => {
        const duplicate = { ...archived, name: "Archived: BUG" };
        expect(() =>
          planLabels(
            configured ? archiveCatalog : { ...archiveCatalog, labels: [canonical] },
            [existing(bug), duplicate],
            now,
          ),
        ).toThrow("Label name collision");
      },
    );

    it("fails on a target occupied by an unmanaged archive", () => {
      const manual = { ...archived, description: "Manual archive" };
      const active = existing({ ...bug, name: "retired" }, 4);
      expect(() => planLabels(archiveCatalog, [manual, active], now)).toThrow(
        "Label name collision",
      );
    });

    it.each([40, 41, 50])(
      "enforces the complete 50-character name limit (original=%s)",
      (length) => {
        const before = existing({ ...bug, name: "x".repeat(length) });
        if (length > 40) {
          expect(() => planLabels(archiveCatalog, [before], now)).toThrow("exceeds 50 characters");
        } else {
          expect(planLabels(archiveCatalog, [before], now).archive).toEqual([
            {
              before,
              name: ARCHIVE_PREFIX + before.name,
            },
          ]);
        }
      },
    );

    it("keeps long unconfigured labels unchanged during migration", () => {
      const before = existing({ ...bug, name: "x".repeat(50) });
      expect(planLabels(catalog, [before], now).archive).toEqual([]);
    });

    it("rejects an unmanaged active label using the reserved prefix", () => {
      const before = { ...archived, archived_at: null, description: "" };
      expect(() => planLabels(archiveCatalog, [before], now)).toThrow("prefix is reserved");
    });

    it("prefixes an earlier managed archive without making it eligible for deletion early", () => {
      const before = { ...archived, name: "retired", archived_at: "2026-10-14T00:00:00Z" };
      const plan = planLabels(archiveCatalog, [before], now);
      expect(plan.archive).toEqual([{ before, name: "archived: retired" }]);
      expect(plan.delete).toEqual([]);
    });
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
