import { copyFile, mkdir, mkdtemp, readFile, readdir, rm, writeFile } from "fs/promises";
import { load } from "js-yaml";
import { tmpdir } from "os";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import * as z from "zod";
import { execFile } from "../../shared/src/exec.ts";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

describe("workflow files", () => {
  it("builds TypeSpec libraries when their sources change", async () => {
    const workflow = z
      .object({
        on: z.object({
          push: z.object({ paths: z.array(z.string()) }),
          pull_request: z.object({ paths: z.array(z.string()) }),
        }),
        jobs: z.record(
          z.string(),
          z.object({
            steps: z.array(
              z.object({
                uses: z.string().optional(),
                run: z.string().optional(),
                with: z.object({ "sparse-checkout": z.string().optional() }).optional(),
              }),
            ),
          }),
        ),
      })
      .parse(load(await readFile(resolve(workflowsDir, "eng.yml"), "utf8")));

    for (const event of [workflow.on.push, workflow.on.pull_request]) {
      expect(event.paths).toContain("libs/**");
    }
    const buildJob = Object.values(workflow.jobs).find((job) =>
      job.steps.some((step) => step.run === "pnpm run build"),
    );
    expect(buildJob).toBeDefined();
    const checkout = buildJob?.steps.find((step) => step.uses?.startsWith("actions/checkout@"));
    expect(checkout?.with?.["sparse-checkout"]?.trim().split(/\s+/)).toContain("libs");
  });

  it.each(["typespec-validation.yaml", "typespec-validation-all.yaml"])(
    "%s enables TSV verbosity only for debug runs",
    async (file) => {
      const workflow = z
        .object({
          jobs: z.record(
            z.string(),
            z.object({
              steps: z.array(z.object({ run: z.string().optional() })),
            }),
          ),
        })
        .parse(load(await readFile(resolve(workflowsDir, file), "utf8")));
      const commands = Object.values(workflow.jobs)
        .flatMap((job) => job.steps)
        .flatMap((step) =>
          step.run?.includes("node eng/tools/typespec-validation/cmd/tsv.js") ? [step.run] : [],
        );
      expect(commands).toHaveLength(1);
      const debugFlag = "${{ runner.debug == '1' && '--verbose' || '' }}";
      expect(commands[0]).toContain(debugFlag);
      expect(commands[0].replace(debugFlag, "")).not.toContain("--verbose");
    },
  );

  it("should be named *.yaml or *.md", async () => {
    const entries = await readdir(workflowsDir, { withFileTypes: true });

    const disallowedFiles = entries
      .filter((e) => e.isFile())
      .map((e) => e.name)
      .filter((f) => {
        const extension = extname(f);
        return extension !== ".yaml" && extension !== ".yml" && extension !== ".md";
      });

    expect(disallowedFiles, "workflow files must use extension '.yaml' or '.md'").toEqual([]);
  });

  it("lints enabled tooling and the root test config, excluding unmanaged paths", async () => {
    const root = resolve(workflowsDir, "../..");
    const folder = await mkdtemp(resolve(tmpdir(), "specs-lint-"));
    try {
      await copyFile(resolve(root, ".oxlintrc.json"), resolve(folder, ".oxlintrc.json"));
      const included = [
        ".github",
        ".github/shared",
        ".github/workflows",
        "eng/tools",
        "libs/foundry-core",
        ...[
          "lint-diff",
          "oav-runner",
          "release-plan",
          "sdk-suppressions",
          "spec-gen-sdk-runner",
          "summarize-impact",
          "suppressions",
          "tsp-client-tests",
          "typespec-requirement",
          "typespec-suppressions",
          "typespec-validation",
        ].map((name) => `eng/tools/${name}`),
      ];
      const excluded = [
        ".",
        ".config",
        "specification",
        "eng/common",
        "eng/scripts",
        "scripts",
        ...["openapi-diff-runner", "typespec-migration-validation"].map(
          (name) => `eng/tools/${name}`,
        ),
      ];
      for (const path of [...included, ...excluded]) {
        await mkdir(resolve(folder, path), { recursive: true });
        await writeFile(resolve(folder, path, "index.ts"), "export const value = 1;\n");
      }
      await writeFile(resolve(folder, "vitest.config.mts"), "export const value = 1;\n");
      const { stdout } = await execFile(
        process.execPath,
        [resolve(root, "node_modules/oxlint/bin/oxlint"), ".", "--debug=files"],
        { cwd: folder },
      );
      expect(stdout.trim().replaceAll("\\", "/").split(/\r?\n/).sort()).toEqual(
        [...included.map((path) => `${path}/index.ts`), "vitest.config.mts"].sort(),
      );
    } finally {
      await rm(folder, { recursive: true, force: true });
    }
  });
});
