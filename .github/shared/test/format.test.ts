import { copyFile, mkdir, mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { execFile } from "../src/exec.ts";

const root = fileURLToPath(new URL("../../../", import.meta.url));
const formatter = join(root, "node_modules/oxfmt/bin/oxfmt");
let folder: string;

beforeEach(async () => {
  folder = await mkdtemp(join(tmpdir(), "specs-format-"));
  await copyFile(join(root, ".oxfmtrc.json"), join(folder, ".oxfmtrc.json"));
});

afterEach(async () => {
  await rm(folder, { recursive: true, force: true });
});

async function addFile(path: string, contents: string) {
  const file = join(folder, path);
  await mkdir(dirname(file), { recursive: true });
  await writeFile(file, contents);
  return file;
}

function format(args: string[], cwd = folder) {
  return execFile(process.execPath, [formatter, ...args], { cwd });
}

describe("shared formatter", () => {
  it.each([".github", ".github/shared", "eng/tools/typespec-validation"])(
    "uses the root configuration from %s without sorting imports",
    async (path) => {
      const source = 'import z from "z";\nimport a from "a";\nexport const value={z,a};\n';
      const file = await addFile(`${path}/src/index.ts`, source);
      await expect(format(["--check", file])).rejects.toMatchObject({ code: 1 });
      await format(["--write", "."], join(folder, path));
      const output = await readFile(file, "utf8");
      expect(output).toBe(
        'import z from "z";\nimport a from "a";\nexport const value = { z, a };\n',
      );
      await format(["--check", file]);
      await format(["--write", file]);
      expect(await readFile(file, "utf8")).toBe(output);
    },
  );

  it("formats JSONC, YAML and Markdown without sorting package.json", async () => {
    const tsconfig = await addFile(
      "eng/tools/example/tsconfig.json",
      '{// compiler options\n"compilerOptions":{"strict":true,},}\n',
    );
    const yaml = await addFile(".github/workflows/example.yaml", "name:   Example\n");
    const markdown = await addFile(".github/shared/README.md", "#   Example\n");
    const manifest = await addFile(
      "eng/tools/example/package.json",
      '{"scripts":{"z":"z","a":"a"},"name":"example","private":true}\n',
    );
    await format(["--write", ".github", "eng/tools"]);
    expect(await readFile(tsconfig, "utf8")).toContain("// compiler options");
    expect(await readFile(yaml, "utf8")).toBe("name: Example\n");
    expect(await readFile(markdown, "utf8")).toBe("# Example\n");
    const output = JSON.parse(await readFile(manifest, "utf8")) as {
      scripts: Record<string, string>;
    };
    expect(Object.keys(output)).toEqual(["scripts", "name", "private"]);
    expect(Object.keys(output.scripts)).toEqual(["z", "a"]);
    await format(["--check", ".github", "eng/tools"]);
  });

  it("keeps excluded content untouched even when explicitly requested", async () => {
    const paths = [
      "specification/example/stable/api.json",
      "specification/example/examples/request.json",
      "specification/example/main.tsp",
      ".github/shared/test/fixtures/input.json",
      ".github/shared/test/specification/input.json",
      ".github/shared/coverage/output.json",
      ".github/workflows/example.lock.yml",
      ".github/workflows/agentics-maintenance.yml",
      ".github/workflows/post-apiview.yml",
      ".github/instructions/example.instructions.md",
      ".github/ISSUE_TEMPLATE/example.yml",
      ".github/policies/example.yml",
      ".github/prompts/example.md",
      ".github/chatmodes/example.md",
      ".github/PULL_REQUEST_TEMPLATE/example.md",
      ".github/skills/azsdk-common-example/SKILL.md",
      ".github/skills/evals/example/results/output.json",
      ".github/skills/evals/example/session-state/output.json",
      "eng/tools/example/test/fixtures/input.json",
      "eng/tools/example/test/specification/input.json",
      "eng/tools/example/coverage/output.json",
      "eng/tools/example/dist/output.js",
    ];
    const contents = "not valid input {{{";
    for (const path of paths) await addFile(path, contents);
    const managed = await addFile(".github/shared/index.ts", "export const value = 1;\n");
    await format(["--write", managed, ...paths]);
    for (const path of paths) {
      expect(await readFile(join(folder, path), "utf8"), path).toBe(contents);
    }
  });

  it("still formats explicitly targeted TypeSpec configuration YAML", async () => {
    const file = await addFile("specification/example/tspconfig.yaml", "emit:   []\n");
    await format(["--write", "tspconfig.yaml"], dirname(file));
    expect(await readFile(file, "utf8")).toBe("emit: []\n");
  });

  it("fails on malformed managed input instead of silently skipping it", async () => {
    const file = await addFile("eng/tools/example/src/index.ts", "const = ;");
    await expect(format(["--check", file])).rejects.toThrow();
    expect(await readFile(file, "utf8")).toBe("const = ;");
  });
});
