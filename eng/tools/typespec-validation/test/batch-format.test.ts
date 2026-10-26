import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { formatTypeSpec } from "@typespec/compiler";
import { mkdir, mkdtemp, readFile, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "pathe";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { BatchFormatter } from "../src/batch-format.ts";
import { diagnosticDetails } from "./diagnostics.ts";

vi.mock("@typespec/compiler", { spy: true });

let root: string;
const logger = new ConsoleLogger(true);

async function project(name: string, config = "emit: []\n") {
  const folder = join(root, name);
  await mkdir(folder, { recursive: true });
  await writeFile(join(folder, "tspconfig.yaml"), config);
  return folder;
}

beforeEach(async () => {
  root = await mkdtemp(join(tmpdir(), "tsv-batch-format-"));
  await symlink(
    new URL("../../../../node_modules", import.meta.url),
    join(root, "node_modules"),
    "junction",
  );
  vi.mocked(formatTypeSpec).mockClear();
  vi.spyOn(console, "debug").mockImplementation(() => {});
});

afterEach(async () => {
  vi.restoreAllMocks();
  await rm(root, { recursive: true, force: true });
});

it("checks overlapping files once, including nested scopes and each project's config", async () => {
  const first = await project("a");
  const second = await project("b");
  const nested = await project("a/nested", "emit: [ ]\n");
  await writeFile(join(first, "main.tsp"), "model First {}\n");
  await writeFile(join(second, "main.tsp"), "model Second {}\n");
  const formatter = new BatchFormatter();

  await expect(formatter.check(first, logger)).resolves.toEqual({ success: true });
  await expect(formatter.check(second, logger)).resolves.toEqual({ success: true });
  const result = await formatter.check(nested, logger);

  expect(formatTypeSpec).toHaveBeenCalledTimes(2);
  expect(result.success).toBe(false);
  expect(diagnosticDetails(result.diagnostics?.[0])).toContain(join(nested, "tspconfig.yaml"));
  expect(console.debug).toHaveBeenCalledWith("Formatting: 1 checked, 1 reused");
});

it("reports shared-file failures for both projects without changing the source", async () => {
  const first = await project("a");
  const second = await project("b");
  const shared = join(root, "shared.tsp");
  const source = "model Shared{value:string;}\n";
  await writeFile(shared, source);
  const formatter = new BatchFormatter();

  for (const folder of [first, second]) {
    const result = await formatter.check(folder, logger);
    expect(result).toMatchObject({
      success: false,
      diagnostics: [{ code: "format-changed", path: folder }],
    });
    expect(diagnosticDetails(result.diagnostics?.[0])).toContain(shared);
    expect(result.diagnostics?.[0].help).toContain("pnpm exec tsp format");
  }

  expect(formatTypeSpec).toHaveBeenCalledOnce();
  expect(await readFile(shared, "utf8")).toBe(source);
});

it("invalidates cached successes and failures when source or formatter options change", async () => {
  const folder = await project("a");
  const source = join(folder, "main.tsp");
  const formatter = new BatchFormatter();
  await writeFile(source, "model Example {}\n");
  await expect(formatter.check(folder, logger)).resolves.toEqual({ success: true });

  await writeFile(source, "model Example{value:string;}\n");
  await expect(formatter.check(folder, logger)).resolves.toMatchObject({ success: false });
  await writeFile(source, "model Example {\n  value: string;\n}\n");
  await expect(formatter.check(folder, logger)).resolves.toEqual({ success: true });

  await writeFile(join(root, ".prettierrc.json"), '{"tabWidth":4}');
  await expect(formatter.check(folder, logger)).resolves.toMatchObject({ success: false });
  expect(formatTypeSpec).toHaveBeenCalledTimes(4);
});

it("retains parser errors and does not reuse unrelated failures in narrower scopes", async () => {
  const broad = await project("a");
  const narrow = await project("a/nested");
  const invalid = join(root, "invalid.tsp");
  await writeFile(invalid, "model {\n");
  const formatter = new BatchFormatter();

  const result = await formatter.check(broad, logger);
  expect(result).toMatchObject({
    success: false,
    diagnostics: [{ code: "format", path: invalid }],
  });
  expect(diagnosticDetails(result.diagnostics?.[0])).toContain("error format-failed:");
  await expect(formatter.check(narrow, logger)).resolves.toEqual({ success: true });
});
