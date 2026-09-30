import { execFile, execNodeBin, execPnpm, isExecError } from "@azure-tools/specs-shared/exec";
import {
  cp,
  mkdir,
  mkdtemp,
  readdir,
  readFile,
  realpath,
  rm,
  symlink,
  writeFile,
} from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import { describe, expect, it } from "vitest";

const packageRoot = resolve(import.meta.dirname, "..");
const packageName = "@azure-tools/typespec-foundry-core";
const rule = `${packageName}/use-standard-operations`;
const directoryLink = process.platform === "win32" ? "junction" : "dir";

async function createConsumer(root: string) {
  const consumer = join(root, "consumer");
  await mkdir(join(consumer, "node_modules/@azure-tools"), { recursive: true });
  await mkdir(join(consumer, "node_modules/@typespec"), { recursive: true });
  await symlink(
    await realpath(join(packageRoot, "node_modules/@typespec/compiler")),
    join(consumer, "node_modules/@typespec/compiler"),
    directoryLink,
  );
  await writeFile(
    join(consumer, "main.tsp"),
    `import "${packageName}";\nusing Microsoft.Foundry.Core;\nop raw(): void;\n`,
  );
  return consumer;
}

async function checkConsumer(consumer: string, extension: "ts" | "js") {
  // A separate native Node process avoids Vitest's TypeScript loader masking npm restrictions.
  await execFile(
    process.execPath,
    [
      "--input-type=module",
      "--eval",
      `
        import assert from "node:assert/strict";
        import { resolve } from "node:path";
        import { compile, NodeHost } from "@typespec/compiler";
        const library = await import("${packageName}");
        assert.equal(library.$lib.name, "${packageName}");
        assert.ok(import.meta.resolve("${packageName}").endsWith("/src/index.ts") === ${extension === "ts"});
        assert.ok(import.meta.resolve("${packageName}").endsWith("/dist/index.js") === ${extension === "js"});
        const plain = await compile(NodeHost, resolve("main.tsp"), { noEmit: true });
        assert.deepEqual(plain.diagnostics, []);
        const enabled = await compile(NodeHost, resolve("main.tsp"), {
          noEmit: true,
          linterRuleSet: { enable: { "${rule}": true } },
        });
        assert.deepEqual(enabled.diagnostics.map(({ code, severity }) => ({ code, severity })), [
          { code: "${rule}", severity: "warning" },
        ]);
      `,
    ],
    { cwd: consumer },
  );
}

describe("package loading", () => {
  it("loads source TypeScript through a workspace link without any built files", async () => {
    const root = await mkdtemp(join(tmpdir(), "foundry-source-"));
    try {
      const source = join(root, "workspace/foundry-core");
      await mkdir(source, { recursive: true });
      for (const path of ["package.json", "lib", "src"]) {
        await cp(join(packageRoot, path), join(source, path), { recursive: true });
      }
      await symlink(join(packageRoot, "node_modules"), join(source, "node_modules"), directoryLink);
      const consumer = await createConsumer(root);
      await symlink(source, join(consumer, "node_modules", packageName), directoryLink);
      expect(await readdir(source)).not.toContain("dist");
      await checkConsumer(consumer, "ts");
    } finally {
      await rm(root, { recursive: true, force: true });
    }
  });

  it("packs JavaScript and loads it from a real node_modules directory", async () => {
    const root = await mkdtemp(join(tmpdir(), "foundry-package-"));
    try {
      const sourceManifest = await readFile(join(packageRoot, "package.json"), "utf8");
      await execPnpm(["pack", "--pack-destination", root], { cwd: packageRoot });
      expect(await readFile(join(packageRoot, "package.json"), "utf8")).toBe(sourceManifest);
      const archives = (await readdir(root)).filter((name) => name.endsWith(".tgz"));
      expect(archives).toHaveLength(1);
      const consumer = await createConsumer(root);
      const installed = join(consumer, "node_modules", packageName);
      await mkdir(installed, { recursive: true });
      await execFile("tar", [
        "-xzf",
        join(root, archives[0]),
        "--strip-components",
        "1",
        "-C",
        installed,
      ]);
      const manifest = JSON.parse(await readFile(join(installed, "package.json"), "utf8")) as {
        main: string;
        types: string;
        exports: Record<string, { default: string; types: string; typespec: string }>;
        peerDependencies: Record<string, string>;
      };
      expect(manifest.main).toBe("dist/index.js");
      expect(manifest.types).toBe("dist/index.d.ts");
      expect(manifest.exports["."]).toEqual({
        typespec: "./lib/main.tsp",
        types: "./dist/index.d.ts",
        default: "./dist/index.js",
      });
      expect(JSON.stringify(manifest.peerDependencies)).not.toMatch(/catalog:|workspace:/);
      expect(await readdir(installed)).not.toContain("src");
      await checkConsumer(consumer, "js");
      await writeFile(
        join(consumer, "index.mts"),
        `import { $lib, $linter } from "${packageName}";\nconst name: string = $lib.name;\nconst rules: object = $linter;\n`,
      );
      await writeFile(
        join(consumer, "tsconfig.json"),
        JSON.stringify({
          compilerOptions: {
            module: "NodeNext",
            target: "ES2024",
            strict: true,
            noEmit: true,
            types: ["node"],
          },
          files: ["index.mts"],
        }),
      );
      await mkdir(join(consumer, "node_modules/@types"), { recursive: true });
      await symlink(
        await realpath(join(packageRoot, "node_modules/@types/node")),
        join(consumer, "node_modules/@types/node"),
        directoryLink,
      );
      await execNodeBin("typescript", ["tsc", "-p", join(consumer, "tsconfig.json")], {
        cwd: packageRoot,
      }).catch((error: unknown) => {
        if (isExecError(error)) console.error(error.stdout, error.stderr);
        throw error;
      });
    } finally {
      await rm(root, { recursive: true, force: true });
    }
  }, 60_000);
});
