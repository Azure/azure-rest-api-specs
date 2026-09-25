import { InMemorySpanExporter } from "@opentelemetry/sdk-trace-base";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, expect, it, vi, type MockInstance } from "vitest";
import { main } from "../src/index.ts";
import { FolderStructureRule } from "../src/rules/folder-structure.ts";
import * as telemetryModule from "../src/telemetry.ts";

let root: string;
let exporter: InMemorySpanExporter;
let telemetry: telemetryModule.TsvTelemetry;
let originalExitCode: typeof process.exitCode;
let originalArgv: string[];
let shutdown: MockInstance<() => Promise<void>>;

beforeEach(async () => {
  originalExitCode = process.exitCode;
  originalArgv = process.argv;
  process.exitCode = undefined;
  vi.stubEnv("AZSDKTOOLS_COLLECT_TELEMETRY", "true");
  vi.stubEnv("TSV_TELEMETRY_TRACEPARENT", undefined);
  vi.stubEnv("TSV_TELEMETRY_DEBUG", undefined);
  vi.spyOn(console, "log").mockImplementation(() => {});
  vi.spyOn(console, "error").mockImplementation(() => {});
  exporter = new InMemorySpanExporter();
  shutdown = vi.spyOn(exporter, "shutdown").mockResolvedValue();
  telemetry = (await telemetryModule.createTelemetry(exporter))!;
  vi.spyOn(telemetryModule, "createTelemetry").mockResolvedValue(telemetry);
  root = await mkdtemp(join(tmpdir(), "tsv-command-telemetry-"));
});

afterEach(async () => {
  await telemetry.shutdown(Number(process.exitCode ?? 0));
  process.exitCode = originalExitCode;
  process.argv = originalArgv;
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

function args(...values: string[]) {
  process.argv = [process.execPath, "tsv", ...values];
}

function command() {
  const spans = exporter.getFinishedSpans();
  expect(spans.filter((span) => span.name === "tsv.command")).toHaveLength(1);
  return spans.find((span) => span.name === "tsv.command")!;
}

it("records whole-tool suppression without collecting context or reason", async () => {
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: ['.']\n  reason: private reason\n",
  );
  args(root, '{"checkingAllSpecs":true,"private":"do-not-send"}');
  await main();
  expect(command().attributes).toMatchObject({
    "tsv.mode": "project",
    "tsv.outcome": "suppressed",
    "tsv.exit_code": 0,
    "tsv.checking_all_specs": true,
  });
  expect(JSON.stringify(command().attributes)).not.toContain("private");
  expect(process.exitCode).toBeUndefined();
});

it.each([
  ["unknown argument", ["--unknown"]],
  ["invalid context", ["{"]],
])("flushes on a thrown %s error", async (_label, values) => {
  if (values[0] === "{") args(root, ...values);
  else args(...values);
  await expect(main()).rejects.toThrow();
  expect(command().attributes).toMatchObject({
    "tsv.outcome": "invalid_input",
    "tsv.exit_code": 1,
  });
  expect(shutdown).toHaveBeenCalledOnce();
});

it.each(["missing", "file"])(
  "flushes without exiting directly for an invalid %s path",
  async (kind) => {
    const folder = join(root, kind);
    if (kind === "file") await writeFile(folder, "");
    args(folder);
    await main();
    expect(process.exitCode).toBe(1);
    expect(command().attributes["tsv.outcome"]).toBe("invalid_input");
    expect(shutdown).toHaveBeenCalledOnce();
  },
);

it("flushes on suppression configuration errors", async () => {
  await writeFile(join(root, "suppressions.yaml"), "- tool: TypeSpecValidation\n");
  args(root);
  await expect(main()).rejects.toThrow();
  expect(command().attributes["tsv.outcome"]).toBe("error");
});

it("records validation failure without uploading the diagnostic", async () => {
  vi.spyOn(FolderStructureRule.prototype, "execute").mockResolvedValue({
    success: false,
    errorOutput: "private diagnostic",
  });
  args(root);
  await main();
  expect(process.exitCode).toBe(1);
  expect(command().attributes).toMatchObject({
    "tsv.outcome": "validation_failed",
    "tsv.rules.failed": 1,
    "tsv.rules.not_reached": 11,
  });
  expect(exporter.getFinishedSpans()).toHaveLength(2);
  expect(JSON.stringify(command().attributes)).not.toContain("private");
});

it("records an all-suppressed native batch without claiming validation passed", async () => {
  await mkdir(join(root, "a"));
  await writeFile(join(root, "a", "tspconfig.yaml"), "");
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [a]\n  reason: private\n",
  );
  args("--all", root);
  await main();
  expect(command().attributes).toMatchObject({
    "tsv.mode": "all",
    "tsv.outcome": "suppressed",
    "tsv.batch_completed": true,
    "tsv.projects.discovered": 1,
    "tsv.projects.selected": 1,
    "tsv.projects.suppressed_before_launch": 1,
    "tsv.projects.launched": 0,
    "tsv.projects.zero_exit": 0,
    "tsv.projects.nonzero_exit": 0,
  });
});

it("records an incomplete native batch when no projects exist", async () => {
  args("--all", root);
  await main();
  expect(command().attributes).toMatchObject({
    "tsv.outcome": "validation_failed",
    "tsv.batch_completed": false,
    "tsv.projects.discovered": 0,
    "tsv.exit_code": 1,
  });
});
