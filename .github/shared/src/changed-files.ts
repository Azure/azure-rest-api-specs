import debug from "debug";
import { simpleGit } from "simple-git";
import { KeyedCache } from "./cache.ts";
import { includesSegment } from "./path.ts";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

// Cache results of the `example` filter, using the un-resolved path for maximum perf
// The `example` filter is a hot path in spec-model for large specs like "network".

const exampleCache: KeyedCache<string, boolean> = new KeyedCache();

/**
 * Get a list of changed files in a git repository
 * @returns List of changed files, using posix paths, relative to repo root. Example: ["specification/foo/Microsoft.Foo/main.tsp"].
 */
export async function getChangedFiles(
  options: {
    baseCommitish?: string;
    cwd?: string;
    gitOptions?: string[];
    headCommitish?: string;
    logger?: import("./logger.ts").ILogger;
    paths?: string[];
  } = {},
): Promise<string[]> {
  const {
    baseCommitish = "HEAD^",
    cwd,
    gitOptions = [],
    headCommitish = "HEAD",
    logger,
    paths = [],
  } = options;

  if (paths.length > 0) {
    // Use "--" to separate paths from revisions
    paths.unshift("--");
  }

  // TODO: If we need to filter based on status, instead of passing an argument to `--diff-filter,
  // consider using "--name-status" instead of "--name-only", and return an array of objects like
  // { name: "/foo/baz.js", status: Status.Renamed, previousName: "/foo/bar.js"}.
  // Then add filter functions to filter based on status.  This is more flexible and lets consumers
  // filter based on status with a single call to `git diff`.
  const result = await simpleGit(cwd).diff([
    "--name-only",
    ...gitOptions,
    baseCommitish,
    headCommitish,
    ...paths,
  ]);

  const files = result
    .trim()
    .split("\n")
    // ignore empty lines (e.g. when no files are changed)
    .filter((s) => s.length > 0);
  logger?.info("Changed Files:");
  for (const file of files) {
    logger?.info(`  ${file}`);
  }
  logger?.info("");

  return files;
}

/**
 * Get a list of changed files in a git repository with statuses for additions,
 * modifications, deletions, and renames. Warning: rename behavior can vary
 * based on the git client's configuration of diff.renames.
 */
export async function getChangedFilesStatuses(
  options: {
    baseCommitish?: string;
    cwd?: string;
    gitOptions?: string[];
    headCommitish?: string;
    logger?: import("./logger.ts").ILogger;
    paths?: string[];
  } = {},
): Promise<{
  additions: string[];
  modifications: string[];
  deletions: string[];
  renames: { from: string; to: string }[];
  total: number;
}> {
  const {
    baseCommitish = "HEAD^",
    cwd,
    gitOptions = [],
    headCommitish = "HEAD",
    logger,
    paths = [],
  } = options;

  if (paths.length > 0) {
    // Use "--" to separate paths from revisions
    paths.unshift("--");
  }

  const result = await simpleGit(cwd).diff([
    "--name-status",
    ...gitOptions,
    baseCommitish,
    headCommitish,
    ...paths,
  ]);

  const categorizedFiles = {
    additions: [] as string[],
    modifications: [] as string[],
    deletions: [] as string[],
    renames: [] as {
      from: string;
      to: string;
    }[],
    total: 0,
  };

  if (result.trim()) {
    const lines = result.trim().split("\n");

    for (const line of lines) {
      const parts = line.split("\t");
      const status = parts[0];

      switch (status[0]) {
        case "A":
          categorizedFiles.additions.push(parts[1]);
          break;
        case "M":
          categorizedFiles.modifications.push(parts[1]);
          break;
        case "D":
          categorizedFiles.deletions.push(parts[1]);
          break;
        case "R":
          categorizedFiles.renames.push({
            from: parts[1],
            to: parts[2],
          });
          break;
        case "C":
          categorizedFiles.additions.push(parts[2]);
          break;
        default:
          categorizedFiles.modifications.push(parts[1]);
      }
    }

    categorizedFiles.total =
      categorizedFiles.additions.length +
      categorizedFiles.modifications.length +
      categorizedFiles.deletions.length +
      categorizedFiles.renames.length;
  }

  // Log all changed files by categories
  if (logger) {
    logger.info("Categorized Changed Files:");

    if (categorizedFiles.additions.length > 0) {
      logger.info(`  Additions (${categorizedFiles.additions.length}):`);
      for (const file of categorizedFiles.additions) {
        logger.info(`    + ${file}`);
      }
    }

    if (categorizedFiles.modifications.length > 0) {
      logger.info(`  Modifications (${categorizedFiles.modifications.length}):`);
      for (const file of categorizedFiles.modifications) {
        logger.info(`    M ${file}`);
      }
    }

    if (categorizedFiles.deletions.length > 0) {
      logger.info(`  Deletions (${categorizedFiles.deletions.length}):`);
      for (const file of categorizedFiles.deletions) {
        logger.info(`    - ${file}`);
      }
    }

    if (categorizedFiles.renames.length > 0) {
      logger.info(`  Renames (${categorizedFiles.renames.length}):`);
      for (const rename of categorizedFiles.renames) {
        logger.info(`    R ${rename.from} -> ${rename.to}`);
      }
    }

    logger.info(`  Total: ${categorizedFiles.total} files`);
    logger.info("");
  }

  return categorizedFiles;
}

// Functions suitable for passing to string[].filter(), ordered roughly in order of increasing specificity
// Functions accept both relative and absolute paths, since paths are resolve()'d before searching (when needed)

export function json(file?: string): boolean {
  // Extension "json" with any case is a valid JSON file
  return typeof file === "string" && file.toLowerCase().endsWith(".json");
}

export function markdown(file?: string): boolean {
  // Extension ".md" with any case is a valid markdown file
  return typeof file === "string" && file.toLowerCase().endsWith(".md");
}

export function readme(file?: string): boolean {
  // Filename "readme.md" with any case is a valid README file
  return typeof file === "string" && file.toLowerCase().endsWith("readme.md");
}

export function tsp(file: string): boolean {
  return typeof file === "string" && file.toLowerCase().endsWith(".tsp");
}

export function tspconfig(file: string): boolean {
  return typeof file === "string" && file.toLowerCase().endsWith("tspconfig.yaml");
}

export function typespec(file: string): boolean {
  return typeof file === "string" && (tsp(file) || tspconfig(file));
}

export function dataPlane(file?: string): boolean {
  // Folder name "data-plane" should match case for consistency across specs
  return typeof file === "string" && includesSegment(file, "data-plane");
}

export function resourceManager(file?: string): boolean {
  // Folder name "resource-manager" should match case for consistency across specs
  return typeof file === "string" && includesSegment(file, "resource-manager");
}

export function preview(file?: string): boolean {
  // Folder name "preview" should match case for consistency across specs
  return typeof file === "string" && includesSegment(file, "preview");
}

export function stable(file?: string): boolean {
  // Folder name "stable" should match case for consistency across specs
  return typeof file === "string" && includesSegment(file, "stable");
}

export function example(file?: string): boolean {
  return (
    typeof file === "string" &&
    // Intentionally use un-resolved path as key for perf, since we are OK
    // caching the same result for different representations of the same path.
    exampleCache.getOrCreate(
      file,
      // Folder name "examples" should match case for consistency across specs
      () => json(file) && includesSegment(file, "examples"),
    )
  );
}

export function quickstartTemplate(file?: string): boolean {
  return typeof file === "string" && json(file) && file.includes("/quickstart-templates/");
}

export function swagger(file?: string): boolean {
  return (
    typeof file === "string" &&
    json(file) &&
    (dataPlane(file) || resourceManager(file)) &&
    !example(file) &&
    !quickstartTemplate(file) &&
    !scenario(file)
  );
}

export function scenario(file?: string): boolean {
  return typeof file === "string" && json(file) && includesSegment(file, "scenarios");
}
