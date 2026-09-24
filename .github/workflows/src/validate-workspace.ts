import { execSync } from "node:child_process";
import { readFileSync, realpathSync } from "node:fs";
import { join, relative, resolve, sep } from "node:path";
import { parse, parseAllDocuments } from "yaml";

const dependencyTypes = [
  "dependencies",
  "devDependencies",
  "peerDependencies",
  "optionalDependencies",
] as const;

type PackageManifest = Partial<Record<(typeof dependencyTypes)[number], Record<string, string>>>;

interface WorkspaceConfig {
  catalog?: Record<string, string>;
  catalogs?: Record<string, Record<string, string>>;
}

interface Lockfile {
  packages?: Record<string, { resolution?: { tarball?: string; gitHosted?: boolean } }>;
}

export function checkCatalogUsage(repoRoot: string): { errors: string[]; warnings: string[] } {
  // Native realpath also expands Windows 8.3 paths to match pnpm's package paths.
  repoRoot = realpathSync.native(repoRoot);
  const config = (parse(readFileSync(join(repoRoot, "pnpm-workspace.yaml"), "utf8")) ??
    {}) as WorkspaceConfig;
  const catalogs = { ...config.catalogs };
  if (config.catalog) {
    catalogs.default = config.catalog;
  }
  const output = execSync("pnpm ls --recursive --json --depth -1 --include-workspace-root", {
    cwd: repoRoot,
    encoding: "utf8",
  });
  const packages = JSON.parse(output) as { path: string }[];
  // Include the root even if pnpm's recursive workspace settings exclude it.
  const packagePaths = new Set([repoRoot, ...packages.map((pkg) => realpathSync.native(pkg.path))]);
  const errors: string[] = [];
  const warnings: string[] = [];
  const usedEntries = new Map<string, Set<string>>();

  for (const packagePath of packagePaths) {
    const manifestPath = join(packagePath, "package.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as PackageManifest;
    const relativePath = relative(repoRoot, manifestPath).split(sep).join("/");

    for (const dependencyType of dependencyTypes) {
      for (const [name, version] of Object.entries(manifest[dependencyType] ?? {})) {
        if (version.startsWith("catalog:")) {
          const catalogName = version.slice("catalog:".length) || "default";
          let used = usedEntries.get(catalogName);
          if (!used) {
            used = new Set();
            usedEntries.set(catalogName, used);
          }
          used.add(name);
          continue;
        }
        if (version.startsWith("workspace:")) {
          continue;
        }
        errors.push(
          `${relativePath}: ${dependencyType}.${name} uses "${version}" instead of "catalog:".`,
        );
      }
    }
  }

  for (const [catalogName, entries] of Object.entries(catalogs)) {
    for (const name of Object.keys(entries)) {
      if (!usedEntries.get(catalogName)?.has(name)) {
        warnings.push(
          `pnpm-workspace.yaml: catalog "${catalogName}" entry "${name}" is not used by any workspace package.`,
        );
      }
    }
  }

  return { errors, warnings };
}

export function checkLockfile(repoRoot: string): string[] {
  const documents = parseAllDocuments(readFileSync(join(repoRoot, "pnpm-lock.yaml"), "utf8"));
  const errors: string[] = [];
  // pnpm 11 uses separate YAML documents for tool dependencies and workspace dependencies.
  for (const document of documents) {
    if (document.errors.length > 0) {
      throw document.errors[0];
    }
    const lockfile = document.toJS() as Lockfile;
    for (const [name, { resolution }] of Object.entries(lockfile.packages ?? {})) {
      // Git-hosted dependencies need their tarball URL; registry packages should be integrity-only.
      if (resolution?.tarball !== undefined && resolution.gitHosted !== true) {
        errors.push(
          `pnpm-lock.yaml: "${name}" has a non-Git-hosted tarball resolution: ${resolution.tarball}. Regenerate the lockfile against the configured registry.`,
        );
      }
    }
  }
  return errors;
}

if (import.meta.main) {
  try {
    const repoRoot = resolve(import.meta.dirname, "../../..");
    const { errors, warnings } = checkCatalogUsage(repoRoot);
    if (errors.length > 0) {
      errors.push(
        'All external dependencies must use "catalog:". Add their versions to pnpm-workspace.yaml and replace the versions in package.json with "catalog:". Keep local dependencies as "workspace:".',
      );
    }
    errors.push(...checkLockfile(repoRoot));
    for (const warning of warnings) {
      console.warn(`Warning: ${warning}`);
    }
    if (errors.length > 0) {
      console.error(errors.join("\n"));
      process.exitCode = 1;
    } else {
      console.log("Workspace dependency and lockfile checks passed.");
    }
  } catch (error) {
    console.error("Failed to validate workspace:", error);
    process.exitCode = 1;
  }
}
