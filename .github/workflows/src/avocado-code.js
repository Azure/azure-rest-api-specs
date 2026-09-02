import { access, constants, lstat, readFile } from "fs/promises";
import { load as yamlLoad } from "js-yaml";
import { dirname, join, resolve, sep } from "path";
import { inspect } from "util";
import * as z from "zod";
import {
  generateMarkdownTable,
  MessageLevel,
  MessageRecordSchema,
  MessageType,
} from "./message.js";
import { parse } from "./ndjson.js";

const SuppressionsFileSchema = z.array(
  z
    .object({
      tool: z.string(),
      path: z.string().optional(),
      paths: z.array(z.string()).optional(),
    })
    .passthrough(),
);

/**
 * Extracts a repository-relative specification path from an Avocado result URL.
 *
 * @param {string} url
 * @returns {string | undefined}
 */
export function extractSpecificationPath(url) {
  const marker = "specification/";
  const index = url.indexOf(marker);
  return index === -1 ? undefined : url.slice(index);
}

/**
 * Converts the path glob syntax used by suppressions.yaml into a regular expression.
 *
 * @param {string} pattern
 * @returns {RegExp}
 */
export function suppressionGlobToRegExp(pattern) {
  let expression = "^";
  for (let index = 0; index < pattern.length; index++) {
    const character = pattern[index];
    if (character === "*") {
      if (pattern[index + 1] === "*") {
        index++;
        if (pattern[index + 1] === "/") {
          index++;
          expression += "(?:.*/)?";
        } else {
          expression += ".*";
        }
      } else {
        expression += "[^/]*";
      }
    } else if (character === "?") {
      expression += "[^/]";
    } else {
      expression += character.replace(/[\\^$.[\]{}()+|]/g, "\\$&");
    }
  }
  return new RegExp(`${expression}$`);
}

/**
 * Finds suppressions.yaml files from the target path up to the file-system root.
 *
 * @param {string} filePath
 * @returns {Promise<string[]>}
 */
export async function findSuppressionsFiles(filePath) {
  const absolutePath = resolve(filePath);
  let stats;
  try {
    stats = await lstat(absolutePath);
  } catch {
    return [];
  }

  const suppressionsFiles = [];
  let currentDirectory = stats.isDirectory() ? absolutePath : dirname(absolutePath);
  while (true) {
    const suppressionsFile = join(currentDirectory, "suppressions.yaml");
    try {
      await access(suppressionsFile, constants.R_OK);
      suppressionsFiles.push(suppressionsFile);
    } catch {
      // Continue walking toward the root when this directory has no suppressions file.
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
 * Checks whether a Swagger file has an applicable file-level Avocado suppression.
 *
 * @param {string} filePath
 * @returns {Promise<boolean>}
 */
export async function isFileSuppressed(filePath) {
  const absolutePath = resolve(filePath).split(sep).join("/");
  for (const suppressionsFile of await findSuppressionsFiles(absolutePath)) {
    const entries = SuppressionsFileSchema.parse(
      yamlLoad(await readFile(suppressionsFile, { encoding: "utf-8" })),
    );

    for (const entry of entries) {
      if (entry.tool !== "Swagger Avocado") {
        continue;
      }

      const paths = entry.paths ?? [];
      if (entry.path !== undefined) {
        paths.unshift(entry.path);
      }
      if (
        paths.some((path) => {
          const pattern = resolve(dirname(suppressionsFile), path).split(sep).join("/");
          return suppressionGlobToRegExp(pattern).test(absolutePath);
        })
      ) {
        return true;
      }
    }
  }
  return false;
}

/**
 * Checks whether an Avocado result is covered by a file-level suppression.
 *
 * @param {import("./message.js").ResultMessageRecord} message
 * @param {string} workspaceRoot
 * @returns {Promise<boolean>}
 */
export async function isResultSuppressed(message, workspaceRoot) {
  const pathUrl =
    message.paths.find((path) => path.tag === "json")?.path ??
    message.paths.find((path) => path.tag === "folder" || path.tag === "readme")?.path;
  if (!pathUrl) {
    return false;
  }

  const relativePath = extractSpecificationPath(pathUrl);
  if (!relativePath) {
    return false;
  }

  return isFileSuppressed(join(workspaceRoot, relativePath));
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

  const errorMessages = messages.filter(
    (message) => message.type === MessageType.Result && message.level === MessageLevel.Error,
  );
  const workspaceRoot = process.env.GITHUB_WORKSPACE ?? process.cwd();
  const suppressionResults = await Promise.all(
    errorMessages.map(async (message) => ({
      suppressed: await isResultSuppressed(
        /** @type {import("./message.js").ResultMessageRecord} */ (message),
        workspaceRoot,
      ),
    })),
  );
  const unsuppressedErrorCount = suppressionResults.filter((result) => !result.suppressed).length;

  if (unsuppressedErrorCount > 0) {
    core.setFailed(
      `Avocado found ${unsuppressedErrorCount} unsuppressed error(s). See the job summary for details.`,
    );
  }
}
