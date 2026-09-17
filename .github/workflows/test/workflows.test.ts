import { readFile, readdir } from "fs/promises";
import { load } from "js-yaml";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";

// cspell:ignore agentics

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

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

  it("does not use github-script in authored workflows or actions", async () => {
    const directories = [workflowsDir, resolve(workflowsDir, "../actions")];
    for (const directory of directories) {
      for (const file of await readdir(directory, { recursive: true })) {
        if (!/\.(yaml|yml|md)$/.test(file)) continue;
        if (file.endsWith(".lock.yml") || file === "agentics-maintenance.yml") continue;
        const text = await readFile(resolve(directory, file), "utf8");
        const source = file.endsWith(".md") ? /^---\r?\n([\s\S]*?)\r?\n---/.exec(text)?.[1] : text;
        if (!source) continue;
        expect(findUses(load(source)), file).not.toContainEqual(
          expect.stringMatching(/^actions\/github-script@/),
        );
      }
    }
  });

  it("sets up direct commands and explicitly supplies tokens only to API commands", async () => {
    for (const file of await readdir(workflowsDir)) {
      if (!file.endsWith(".yaml")) continue;
      const workflow = load(await readFile(resolve(workflowsDir, file), "utf8")) as {
        jobs?: Record<
          string,
          { steps?: { uses?: string; run?: string; env?: Record<string, string> }[] }
        >;
      };
      for (const job of Object.values(workflow.jobs ?? {})) {
        let installed = false;
        for (const step of job.steps ?? []) {
          if (
            step.uses === "./.github/actions/install-workflow-deps" ||
            step.uses === "./.github/actions/setup-node-install-deps"
          )
            installed = true;
          const command = step.run?.match(
            /^node "\$\{\{ github.workspace \}\}\/\.github\/workflows\/cmd\/([^"]+\.ts)"$/,
          )?.[1];
          if (!command) continue;
          expect(installed, `${file}:${command}`).toBe(true);
          const source = await readFile(resolve(workflowsDir, "cmd", command), "utf8");
          if (source.includes("createWorkflowArguments")) {
            expect(step.env?.GITHUB_TOKEN, `${file}:${command}`).toBe("${{ github.token }}");
          } else {
            expect(step.env?.GITHUB_TOKEN, `${file}:${command}`).toBeUndefined();
          }
        }
      }
    }
  });
});

function findUses(value: unknown): string[] {
  if (Array.isArray(value)) return value.flatMap(findUses);
  if (typeof value !== "object" || value === null) return [];
  return Object.entries(value).flatMap(([key, child]) =>
    key === "uses" && typeof child === "string" ? [child] : findUses(child),
  );
}
