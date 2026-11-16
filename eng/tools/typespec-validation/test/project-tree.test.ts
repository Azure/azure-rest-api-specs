import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "pathe";
import { afterEach, beforeEach, expect, it } from "vitest";
import { buildProjectTree } from "../src/project-tree.ts";

let root: string;

async function addFile(path: string, contents = "") {
  const file = join(root, path);
  await mkdir(dirname(file), { recursive: true });
  await writeFile(file, contents);
  return file;
}

beforeEach(async () => {
  root = await mkdtemp(join(tmpdir(), "tsv-project-tree-"));
});

afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it("models nested projects and shared formatting files without treating them as imports", async () => {
  const aConfig = await addFile("service/A/tspconfig.yaml");
  const bConfig = await addFile("service/B/tspconfig.yaml");
  const nestedConfig = await addFile("service/A/models/Nested/tspconfig.yaml");
  const shared = await addFile("service/shared/model.tsp");
  const aMain = await addFile("service/A/main.tsp");
  const nestedMain = await addFile("service/A/models/Nested/main.tsp");
  const sibling = await addFile("service/B/unimported.tsp");
  const ignored = await addFile("service/node_modules/package/ignored.tsp");
  const a = dirname(aConfig);
  const b = dirname(bConfig);
  const nested = dirname(nestedConfig);

  const tree = await buildProjectTree([b, nested, a, a]);

  expect([...tree.projects.keys()]).toEqual([a, nested, b]);
  expect(tree.projects.get(a)?.children).toEqual([nested]);
  expect(tree.projects.get(nested)?.parent).toBe(a);
  expect(tree.projects.get(b)?.parent).toBeUndefined();
  expect(tree.projects.get(a)?.formatFiles).toEqual(
    [aConfig, shared, aMain, nestedMain, sibling].sort(),
  );
  expect(tree.projects.get(nested)?.formatFiles).toEqual([nestedConfig, nestedMain].sort());
  expect(tree.formatFiles.get(shared)).toEqual([a, b]);
  expect(tree.formatFiles.get(nestedMain)).toEqual([a, nested, b]);
  expect(tree.formatFiles.get(aConfig)).toEqual([a]);
  expect(tree.formatFiles.has(ignored)).toBe(false);
});

it("includes formatting inputs outside the selected project and matches the compiler formatter", async () => {
  const main = await addFile("service/Project/main.tsp", "model A {}\n");
  const shared = await addFile("service/shared/model.tsp", "model B {}\n");
  const config = await addFile("service/Project/tspconfig.yaml", "emit: []\n");
  await addFile("service/node_modules/dependency/model.tsp", "model C {}\n");
  const project = dirname(config);
  const tree = await buildProjectTree([project]);
  const formatter = (await import(
    new URL(
      "./dist/src/core/formatter-fs.js",
      import.meta.resolve("@typespec/compiler/package.json"),
    ).href
  )) as {
    checkFilesFormat: (
      patterns: string[],
      options: { exclude: string[] },
    ) => Promise<{
      formatted: string[];
      needsFormat: string[];
      ignored: string[];
      errored: [string, unknown][];
    }>;
  };
  const result = await formatter.checkFilesFormat([resolve(project, "../**/*.tsp"), config], {
    exclude: [resolve(project, "../**/node_modules")],
  });
  const actual = [
    ...result.formatted,
    ...result.needsFormat,
    ...result.ignored,
    ...result.errored.map(([path]) => path),
  ].sort();

  expect(tree.projects.get(project)?.formatFiles).toEqual([config, main, shared].sort());
  expect(tree.projects.get(project)?.formatFiles).toEqual(actual);
});
