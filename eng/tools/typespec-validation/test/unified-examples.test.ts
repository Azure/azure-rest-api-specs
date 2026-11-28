import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "pathe";
import { afterEach, beforeEach, expect, it } from "vitest";
import { UnifiedExamplesRule } from "../src/rules/unified-examples.ts";

let root: string;
let project: string;
const projectPath = "specification/service/data-plane/Project";

async function writeFiles(files: Record<string, string>) {
  for (const [file, content] of Object.entries(files)) {
    const path = join(root, file);
    await mkdir(dirname(path), { recursive: true });
    await writeFile(path, content);
  }
}

beforeEach(async () => {
  root = resolve(await mkdtemp(join(tmpdir(), "tsv-unified-examples-")));
  project = join(root, projectPath);
  await mkdir(project, { recursive: true });
});

afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it("rejects authored JSON examples, including version folders and uppercase extensions, without Git history", async () => {
  const files = [
    `${projectPath}/examples/example.json`,
    `${projectPath}/examples/2026-01-01/create.json`,
    `${projectPath}/examples/.hidden/EXAMPLE.JSON`,
  ];
  await writeFiles(Object.fromEntries(files.map((file) => [file, "{}"])));

  const result = await new UnifiedExamplesRule().execute(project, defaultLogger);
  expect(result.success).toBe(false);
  expect(result.diagnostics?.map(({ path }) => path)).toEqual(
    files.map((file) => join(root, file)).sort(),
  );
  expect(result.diagnostics?.[0]).toMatchObject({
    severity: "error",
    code: "json-examples",
    help: expect.stringContaining("examples.yaml") as unknown,
  });
});

it.each(["examples.yaml", "examples/Operations.yaml"])(
  "allows %s and leaves generated Swagger examples and other JSON files alone",
  async (yamlFile) => {
    await writeFiles({
      [`${projectPath}/${yamlFile}`]: "$namespace: Service\n",
      [`${projectPath}/stable/2026-01-01/examples/example.json`]: "{}",
      [`${projectPath}/preview/2026-06-01-preview/examples/example.json`]: "{}",
      [`${projectPath}/schema.json`]: "{}",
      [`${projectPath}/examples/node_modules/package/example.json`]: "{}",
    });

    const result = await new UnifiedExamplesRule().execute(project, defaultLogger);
    expect(result.success).toBe(true);
    expect(result.diagnostics).toEqual([]);
  },
);

it("grandfathers a legacy project without exempting new projects in the same service", async () => {
  const siblingPath = "specification/service/data-plane/NewProject";
  await writeFiles({
    [`${projectPath}/examples/2026-01-01/example.json`]: "{}",
    [`${siblingPath}/examples/example.json`]: "{}",
    "specification/suppressions.yaml": `- tool: TypeSpecValidation
  rules: [UnifiedExamples]
  reason: Existing legacy examples awaiting migration
  paths: [service/data-plane/Project]
- tool: TypeSpecValidation
  rules: [Compile]
  reason: Unrelated exception
  paths: [service/data-plane/NewProject]
`,
  });

  const rule = new UnifiedExamplesRule();
  const existing = await rule.execute(project, defaultLogger);
  expect(existing.success).toBe(true);
  expect(existing.suppressed).toBe("Existing legacy examples awaiting migration");

  const added = await rule.execute(join(root, siblingPath), defaultLogger);
  expect(added.success).toBe(false);
  expect(added.diagnostics?.[0].path).toBe(join(root, siblingPath, "examples/example.json"));
});

it("retires the legacy exemption on migration and prevents JSON from returning even if YAML is removed", async () => {
  const suppressionsPath = join(root, "specification/suppressions.yaml");
  await writeFiles({
    [`${projectPath}/examples/Operations.yaml`]: "$namespace: Service\n",
    "specification/suppressions.yaml": `- tool: TypeSpecValidation
  rules: [UnifiedExamples]
  reason: Existing legacy examples awaiting migration
  paths: [service/data-plane/Project]
`,
  });
  const rule = new UnifiedExamplesRule();

  const stale = await rule.execute(project, defaultLogger);
  expect(stale.success).toBe(false);
  expect(stale.diagnostics?.[0].code).toBe("unified-examples-suppression");

  await writeFile(suppressionsPath, "[]\n");
  expect((await rule.execute(project, defaultLogger)).success).toBe(true);

  await writeFiles({ [`${projectPath}/examples/example.json`]: "{}" });
  expect((await rule.execute(project, defaultLogger)).success).toBe(false);

  await rm(join(project, "examples/Operations.yaml"));
  const reverted = await rule.execute(project, defaultLogger);
  expect(reverted.success).toBe(false);
  expect(reverted.diagnostics?.[0].code).toBe("json-examples");
});
