import child_process from "child_process";
import { promisify } from "util";
const execFileImpl = promisify(child_process.execFile);

/**
 * @typedef {Object} ExecOptions
 * @property {string} [cwd] Current working directory.  Default: process.cwd().
 * @property {import('./logger.js').ILogger} [logger]
 * @property {number} [maxBuffer] Max bytes allowed on stdout or stderr.  Default: 16 * 1024 * 1024.
 */

/**
 * @typedef {Object} NpmPrefixOptions
 * @property {string} [prefix] Prefix to pass to pnpm via "--prefix".
 */

/**
 * @typedef {ExecOptions & NpmPrefixOptions} ExecNpmOptions
 */

/**
 * @typedef {Object} ExecResult
 * @property {string} stdout
 * @property {string} stderr
 */

/**
 * @typedef {Error & { stdout?: string, stderr?: string, code?: number }} ExecError
 */

/**
 * Checks whether an unknown error object is an ExecError.
 * @param {unknown} error
 * @returns {error is ExecError}
 */
export function isExecError(error) {
  if (!(error instanceof Error)) return false;

  const e = /** @type {ExecError} */ (error);
  return typeof e.stdout === "string" || typeof e.stderr === "string";
}

/**
 * Wraps `child_process.execFile()`, adding logging and a larger default maxBuffer.
 *
 * @param {string} file
 * @param {string[]} [args]
 * @param {ExecOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execFile(file, args, options = {}) {
  const {
    cwd,
    logger,
    // Node default is 1024 * 1024, which is too small for some git commands returning many entities or large file content.
    // To support "git show", should be larger than the largest swagger file in the repo (2.5 MB as of 2/28/2025).
    maxBuffer = 16 * 1024 * 1024,
  } = options;

  logger?.info(`execFile("${file}", ${JSON.stringify(args)})`);

  try {
    // execFile(file, args) is more secure than exec(cmd), since the latter is vulnerable to shell injection
    const result = await execFileImpl(file, args, {
      cwd,
      maxBuffer,
    });

    logger?.debug(`stdout: '${result.stdout}'`);
    logger?.debug(`stderr: '${result.stderr}'`);

    return result;
  } catch (error) {
    /* v8 ignore next */
    logger?.debug(`error: '${JSON.stringify(error)}'`);

    throw error;
  }
}

/**
 * Calls `execFile()` with appropriate arguments to run `pnpm` on all platforms
 *
 * @param {string[]} args
 * @param {ExecNpmOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execNpm(args, options = {}) {
  const { prefix, cwd, logger, maxBuffer = 16 * 1024 * 1024 } = options;

  const prefixArgs = prefix ? ["--prefix", prefix] : [];
  const allArgs = [...prefixArgs, ...args];

  logger?.info(`execNpm(${JSON.stringify(allArgs)})`);

  try {
    const isWindows = process.platform === "win32";

    // On Windows, pnpm is installed as the "pnpm.cmd" batch shim, which can only be
    // launched through a shell: since the fix for CVE-2024-27980, Node refuses to
    // spawn .cmd/.bat files unless shell is enabled. On other platforms, call the
    // "pnpm" binary directly with shell disabled to avoid shell quoting/parsing risks.
    // Exclude the platform-specific branch from coverage (only one side runs per OS).
    /* v8 ignore next */
    const file = isWindows ? "pnpm.cmd" : "pnpm";

    const result = await execFileImpl(file, allArgs, {
      cwd,
      maxBuffer,
      shell: isWindows,
    });

    logger?.debug(`stdout: '${result.stdout}'`);
    logger?.debug(`stderr: '${result.stderr}'`);

    return result;
  } catch (error) {
    /* v8 ignore next */
    logger?.debug(`error: '${JSON.stringify(error)}'`);
    throw error;
  }
}

/**
 * Calls `pnpm exec` with the given arguments.
 *
 * @param {string[]} args
 * @param {ExecNpmOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execNpmExec(args, options = {}) {
  return await execNpm(["exec", ...args], options);
}
