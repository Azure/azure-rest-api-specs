import { execFile } from "@azure-tools/specs-shared/exec";
import { readdir } from "node:fs/promises";
import { extname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { expect, it } from "vitest";

const root = fileURLToPath(new URL("../../../", import.meta.url));

it.each(["shared/src", "workflows/src"])("%s uses TypeScript source files", async (folder) => {
  const files = await readdir(join(root, ".github", folder), { recursive: true });
  expect(files.some((file) => file.endsWith(".ts"))).toBe(true);
  expect(files.filter((file) => [".js", ".mjs", ".cjs"].includes(extname(file)))).toEqual([]);
});

it("imports every workflow and shared source directly in Node without a build or loader", async () => {
  const entry = pathToFileURL(join(root, ".github/workflows/src/github-test.ts")).href;
  const { stdout } = await execFile(
    process.execPath,
    [
      "--input-type=module",
      "--eval",
      `
        process.env.GITHUB_WORKSPACE = ${JSON.stringify(root)};
        const { default: importAllModules } = await import(${JSON.stringify(entry)});
        await importAllModules({ core: { info() {} } });
        console.log("All TypeScript modules imported");
      `,
    ],
    { cwd: root },
  );
  expect(stdout.trim()).toBe("All TypeScript modules imported");
});
