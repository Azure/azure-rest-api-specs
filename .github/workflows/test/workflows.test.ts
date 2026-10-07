import { copyFile, mkdir, mkdtemp, readFile, readdir, rm, writeFile } from "node:fs/promises";
import { parse } from "yaml";
import { tmpdir } from "node:os";
import { dirname, extname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";
import * as z from "zod";
import { execFile } from "../../shared/src/exec.ts";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

describe("workflow files", () => {
  it("publishes the TypeSpec suppressions markdown as a job-summary artifact", async () => {
    const workflow = z
      .object({
        jobs: z.object({
          "typespec-suppressions": z.object({
            steps: z.array(
              z.object({
                name: z.string().optional(),
                id: z.string().optional(),
                uses: z.string().optional(),
                if: z.string().optional(),
                run: z.string().optional(),
                with: z.record(z.string(), z.unknown()).optional(),
              }),
            ),
          }),
        }),
      })
      .parse(
        parse(await readFile(resolve(workflowsDir, "typespec-suppressions-code.yaml"), "utf8")),
      );
    const steps = workflow.jobs["typespec-suppressions"].steps;
    const analysis = steps.find((step) => step.name === "Run TypeSpec suppressions analysis");
    const summaryArtifact = steps.find((step) => step.name === "Set job-summary artifact");

    expect(analysis).toMatchObject({
      id: "typespec-suppressions-analysis",
    });
    expect(analysis?.run).toContain('echo "summary=$GITHUB_STEP_SUMMARY" >> "$GITHUB_OUTPUT"');
    expect(summaryArtifact?.uses).toMatch(/^actions\/upload-artifact@[0-9a-f]{40}$/);
    expect(summaryArtifact).toMatchObject({
      if: "${{ always() && steps.typespec-suppressions-analysis.outputs.summary }}",
      with: {
        name: "job-summary",
        path: "${{ steps.typespec-suppressions-analysis.outputs.summary }}",
      },
    });
  });

  it.each(["typespec-validation.yaml", "typespec-validation-all.yaml"])(
    "%s enables TSV verbosity only for debug runs",
    async (file) => {
      const workflow = z
        .object({
          jobs: z.record(
            z.string(),
            z.object({
              steps: z.array(
                z.object({
                  run: z.string().optional(),
                  env: z.record(z.string(), z.string()).optional(),
                }),
              ),
            }),
          ),
        })
        .parse(parse(await readFile(resolve(workflowsDir, file), "utf8")));
      const debugFlag = "${{ runner.debug == '1' && '--verbose' || '' }}";
      // The debug conditional may appear directly in a tsv.js run command, or be passed through
      // an env var (to keep dynamic values out of the shell script text for zizmor's
      // template-injection audit); either way it must be the only source of "--verbose".
      const commandSteps = Object.values(workflow.jobs)
        .flatMap((job) => job.steps)
        .filter(
          (step) =>
            step.run?.includes("node eng/tools/typespec-validation/cmd/tsv.js") ||
            Object.values(step.env ?? {}).some((value) => value.includes(debugFlag)),
        );
      expect(commandSteps.length).toBeGreaterThan(0);
      for (const step of commandSteps) {
        const text = [step.run ?? "", ...Object.values(step.env ?? {})].join("\n");
        expect(text).toContain(debugFlag);
        expect(text.replace(debugFlag, "")).not.toContain("--verbose");
      }
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
