import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, relative, resolve } from "pathe";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { compileTypeSpec, formatTypeSpec } from "../src/typespec-compiler.ts";
import { diagnosticDetails } from "./diagnostics.ts";

let root: string;

beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-compiler-"))));
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

  const result = await compileTypeSpec(root, { fix: true });
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
  await mkdir(join(root, "node_modules"));
  await writeFile(join(root, "shared.tsp"), "model   Shared{value:string;}");
  await writeFile(join(root, "node_modules/ignored.tsp"), "invalid ignored file");
  await writeFile(join(folder, "tspconfig.yaml"), "emit: []");

  const result = await formatTypeSpec(folder, true);

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

it("checks final emitted contents without modifying files or creating output directories", async () => {
  const existing = join(root, "existing.json");
  const missing = join(root, "new", "output.json");
  const unchanged = join(root, "unchanged.json");
  await writeFile(existing, "old\n");
  await writeFile(unchanged, "same\r\n");
  await writeFile(join(root, "main.tsp"), "");
  await writeFile(join(root, "tspconfig.yaml"), "emit: [./emitter.mjs]\n");
  await writeFile(
    join(root, "emitter.mjs"),
    `export async function $onEmit({ program }) {
  await program.host.mkdirp(${JSON.stringify(join(root, "new"))});
  await program.host.writeFile(${JSON.stringify(existing)}, "new\\n");
  await program.host.writeFile(${JSON.stringify(missing)}, "{}\\n");
  await program.host.writeFile(${JSON.stringify(unchanged)}, "temporary\\n");
  await program.host.writeFile(${JSON.stringify(unchanged)}, "same\\n");
}
`,
  );

  const result = await compileTypeSpec(root);

  expect(result.success, JSON.stringify(result.diagnostics)).toBe(true);
  expect(result.changedFiles).toEqual([existing, missing].map((p) => relative(process.cwd(), p)));
  expect(result.emittedFiles).toContain(relative(process.cwd(), unchanged));
  expect(await readFile(existing, "utf8")).toBe("old\n");
  expect(await readFile(unchanged, "utf8")).toBe("same\r\n");
  await expect(readFile(join(root, "new"))).rejects.toMatchObject({ code: "ENOENT" });
});

it("ignores untracked generated output but still checks tracked files matching ignore rules", async () => {
  const ignored = join(root, "ignored.json");
  const tracked = join(root, "tracked.json");
  await writeFile(join(root, "main.tsp"), "");
  await writeFile(join(root, ".gitignore"), "*.json\n");
  await writeFile(tracked, "old");
  await writeFile(join(root, "tspconfig.yaml"), "emit: [./emitter.mjs]\n");
  await writeFile(
    join(root, "emitter.mjs"),
    `export async function $onEmit({ program }) {
  await program.host.writeFile(${JSON.stringify(ignored)}, "new");
  await program.host.writeFile(${JSON.stringify(tracked)}, "new");
}
`,
  );
  await simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false")
    .add(["--force", "."])
    .commit("Fixture");
  const index = await readFile(join(root, ".git/index"));

  const result = await compileTypeSpec(root);

  expect(result.success, JSON.stringify(result.diagnostics)).toBe(true);
  expect(result.changedFiles).toEqual([relative(process.cwd(), tracked)]);
  expect(result.emittedFiles).toContain(relative(process.cwd(), ignored));
  await expect(readFile(ignored)).rejects.toMatchObject({ code: "ENOENT" });
  expect(await readFile(tracked, "utf8")).toBe("old");
  expect(await readFile(join(root, ".git/index"))).toEqual(index);
});

it("reports shared formatting issues without changing TypeSpec or config files", async () => {
  const folder = join(root, "project");
  await mkdir(folder);
  const shared = join(root, "shared.tsp");
  const config = join(folder, "tspconfig.yaml");
  await writeFile(shared, "model   Shared{value:string;}");
  await writeFile(config, "emit: []");

  const result = await formatTypeSpec(folder);

  expect(result.success).toBe(false);
  expect(result.diagnostics?.[0].code).toBe("format-changed");
  expect(diagnosticDetails(result.diagnostics?.[0])).toContain("shared.tsp");
  expect(diagnosticDetails(result.diagnostics?.[0])).toContain("tspconfig.yaml");
  expect(await readFile(shared, "utf8")).toBe("model   Shared{value:string;}");
  expect(await readFile(config, "utf8")).toBe("emit: []");
});

it("refuses emitter removals without deleting files during check-only validation", async () => {
  const file = join(root, "keep.txt");
  await writeFile(file, "keep");
  await writeFile(join(root, "main.tsp"), "");
  await writeFile(join(root, "tspconfig.yaml"), "emit: [./emitter.mjs]\n");
  await writeFile(
    join(root, "emitter.mjs"),
    `export async function $onEmit({ program }) {
  await program.host.rm(${JSON.stringify(file)});
}
`,
  );

  await expect(compileTypeSpec(root)).rejects.toThrow("Removing files is not supported");
  expect(await readFile(file, "utf8")).toBe("keep");
});
