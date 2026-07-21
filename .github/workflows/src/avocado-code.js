import { access, constants, lstat, readFile } from "fs/promises";
import { dirname, join, resolve, sep } from "path";
import { sep as posixSep } from "path/posix";
import { inspect } from "util";
import { load as yamlLoad } from "js-yaml";
import { minimatch } from "minimatch";
import {
  generateMarkdownTable,
  MessageLevel,
  MessageRecordSchema,
  MessageType,
} from "./message.js";
import { parse } from "./ndjson.js";

/**
 * Finds all suppressions.yaml files in the directory tree from the given path up to the root.
 *
 * @param {string} filePath - Absolute path to a file or directory.
 * @returns {Promise<string[]>} Ordered list of suppressions.yaml paths (closest first).
 */
export async function findSuppressionsFiles(filePath) {
  filePath = resolve(filePath);
  const suppressionsFiles = [];
  let stats;
  try {
    stats = await lstat(filePath);
  } catch {
    return suppressionsFiles;
  }
  let currentDirectory = stats.isDirectory() ? filePath : dirname(filePath);

  while (true) {
    const suppressionsFile = join(currentDirectory, "suppressions.yaml");
    try {
      await access(suppressionsFile, constants.R_OK);
      suppressionsFiles.push(suppressionsFile);
    } catch {
      // File does not exist or is not readable
    }

    const parentDirectory = dirname(currentDirectory);
    if (parentDirectory === currentDirectory) {
      break;
    }
    currentDirectory = parentDirectory;
  }

  return suppressionsFiles;
}

/**
 * Returns true if the file at the given absolute path has a "Swagger Avocado" suppression
 * in any applicable suppressions.yaml.
 *
 * @param {string} absoluteFilePath - Absolute path to the file being checked.
 * @returns {Promise<boolean>}
 */
export async function isFileSuppressedForAvocado(absoluteFilePath) {
  const suppressionsFiles = await findSuppressionsFiles(absoluteFilePath);
  const pathPosix = resolve(absoluteFilePath).split(sep).join(posixSep);

  for (const suppressionsFile of suppressionsFiles) {
    let yaml;
    try {
      yaml = await readFile(suppressionsFile, { encoding: "utf-8" });
    } catch {
      continue;
    }

    const parsed = yamlLoad(yaml) ?? [];
    if (!Array.isArray(parsed)) continue;

    for (const s of parsed) {
      if (!s || typeof s !== "object" || s.tool !== "Swagger Avocado") continue;

      const paths = Array.from(s.paths ?? []);
      if (s.path) paths.unshift(s.path);

      for (const suppressionPath of paths) {
        const pattern = join(dirname(suppressionsFile), suppressionPath)
          .split(sep)
          .join(posixSep);
        if (minimatch(pathPosix, pattern)) {
          return true;
        }
      }
    }
  }

  return false;
}

/**
 * Extracts the local repository-relative path from an avocado path URL.
 * URLs look like: https://github.com/{repo}/blob/{sha}/specification/...
 *
 * @param {string} url - The URL from an avocado result message's paths array.
 * @returns {string | undefined} The relative path (e.g. "specification/..."), or undefined.
 */
export function extractRelativePathFromUrl(url) {
  if (!url) return undefined;
  const match = url.match(/\/blob\/[^/]+\/(specification\/.+)/);
  return match ? match[1] : undefined;
}

/**
 * Checks if an error result message is suppressed via suppressions.yaml.
 *
 * @param {import('./message.js').ResultMessageRecord} message
 * @param {string} workspaceRoot - Absolute path to repository root.
 * @returns {Promise<boolean>}
 */
export async function isResultSuppressed(message, workspaceRoot) {
  // Find the "json" path first (most specific), then fall back to "folder" or "readme"
  const jsonPath = message.paths?.find((p) => p.tag === "json")?.path;
  const folderPath = message.paths?.find(
    (p) => p.tag === "folder" || p.tag === "readme",
  )?.path;
  const pathUrl = jsonPath ?? folderPath;

  if (!pathUrl) return false;

  const relativePath = extractRelativePathFromUrl(pathUrl);
  if (!relativePath) return false;

  const absolutePath = join(workspaceRoot, relativePath);
  return isFileSuppressedForAvocado(absolutePath);
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function generateJobSummary({ core }) {
  const avocadoOutputFile = process.env.AVOCADO_OUTPUT_FILE;
  core.info(`avocadoOutputFile: ${avocadoOutputFile}`);

  if (!avocadoOutputFile) {
    throw new Error("Env var AVOCADO_OUTPUT_FILE must be set");
  }

  /** @type {string} */
  let content;

  try {
    core.info(`readfile(${avocadoOutputFile})`);
    content = await readFile(avocadoOutputFile, { encoding: "utf-8" });
    core.info(`content:\n${content}`);
  } catch (error) {
    // If we can't read the file, the previous step must have failed catastrophically.
    // generateJobSummary() should never fail, so just log the error and return
    core.info(`Error reading '${avocadoOutputFile}': ${inspect(error)}`);
    return;
  }

  const messages = parse(content).map((obj) => MessageRecordSchema.parse(obj));

  if (messages.length === 0) {
    // Should never happen, but if it does, just log the error and return.
    core.notice(`No messages in '${avocadoOutputFile}'`);
    return;
  } else if (
    messages.length === 1 &&
    messages[0].type === MessageType.Raw &&
    messages[0].level === MessageLevel.Info &&
    messages[0].message.toLowerCase() === "success"
  ) {
    // Special-case marker message for success
    core.summary.addRaw("Success");
  } else {
    core.summary.addRaw(generateMarkdownTable(messages));
  }

  await core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);

  // Determine whether the job should fail based on unsuppressed error messages
  const workspaceRoot = process.env.GITHUB_WORKSPACE ?? process.cwd();
  const errorMessages = messages.filter(
    (m) => m.type === MessageType.Result && m.level === MessageLevel.Error,
  );

  const suppressionResults = await Promise.all(
    errorMessages.map(async (m) => ({
      message: m,
      suppressed: await isResultSuppressed(
        /** @type {import('./message.js').ResultMessageRecord} */ (m),
        workspaceRoot,
      ),
    })),
  );

  const suppressedCount = suppressionResults.filter((r) => r.suppressed).length;
  const unsuppressedErrors = suppressionResults.filter((r) => !r.suppressed);

  if (suppressedCount > 0) {
    core.info(
      `${suppressedCount} error(s) suppressed via suppressions.yaml with 'tool: Swagger Avocado'`,
    );
  }

  if (unsuppressedErrors.length > 0) {
    core.setFailed(
      `Avocado found ${unsuppressedErrors.length} error(s). ` +
        `See job summary for details. ` +
        `To suppress intentional errors, add entries to suppressions.yaml with 'tool: Swagger Avocado'.`,
    );
  }
}
