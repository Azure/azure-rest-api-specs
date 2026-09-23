import { copyFile, mkdir, mkdtemp, readFile, readdir, rm, writeFile } from "fs/promises";
import { load } from "js-yaml";
import { tmpdir } from "os";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import { execFile } from "../../shared/src/exec.ts";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

interface Workflow {
  name?: string;
  on?: {
    pull_request?: { paths?: string[] };
    push?: { branches?: string[]; paths?: string[] };
    workflow_call?: { inputs?: Record<string, unknown> };
  };
  permissions?: Record<string, string>;
  jobs: Record<
    string,
    {
      name?: string;
      "runs-on"?: string;
      strategy?: { matrix?: Record<string, unknown>; "fail-fast"?: boolean };
      steps?: {
        name?: string;
        if?: string;
        uses?: string;
        run?: string;
        with?: Record<string, unknown>;
      }[];
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
  });

  it("type-checks once and tests all packages on both platforms", async () => {
    const files = (await readdir(workflowsDir)).filter((file) => /\.ya?ml$/.test(file));
    const builds: string[] = [];
    const tests: string[] = [];
    for (const file of files) {
      const workflow = await readWorkflow(file);
      for (const [name, job] of Object.entries(workflow.jobs)) {
        for (const step of job.steps ?? []) {
          if (/\bpnpm\s+(?:run\s+)?(?:build|lint:tsc)\b/.test(step.run ?? "")) {
            builds.push(`${file}/${name}`);
            expect(job.strategy).toBeUndefined();
            expect(job["runs-on"]).toBe("ubuntu-24.04");
            expect(step.run).toBe("pnpm run build");
          }
          if (/\bpnpm\s+(?:run\s+)?test:ci\b/.test(step.run ?? "")) {
            tests.push(`${file}/${name}`);
            expect(job.strategy).toEqual({
              "fail-fast": false,
              matrix: {
                include: [
                  { os: "ubuntu", runner: "ubuntu-24.04" },
                  { os: "windows", runner: "windows-2022" },
                ],
              },
            });
            expect(job["runs-on"]).toBe("${{ matrix.runner }}");
          }
        }
      }
    }
    expect(builds).toEqual(["eng.yml/build"]);
    expect(tests).toEqual(["eng.yml/test"]);
    expect(files).not.toContain("eng-tools-test.yaml");
    expect(files).not.toContain("_reusable-eng-tools-test.yaml");
  });

  it("triggers engineering checks on shared inputs without checking out service specs", async () => {
    const workflow = await readWorkflow("eng.yml");
    const paths = [
      "**/package.json",
      ".github/**",
      "eng/**",
      "pnpm-lock.yaml",
      "pnpm-workspace.yaml",
      "tsconfig.json",
      "tsconfig.base.json",
      "vitest.config.mts",
      ".npmrc",
      ".gitignore",
      ".oxlintrc.json",
      ".oxfmtrc.json",
    ];
    expect(workflow.on?.pull_request?.paths).toEqual(paths);
    expect(workflow.on?.push?.paths).toEqual(paths);
    expect(workflow.on?.push?.branches).toEqual(["main", "typespec-next"]);
    expect(workflow.name).toBe("Eng");
    expect(Object.keys(workflow.jobs)).toEqual(["workspace-validation", "build", "test"]);
    expect(workflow.permissions).toEqual({ contents: "read" });
    expect(
      workflow.jobs.test.steps?.find((step) => step.uses?.startsWith("actions/checkout"))?.with,
    ).toEqual({
      "sparse-checkout": ".github\neng\n",
    });
    for (const job of Object.values(workflow.jobs)) {
      expect(
        job.steps?.filter((step) => step.uses === "./.github/actions/setup-node-install-deps"),
      ).toHaveLength(1);
    }
    const validation = workflow.jobs["workspace-validation"];
    expect(validation["runs-on"]).toBe("ubuntu-24.04");
    expect(validation.strategy).toBeUndefined();
    expect(validation.steps?.[0].with).toEqual({
      "sparse-checkout-cone-mode": false,
      "sparse-checkout":
        "package.json\n/pnpm-workspace.yaml\n/pnpm-lock.yaml\n/.github/actions/setup-node-install-deps/\n/.github/shared/\n/.github/workflows/src/validate-workspace.ts\n",
    });
    expect(validation.steps?.[1].with).toEqual({
      "install-command":
        "pnpm install --frozen-lockfile --prod --prefer-offline --filter=azure-rest-api-specs-github...",
      "cache-name": "workspace-validation",
    });
    expect(validation.steps?.[2].run).toBe("node ./.github/workflows/src/validate-workspace.ts");
  });

  it("retains production-only imports and GitHub workflow checks outside the test jobs", async () => {
    const workflow = await readWorkflow("github-test.yaml");
    expect(workflow.jobs.test.strategy?.matrix).toEqual({
      include: [
        { os: "ubuntu", runner: "ubuntu-24.04" },
        { os: "windows", runner: "windows-2022" },
      ],
    });
    expect(workflow.jobs.test["runs-on"]).toBe("${{ matrix.runner }}");
    expect(workflow.jobs.test.name).toBe("test (${{ matrix.os }})");
    const steps = workflow.jobs.test.steps ?? [];
    const install = steps.findIndex(
      (step) => step.uses === "./.github/actions/install-deps-github-script",
    );
    const imports = steps.findIndex((step) => step.name === "Verify all modules are importable");
    expect(install).toBeGreaterThanOrEqual(0);
    expect(imports).toBeGreaterThan(install);
    expect(steps[imports].if).toBeUndefined();
    expect(steps.some((step) => step.uses === "./.github/actions/setup-node-install-deps")).toBe(
      false,
    );
    const actionlint = steps.find((step) => step.name === "Lint workflows");
    expect(actionlint?.if).toBe("${{ matrix.os == 'ubuntu' }}");
    expect(actionlint?.uses).toContain("actionlint");
    const locks = steps.find((step) => step.name === "Require compiled agentic workflow locks");
    expect(locks?.if).toBe("${{ github.event_name == 'pull_request' && matrix.os == 'ubuntu' }}");
    expect(locks?.with?.script).toContain("core.setFailed");
    for (const path of ["package.json", "pnpm-lock.yaml", "pnpm-workspace.yaml", ".npmrc"]) {
      expect(workflow.on?.pull_request?.paths).toContain(path);
      expect(workflow.on?.push?.paths).toContain(path);
    }
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
      "tsconfig.base.json",
      "tsconfig.json",
      "vitest.config.mts",
    ];
    expect(workflow.on?.pull_request?.paths).toEqual(paths);
    expect(workflow.on?.push?.paths).toEqual(paths);
    expect(workflow.permissions).toEqual({ contents: "read" });
    expect(workflow.name).toBe("Lint");
    expect(Object.keys(workflow.jobs)).toEqual(["lint"]);
    expect(workflow.jobs.lint.name).toBe("Lint");
    expect(workflow.jobs.lint.steps?.[0].with?.["sparse-checkout"]).toBe(".github\neng/tools\n");
    expect(workflow.jobs.lint.steps?.[1].with?.["install-command"]).toBe("pnpm ci");
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
      "vitest.config.mts",
    ];
    expect(workflow.on?.pull_request?.paths).toEqual(paths);
    expect(workflow.on?.push?.paths).toEqual(paths);
    expect(workflow.permissions).toEqual({ contents: "read" });
    expect(Object.keys(workflow.jobs)).toEqual(["format"]);
    expect(workflow.jobs.format.steps?.[0].with?.["sparse-checkout"]).toBe(".github\neng/tools\n");
    expect(workflow.jobs.format.steps?.[1].with?.["install-command"]).toBe("pnpm ci");
  });
});
