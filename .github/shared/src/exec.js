import child_process from "child_process";
import spawn from "cross-spawn";
import { dirname, join } from "path";
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
 * @property {string} [prefix] Prefix to pass to the package manager via "--prefix".
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
 * Calls `execFile()` with appropriate arguments to run `npm` on all platforms
 *
 * @param {string[]} args
 * @param {ExecNpmOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execNpm(args, options = {}) {
  const { prefix } = options;

  // Exclude platform-specific code from coverage
  /* v8 ignore start */
  const { file, defaultArgs } =
    process.platform === "win32"
      ? {
          // Only way I could find to run "npm" on Windows, without using the shell (e.g. "cmd /c npm ...")
          //
          // "node.exe", ["--", "npm-cli.js", ...args]
          //
          // The "--" MUST come BEFORE "npm-cli.js", to ensure args are sent to the script unchanged.
          // If the "--" comes after "npm-cli.js", the args sent to the script will be ["--", ...args],
          // which is NOT equivalent, and can break if args itself contains another "--".

          // example: "C:\Program Files\nodejs\node.exe"
          file: process.execPath,

          // example: "C:\Program Files\nodejs\node_modules\npm\bin\npm-cli.js"
          defaultArgs: [
            "--",
            join(dirname(process.execPath), "node_modules", "npm", "bin", "npm-cli.js"),
          ],
        }
      : { file: "npm", defaultArgs: [] };
  /* v8 ignore stop */

  const prefixArgs = prefix ? ["--prefix", prefix] : [];

  return await execFile(file, [...defaultArgs, ...prefixArgs, ...args], options);
}

/**
 * Calls `execNpm()` with arguments ["exec", "--no", "--"] prepended.
 *
 * @param {string[]} args
 * @param {ExecNpmOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execNpmExec(args, options = {}) {
  return await execNpm(["exec", "--no", "--", ...args], options);
}

/**
 * Calls `cross-spawn` with appropriate arguments to run `pnpm` on all platforms.
 *
 * Uses `cross-spawn` instead of `child_process.execFile()` so that the `pnpm.cmd`
 * batch shim can be resolved and launched safely on Windows without enabling a
 * shell. Enabling a shell (e.g. `shell: true`) would reintroduce quoting and
 * shell-parsing risks, so it is intentionally avoided.
 *
 * @param {string[]} args
 * @param {ExecNpmOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execPnpm(args, options = {}) {
  const { prefix, cwd, logger, maxBuffer = 16 * 1024 * 1024 } = options;

  const prefixArgs = prefix ? ["--prefix", prefix] : [];
  const allArgs = [...prefixArgs, ...args];

  logger?.info(`execPnpm(${JSON.stringify(allArgs)})`);

  return await new Promise((resolve, reject) => {
    // cross-spawn resolves "pnpm" to the "pnpm.cmd" shim on Windows and spawns it
    // directly (shell disabled), avoiding shell quoting/parsing risks while still
    // working cross-platform.
    const child = spawn("pnpm", allArgs, { cwd });

    let stdout = "";
    let stderr = "";
    let settled = false;

    /**
     * Ensures the promise is settled at most once, even though several events
     * (data overflow, error, close) may fire after the result is known.
     *
     * @param {() => void} action
     */
    const settle = (action) => {
      if (settled) return;
      settled = true;
      action();
    };

    /** @param {ExecError} error */
    const fail = (error) =>
      settle(() => {
        error.stdout = stdout;
        error.stderr = stderr;
        logger?.debug(`error: '${JSON.stringify(error)}'`);
        reject(error);
      });

    /** @param {"stdout" | "stderr"} streamName */
    const failMaxBuffer = (streamName) => {
      child.kill();
      const error = /** @type {ExecError} */ (new Error(`${streamName} maxBuffer length exceeded`));
      error.code = /** @type {any} */ ("ERR_CHILD_PROCESS_STDIO_MAXBUFFER");
      fail(error);
    };

    child.stdout?.on("data", (data) => {
      stdout += data;
      if (Buffer.byteLength(stdout) > maxBuffer) failMaxBuffer("stdout");
    });

    child.stderr?.on("data", (data) => {
      stderr += data;
      if (Buffer.byteLength(stderr) > maxBuffer) failMaxBuffer("stderr");
    });

    // Only fires if the process could not be spawned at all (e.g. "pnpm" missing).
    /* v8 ignore next */
    child.on("error", (error) => fail(/** @type {ExecError} */ (error)));

    child.on("close", (code) => {
      logger?.debug(`stdout: '${stdout}'`);
      logger?.debug(`stderr: '${stderr}'`);

      if (code === 0) {
        settle(() => resolve({ stdout, stderr }));
      } else {
        // Match the error contract of execFile()/execNpm(), whose message embeds
        // stderr (e.g. "Command failed: ...\n<stderr>"), so callers asserting on
        // the thrown message keep working regardless of npm vs pnpm backend.
        const error = /** @type {ExecError} */ (
          new Error(
            `pnpm ${allArgs.join(" ")} exited with code ${code}${stderr ? `\n${stderr}` : ""}`,
          )
        );
        error.code = /** @type {any} */ (code);
        fail(error);
      }
    });
  });
}

/**
 * Calls `execPnpm()` with arguments ["exec", ...] prepended.
 *
 * @param {string[]} args
 * @param {ExecNpmOptions} [options]
 * @returns {Promise<ExecResult>}
 * @throws {ExecError}
 */
export async function execPnpmExec(args, options = {}) {
  return await execPnpm(["exec", ...args], options);
}
