import { execPnpm } from "@azure-tools/specs-shared/exec";
import { load } from "js-yaml";
import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { expect, it } from "vitest";
import { z } from "zod";

it("uses the default catalog for every external workspace dependency", async () => {
  const root = fileURLToPath(new URL("../../../", import.meta.url));
  const dependencyMap = z.record(z.string(), z.string());
  const workspace = z
    .object({ catalogMode: z.literal("strict"), catalog: dependencyMap })
    .parse(load(await readFile(join(root, "pnpm-workspace.yaml"), "utf8")));

  const { stdout } = await execPnpm(["list", "--recursive", "--depth", "-1", "--json"], {
    cwd: root,
  });
  const projects = z.array(z.object({ path: z.string() })).parse(JSON.parse(stdout));
  expect(projects.length).toBeGreaterThan(0);

  for (const { path } of projects) {
    const manifest = z
      .record(z.string(), z.unknown())
      .parse(JSON.parse(await readFile(join(path, "package.json"), "utf8")));
    for (const section of [
      "dependencies",
      "devDependencies",
      "optionalDependencies",
      "peerDependencies",
    ]) {
      for (const [name, version] of Object.entries(dependencyMap.parse(manifest[section] ?? {}))) {
        const context = `${path}/package.json: ${section}.${name}`;
        if (version.startsWith("workspace:")) {
          expect(version, context).toBe("workspace:*");
        } else {
          expect(version, context).toBe("catalog:");
          expect(workspace.catalog[name], context).toBeTypeOf("string");
        }
      }
    }
  }
});
