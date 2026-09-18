import { execSync } from "node:child_process";
import { readFileSync, realpathSync } from "node:fs";
import { join, relative, sep } from "node:path";

const dependencyTypes = [
  "dependencies",
  "devDependencies",
  "peerDependencies",
  "optionalDependencies",
] as const;

type PackageManifest = Partial<Record<(typeof dependencyTypes)[number], Record<string, string>>>;

export function checkCatalogUsage(repoRoot: string): string[] {
  repoRoot = realpathSync(repoRoot);
  const output = execSync("pnpm ls --recursive --json --depth -1 --include-workspace-root", {
    cwd: repoRoot,
    encoding: "utf8",
  });
  const packages = JSON.parse(output) as { path: string }[];
  // Include the root even if pnpm's recursive workspace settings exclude it.
  const packagePaths = new Set([repoRoot, ...packages.map((pkg) => realpathSync(pkg.path))]);
  const errors: string[] = [];

  for (const packagePath of packagePaths) {
    const manifestPath = join(packagePath, "package.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as PackageManifest;
    const relativePath = relative(repoRoot, manifestPath).split(sep).join("/");

    for (const dependencyType of dependencyTypes) {
      for (const [name, version] of Object.entries(manifest[dependencyType] ?? {})) {
        if (version.startsWith("catalog:") || version.startsWith("workspace:")) {
          continue;
        }
        errors.push(
          `${relativePath}: ${dependencyType}.${name} uses "${version}" instead of "catalog:".`,
        );
      }
    }
  }

  return errors;
}
