import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "pathe";
import { afterEach, beforeEach, expect, it } from "vitest";
import { DisallowedFileTypesRule } from "../src/rules/disallowed-file-types.ts";

let root: string;
let project: string;

async function writeFiles(files: string[]) {
  for (const file of files) {
    const path = join(root, file);
    await mkdir(dirname(path), { recursive: true });
    await writeFile(path, "");
  }
}

beforeEach(async () => {
  root = resolve(await mkdtemp(join(tmpdir(), "tsv-file-types-")));
  project = join(root, "specification/service/data-plane/Project");
  await mkdir(project, { recursive: true });
});

afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it("rejects script files throughout the service without needing Git history", async () => {
  const files = [
    "specification/service/shared.js",
    "specification/service/.scripts/build.cjs",
    "specification/service/data-plane/Project/.customizations.ts",
    "specification/service/data-plane/Project/client-customizations.mjs",
    "specification/service/data-plane/Sibling/script.mts",
    "specification/service/resource-manager/Other/script.cts",
    "specification/service/data-plane/Project/component.jsx",
    "specification/service/data-plane/Project/component.tsx",
    "specification/service/data-plane/Project/types.d.ts",
    "specification/service/data-plane/Project/UPPER.JS",
  ];
  await writeFiles(files);

  const result = await new DisallowedFileTypesRule().execute(project, defaultLogger);
  expect(result.success).toBe(false);
  expect(result.diagnostics?.map(({ path }) => path)).toEqual(
    files.map((file) => join(root, file)).sort(),
  );
  expect(result.diagnostics?.[0]).toMatchObject({
    severity: "error",
    code: "disallowed-file-type",
  });
});

it("allows specification files and excludes dependencies and other services", async () => {
  await writeFiles([
    "specification/service/data-plane/Project/main.tsp",
    "specification/service/data-plane/Project/tspconfig.yaml",
    "specification/service/data-plane/Project/examples/example.json",
    "specification/service/script.js.md",
    "specification/service/directory.js/readme.md",
    "specification/service/node_modules/package/index.js",
    "specification/service/data-plane/Project/node_modules/package/index.ts",
    "specification/service/.git/hooks/script.js",
    "specification/other/script.js",
    "specification-other/script.ts",
    "eng/script.mjs",
  ]);

  const result = await new DisallowedFileTypesRule().execute(project, defaultLogger);
  expect(result.success).toBe(true);
  expect(result.diagnostics).toEqual([]);
});

it("grandfathers only the files suppressed for this rule, not new scripts in the same service", async () => {
  const existing = "specification/service/data-plane/Project/existing.mjs";
  const added = "specification/service/data-plane/Project/new.mjs";
  await writeFiles([existing]);
  await writeFile(
    join(root, "specification/suppressions.yaml"),
    `- tool: TypeSpecValidation
  rules: [DisallowedFileTypes]
  paths: [service/data-plane/Project/existing.mjs]
  reason: Existing emitter pending relocation
- tool: TypeSpecValidation
  rules: [Compile]
  paths: [service/data-plane/Project/new.mjs]
  reason: Unrelated exception
`,
  );
  const rule = new DisallowedFileTypesRule();
  const grandfathered = await rule.execute(project, defaultLogger);
  expect(grandfathered.success).toBe(true);
  expect(grandfathered.diagnostics).toEqual([]);
  expect(grandfathered.suppressed).toBe("Existing emitter pending relocation");

  await writeFiles([added]);
  const result = await rule.execute(project, defaultLogger);
  expect(result.success).toBe(false);
  expect(result.diagnostics?.map(({ path }) => path)).toEqual([join(root, added)]);
});
