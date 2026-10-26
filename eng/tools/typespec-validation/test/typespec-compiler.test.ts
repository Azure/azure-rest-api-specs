import { mkdir, mkdtemp, readFile, realpath, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { fileURLToPath } from "node:url";
import { dirname, join, relative, resolve } from "pathe";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { compileTypeSpec, formatTypeSpec } from "../src/typespec-compiler.ts";
import { diagnosticDetails } from "./diagnostics.ts";

let root: string;

beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-compiler-"))));
  await mkdir(join(root, "node_modules/@typespec"), { recursive: true });
  await symlink(
    dirname(fileURLToPath(import.meta.resolve("@typespec/compiler/package.json"))),
    join(root, "node_modules/@typespec/compiler"),
    "junction",
  );
});

afterEach(async () => {
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it("honors configured project entrypoints and treats compiler warnings as errors", async () => {
  await writeFile(join(root, "tspconfig.yaml"), "kind: project\nentrypoint: alternate.tsp\n");
  await writeFile(join(root, "main.tsp"), "invalid main entrypoint");
  await writeFile(join(root, "alternate.tsp"), "model Alternate {}\n");

  expect((await compileTypeSpec(root, { noEmit: true })).success).toBe(true);

  await writeFile(
    join(root, "alternate.tsp"),
    '#deprecated "Use a different model"\nmodel Old {}\nmodel Alternate { value: Old; }\n',
  );
  const result = await compileTypeSpec(root, { noEmit: true });

  expect(result.success).toBe(false);
  expect(diagnosticDetails(result.diagnostics?.[0])).toContain("deprecated");
  expect(diagnosticDetails(result.diagnostics?.[0])).toContain("alternate.tsp");
});

it("expands environment variables, records emitted files, and honors noEmit", async () => {
  const outputDir = join(root, "output");
  const outputFile = join(outputDir, "swagger.json");
  vi.stubEnv("TSV_TEST_OUTPUT", outputDir);
  await writeFile(join(root, "main.tsp"), "model Example {}\n");
  await writeFile(
    join(root, "tspconfig.yaml"),
    'environment-variables:\n  TSV_TEST_OUTPUT:\n    default: unused\noutput-dir: "{env.TSV_TEST_OUTPUT}"\nemit:\n  - ./emitter.mjs\n',
  );
  await writeFile(
    join(root, "emitter.mjs"),
    `import { emitFile } from ${JSON.stringify(import.meta.resolve("@typespec/compiler"))};
export async function $onEmit({ program }) {
  await emitFile(program, { path: program.compilerOptions.outputDir + "/swagger.json", content: "{}" });
}
`,
  );

  const result = await compileTypeSpec(root);
  expect(result.success, JSON.stringify(result.diagnostics)).toBe(true);
  expect(result.emittedFiles).toEqual([relative(process.cwd(), outputFile)]);
  expect(await readFile(outputFile, "utf8")).toBe("{}");

  await rm(outputFile);
  const noEmit = await compileTypeSpec(root, { noEmit: true });
  expect(noEmit.success).toBe(true);
  expect(noEmit.emittedFiles).toEqual([]);
  await expect(readFile(outputFile)).rejects.toMatchObject({ code: "ENOENT" });
});

it("formats shared TypeSpec files and project config, excluding node_modules", async () => {
  const folder = join(root, "project");
  await mkdir(folder);
  await writeFile(join(root, "shared.tsp"), "model   Shared{value:string;}");
  await writeFile(join(root, "node_modules/ignored.tsp"), "invalid ignored file");
  await writeFile(join(folder, "tspconfig.yaml"), "emit: []");

  const result = await formatTypeSpec(folder);

  expect(result.success, JSON.stringify(result.diagnostics)).toBe(true);
  expect(await readFile(join(root, "shared.tsp"), "utf8")).toBe(
    "model Shared {\n  value: string;\n}\n",
  );
  expect(await readFile(join(folder, "tspconfig.yaml"), "utf8")).toBe("emit: []\n");
  expect(await readFile(join(root, "node_modules/ignored.tsp"), "utf8")).toBe(
    "invalid ignored file",
  );

  await writeFile(join(root, "shared.tsp"), "model {");
  const invalid = await formatTypeSpec(folder);
  expect(invalid.success).toBe(false);
  expect(diagnosticDetails(invalid.diagnostics?.[0])).toContain("shared.tsp");
});
