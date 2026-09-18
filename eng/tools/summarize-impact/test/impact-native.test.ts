import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, relative } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { stringify } from "yaml";
import { diffSuppression, getAllApiVersionFromRPFolder } from "../src/impact.ts";

describe("native impact utilities", () => {
  let folder: string;

  beforeEach(async () => {
    folder = await mkdtemp(join(tmpdir(), "impact-native-"));
  });

  afterEach(async () => {
    await rm(folder, { recursive: true, force: true });
  });

  it("finds unique versions recursively and ignores examples and hidden files", async () => {
    for (const directory of ["stable/v1", "preview/v2", "stable/v1/examples", ".hidden"]) {
      await mkdir(join(folder, directory), { recursive: true });
    }
    for (const [file, version] of [
      ["stable/v1/foo.json", "2024-01-01"],
      ["stable/v1/bar.json", "2024-01-01"],
      ["preview/v2/foo.json", "2025-01-01-preview"],
      ["stable/v1/examples/example.json", "ignored-example"],
      [".hidden/ignored.json", "ignored-hidden"],
    ]) {
      await writeFile(join(folder, file), JSON.stringify({ info: { version } }));
    }

    for (const root of [folder, relative(process.cwd(), folder)]) {
      expect(getAllApiVersionFromRPFolder(root).sort()).toEqual([
        "2024-01-01",
        "2025-01-01-preview",
      ]);
    }
  });

  it("compares nested suppression values independently of object key order", async () => {
    const before = join(folder, "before.md");
    const after = join(folder, "after.md");
    const original = {
      suppress: "Rule",
      where: { paths: ["a", "b"], options: { enabled: true, count: 2 } },
    };
    const reordered = {
      where: { options: { count: 2, enabled: true }, paths: ["a", "b"] },
      suppress: "Rule",
    };
    await writeFile(before, "```yaml\n" + stringify({ suppressions: [original] }) + "```\n");
    await writeFile(after, "```yaml\n" + stringify({ suppressions: [reordered] }) + "```\n");

    expect(diffSuppression(before, after)).toEqual([]);

    const changed = { ...reordered, where: { ...reordered.where, paths: ["b", "a"] } };
    await writeFile(after, "```yaml\n" + stringify({ suppressions: [changed] }) + "```\n");

    expect(diffSuppression(before, after)).toEqual([changed]);
  });

  it("preserves merged suppression fields", async () => {
    const before = join(folder, "before.md");
    const after = join(folder, "after.md");
    await writeFile(
      before,
      `\`\`\`yaml
defaults: &defaults
  suppress: Rule
  from: [foo.json]
suppressions:
  - <<: *defaults
    reason: existing reason
\`\`\`
`,
    );
    await writeFile(
      after,
      `\`\`\`yaml
suppressions:
  - suppress: Rule
    from: [foo.json]
    reason: existing reason
\`\`\`
`,
    );

    expect(diffSuppression(before, after)).toEqual([]);
  });

  it("distinguishes timestamp values from quoted date strings", async () => {
    const before = join(folder, "before.md");
    const after = join(folder, "after.md");
    const yaml = `\`\`\`yaml
suppressions:
  - suppress: Rule
    reason: 2026-09-18
\`\`\`
`;
    await writeFile(before, yaml);
    await writeFile(after, yaml.replace("2026-09-18", '"2026-09-18"'));

    expect(diffSuppression(before, after)).toEqual([{ suppress: "Rule", reason: "2026-09-18" }]);
  });
});
