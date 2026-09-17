import { readFile, readdir } from "fs/promises";
import { load } from "js-yaml";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

interface Workflow {
  on?: {
    pull_request?: { paths?: string[] };
    push?: { paths?: string[] };
    workflow_call?: { inputs?: Record<string, unknown> };
  };
  permissions?: Record<string, string>;
  jobs: Record<
    string,
    {
      strategy?: unknown;
      steps?: { run?: string; with?: Record<string, unknown> }[];
      with?: Record<string, unknown>;
    }
  >;
}

async function readWorkflow(file: string): Promise<Workflow> {
  return load(await readFile(resolve(workflowsDir, file), "utf8")) as Workflow;
}

describe("workflow files", () => {
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

  it("runs code linting once, outside the package test matrices", async () => {
    const files = (await readdir(workflowsDir)).filter((file) => /\.ya?ml$/.test(file));
    const lintSteps: string[] = [];

    for (const file of files) {
      const workflow = await readWorkflow(file);
      for (const [name, job] of Object.entries(workflow.jobs)) {
        expect(job.with ?? {}).not.toHaveProperty("lint");
        for (const step of job.steps ?? []) {
          if (/\bpnpm\s+(?:run\s+)?lint(?:\s|$|:oxlint\b)/.test(step.run ?? "")) {
            lintSteps.push(`${file}/${name}`);
            expect(job.strategy).toBeUndefined();
            expect(step.run).toBe("pnpm run lint --format=github");
          }
        }
      }
    }

    expect(lintSteps).toEqual(["lint.yaml/lint"]);
    const reusable = await readWorkflow("_reusable-eng-tools-test.yaml");
    expect(reusable.on?.workflow_call?.inputs).not.toHaveProperty("lint");
  });

  it("triggers central linting for all package and lint configuration changes", async () => {
    const workflow = await readWorkflow("lint.yaml");
    const paths = [
      ".github/**",
      "eng/tools/**",
      ".oxlintrc.json",
      ".gitignore",
      "package.json",
      "pnpm-lock.yaml",
      "pnpm-workspace.yaml",
      "tsconfig.json",
    ];
    expect(workflow.on?.pull_request?.paths).toEqual(paths);
    expect(workflow.on?.push?.paths).toEqual(paths);
    expect(workflow.permissions).toEqual({ contents: "read" });
    expect(Object.keys(workflow.jobs)).toEqual(["lint"]);
    expect(workflow.jobs.lint.steps?.[0].with?.["sparse-checkout"]).toBe(".github\neng/tools\n");
    expect(workflow.jobs.lint.steps?.[1].with?.["install-command"]).toBe("pnpm ci");
  });

  it("runs formatting once, outside the package test matrices", async () => {
    const files = (await readdir(workflowsDir)).filter((file) => /\.ya?ml$/.test(file));
    const formatSteps: string[] = [];
    for (const file of files) {
      const workflow = await readWorkflow(file);
      for (const [name, job] of Object.entries(workflow.jobs)) {
        for (const step of job.steps ?? []) {
          if (/\bpnpm\s+(?:run\s+)?format(?::check(?::ci)?)?\b/.test(step.run ?? "")) {
            formatSteps.push(`${file}/${name}`);
            expect(job.strategy).toBeUndefined();
            expect(step.run).toBe("pnpm run format:check");
          }
        }
      }
    }
    expect(formatSteps).toEqual(["format.yaml/format"]);
  });

  it("triggers shared formatting for all package and formatter configuration changes", async () => {
    const workflow = await readWorkflow("format.yaml");
    const paths = [
      ".github/**",
      "eng/tools/**",
      ".oxfmtrc.json",
      ".editorconfig",
      ".gitignore",
      "package.json",
      "pnpm-lock.yaml",
      "pnpm-workspace.yaml",
    ];
    expect(workflow.on?.pull_request?.paths).toEqual(paths);
    expect(workflow.on?.push?.paths).toEqual(paths);
    expect(workflow.permissions).toEqual({ contents: "read" });
    expect(Object.keys(workflow.jobs)).toEqual(["format"]);
    expect(workflow.jobs.format.steps?.[0].with?.["sparse-checkout"]).toBe(".github\neng/tools\n");
    expect(workflow.jobs.format.steps?.[1].with?.["install-command"]).toBe("pnpm ci");
  });
});
