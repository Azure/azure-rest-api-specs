import { readFile, readdir } from "fs/promises";
import { load } from "js-yaml";
import { dirname, extname, join, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import { z } from "zod";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");
const repoRoot = resolve(workflowsDir, "../..");
const reusableToolWorkflow = "./.github/workflows/_reusable-eng-tools-test.yaml";
const rootInputs = [
  ".editorconfig",
  ".gitattributes",
  ".npmrc",
  "package.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
  "tsconfig.json",
];
const toolInputs = [
  ...rootInputs,
  ".github/actions/setup-node-install-deps/**",
  ".github/shared/**",
  reusableToolWorkflow.slice(2),
  "eng/tools/package.json",
  "eng/tools/tsconfig.json",
  "eng/tools/eslint.base.config.js",
  "eng/tools/vitest.base.config.js",
  "eng/tools/.prettierrc.yaml",
  "eng/tools/.prettierignore",
];

const dependenciesSchema = z.record(z.string(), z.string()).optional();
const packageSchema = z.object({
  name: z.string(),
  dependencies: dependenciesSchema,
  devDependencies: dependenciesSchema,
  optionalDependencies: dependenciesSchema,
  peerDependencies: dependenciesSchema,
});
const workflowSchema = z.object({
  on: z.unknown(),
  jobs: z.record(
    z.string(),
    z.object({
      uses: z.string().optional(),
      with: z.object({ package: z.string().optional() }).optional(),
    }),
  ),
});
const triggersSchema = z.record(z.string(), z.unknown());
const pathsSchema = z.object({ paths: z.array(z.string()) });

/** @param {string} filename */
async function readWorkflow(filename) {
  return workflowSchema.parse(load(await readFile(join(workflowsDir, filename), "utf8")));
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
});

describe("test workflow path filters", () => {
  it.each(["push", "pull_request"])(
    "runs GitHub tests for workspace inputs on %s",
    async (event) => {
      const workflow = await readWorkflow("github-test.yaml");
      const { paths } = pathsSchema.parse(triggersSchema.parse(workflow.on)[event]);

      expect(paths).toEqual(
        expect.arrayContaining([
          ...rootInputs,
          ".github/**",
          "eng/tools/package.json",
          "eng/tools/*/package.json",
        ]),
      );
    },
  );

  it("runs tool tests for shared configuration and transitive workspace dependencies", async () => {
    const entries = await readdir(join(repoRoot, "eng/tools"), { withFileTypes: true });
    const packagePaths = [
      ".github",
      ".github/shared",
      "eng/tools",
      ...entries
        .filter((entry) => entry.isDirectory() && entry.name !== "node_modules")
        .map((entry) => `eng/tools/${entry.name}`),
    ];
    const manifests = await Promise.all(
      packagePaths.map(async (path) => ({
        path,
        ...packageSchema.parse(
          JSON.parse(await readFile(join(repoRoot, path, "package.json"), "utf8")),
        ),
      })),
    );
    const packages = new Map(manifests.map((manifest) => [manifest.name, manifest]));

    /**
     * @param {string} name
     * @param {Set<string>} [paths]
     * @returns {Set<string>}
     */
    function getWorkspacePaths(name, paths = new Set()) {
      const pkg = packages.get(name);
      if (!pkg) {
        throw new Error(`Workspace package not found: ${name}`);
      }
      if (paths.has(pkg.path)) return paths;
      paths.add(pkg.path);

      const dependencies = {
        ...pkg.dependencies,
        ...pkg.devDependencies,
        ...pkg.optionalDependencies,
        ...pkg.peerDependencies,
      };
      for (const [dependency, version] of Object.entries(dependencies)) {
        if (version.startsWith("workspace:")) {
          getWorkspacePaths(dependency, paths);
        }
      }
      return paths;
    }

    const filenames = (await readdir(workflowsDir)).filter(
      (filename) => [".yaml", ".yml"].includes(extname(filename)) && !filename.includes(".lock."),
    );
    const workflows = await Promise.all(
      filenames.map(async (filename) => ({ filename, workflow: await readWorkflow(filename) })),
    );
    let toolWorkflows = 0;
    for (const { filename, workflow } of workflows) {
      for (const job of Object.values(workflow.jobs)) {
        if (job.uses !== reusableToolWorkflow) continue;
        toolWorkflows++;
        const tool = z.string().parse(job.with?.package);
        const manifest = packageSchema.parse(
          JSON.parse(await readFile(join(repoRoot, "eng/tools", tool, "package.json"), "utf8")),
        );
        const { paths } = pathsSchema.parse(triggersSchema.parse(workflow.on).pull_request);

        expect(paths, filename).toEqual(
          expect.arrayContaining([
            ...toolInputs,
            `.github/workflows/${filename}`,
            ...[...getWorkspacePaths(manifest.name)].map((path) => `${path}/**`),
          ]),
        );
      }
    }
    expect(toolWorkflows).toBeGreaterThan(0);
  });
});
