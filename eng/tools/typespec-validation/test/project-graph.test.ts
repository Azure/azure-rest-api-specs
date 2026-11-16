import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "pathe";
import { afterEach, beforeEach, expect, it } from "vitest";
import { buildProjectGraph, findAffectedProjects } from "../src/project-graph.ts";

let root: string;

async function addFile(path: string, contents = "") {
  const file = join(root, path);
  await mkdir(dirname(file), { recursive: true });
  await writeFile(file, contents);
  return file;
}

beforeEach(async () => {
  root = await mkdtemp(join(tmpdir(), "tsv-project-graph-"));
});

afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it("follows imports across folders and projects without including unimported siblings", async () => {
  const shared = await addFile("svc/Shared/models.tsp", `import "./more.tsp";`);
  const more = await addFile("svc/Shared/more.tsp", `import "@typespec/http";`);
  await addFile("svc/Shared/unused.tsp");
  const commonConfig = await addFile("svc/Common/tspconfig.yaml");
  const commonMain = await addFile("svc/Common/main.tsp");
  const aConfig = await addFile("svc/A/tspconfig.yaml");
  const aMain = await addFile(
    "svc/A/main.tsp",
    `import "@azure-tools/typespec-azure-core";\nimport "../Shared/models.tsp";\nimport "../Common";`,
  );
  const aClient = await addFile("svc/A/client.tsp", `import "./main.tsp";`);
  const aExample = await addFile("svc/A/examples/2024-01-01/Get.json", "{}");
  const bConfig = await addFile("svc/B/tspconfig.yaml");
  const bMain = await addFile("svc/B/main.tsp", `import "../Shared/more.tsp";`);

  const graph = await buildProjectGraph([
    join(root, "svc/A"),
    join(root, "svc/B"),
    join(root, "svc/Common"),
  ]);

  expect(graph.projects.get(join(root, "svc/A"))).toEqual({
    path: join(root, "svc/A"),
    configs: [aConfig],
    entrypoints: [aClient, aMain],
    inputs: [aClient, aExample, aConfig, aMain, commonMain, shared, more].sort(),
    inputDirectories: [join(root, "svc/A/examples")],
    libraries: ["@azure-tools/typespec-azure-core", "@typespec/http"],
    dependencies: [join(root, "svc/Common")],
    unresolved: [],
  });
  expect(graph.projects.get(join(root, "svc/B"))?.inputs).toEqual([bConfig, bMain, more].sort());
  expect(graph.projects.get(join(root, "svc/Common"))?.inputs).toEqual([commonMain, commonConfig]);

  expect(findAffectedProjects(graph, [more])).toEqual([join(root, "svc/A"), join(root, "svc/B")]);
  expect(findAffectedProjects(graph, [commonMain])).toEqual([
    join(root, "svc/A"),
    join(root, "svc/Common"),
  ]);
  expect(findAffectedProjects(graph, [join(root, "svc/Shared/unused.tsp")])).toEqual([]);
});

it("includes extended configs, config imports, and reports unresolved imports", async () => {
  const base = await addFile("svc/tspconfig.base.yaml", `imports:\n  - ./lib/decorators.js\n`);
  const decorators = await addFile("svc/lib/decorators.js");
  const config = await addFile("svc/A/tspconfig.yaml", `extends: ../tspconfig.base.yaml\n`);
  const main = await addFile("svc/A/main.tsp", `import "./missing.tsp";`);

  const project = (await buildProjectGraph([join(root, "svc/A")])).projects.get(
    join(root, "svc/A"),
  );

  expect(project?.configs).toEqual([config, base]);
  expect(project?.inputs).toEqual([main, config, decorators, base].sort());
  expect(project?.unresolved).toEqual([{ specifier: "./missing.tsp", from: main }]);
});

it("includes paths referenced by emitter options but not output paths", async () => {
  const config = await addFile(
    "svc/A/tspconfig.yaml",
    [
      "parameters:",
      '  "plugin-dir":',
      '    default: "../plugins"',
      "options:",
      '  "@azure-tools/typespec-autorest":',
      '    examples-dir: "{project-root}/../B/examples"',
      '    emitter-output-dir: "{project-root}/.."',
      '    arm-types-dir: "{project-root}/../common-types"',
      '    output-file: "{version-status}/{version}/openapi.json"',
      '  "@azure-typespec/http-client-csharp":',
      "    plugins:",
      '      - "{plugin-dir}/codegen"',
      '      - "./custom.json"',
      "",
    ].join("\n"),
  );
  const main = await addFile("svc/A/main.tsp");
  const plugin = await addFile("svc/plugins/codegen/index.js");
  const sharedExample = await addFile("svc/B/examples/Get.json", "{}");
  await addFile("svc/B/tspconfig.yaml");
  await addFile("svc/common-types/types.json", "{}");

  const graph = await buildProjectGraph([join(root, "svc/A"), join(root, "svc/B")]);
  const project = graph.projects.get(join(root, "svc/A"));

  expect(project?.inputs).toEqual([config, main, plugin, sharedExample].sort());
  expect(project?.inputDirectories).toEqual(
    [
      join(root, "svc/A/custom.json"),
      join(root, "svc/A/examples"),
      join(root, "svc/B/examples"),
      join(root, "svc/plugins/codegen"),
    ].sort(),
  );
  expect(project?.dependencies).toEqual([join(root, "svc/B")]);
  // Files added under referenced paths after the graph was built still map to the project.
  expect(findAffectedProjects(graph, [join(root, "svc/B/examples/New.json")])).toEqual([
    join(root, "svc/A"),
    join(root, "svc/B"),
  ]);
  expect(findAffectedProjects(graph, [join(root, "svc/A/custom.json")])).toEqual([
    join(root, "svc/A"),
  ]);
  expect(findAffectedProjects(graph, [join(root, "svc/common-types/types.json")])).toEqual([]);
});
