import { spawnSync } from "node:child_process";
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { isRecord, readJsonObject } from "./cli.mjs";

/**
 * @typedef {{
 *   executable: string,
 *   args: string[],
 *   displayExecutable: string
 * }} CompilerCommand
 * @typedef {{
 *   status: "succeeded" | "failed",
 *   command: {executable: string, args: string[]},
 *   exitCode: number | null,
 *   durationMs: number,
 *   configPath: string,
 *   configHash: string,
 *   logPath: string
 * }} EmitterRun
 * @typedef {{
 *   path: string,
 *   apiVersion?: string,
 *   documentRole: "common" | "primary" | "feature",
 *   contentHash: string
 * }} OpenApiArtifact
 */

/**
 * @param {string} file
 * @returns {string}
 */
function hashFile(file) {
  return crypto.createHash("sha256").update(fs.readFileSync(file)).digest("hex");
}

/**
 * @param {string} root
 * @param {(file: string) => boolean} predicate
 * @returns {string[]}
 */
function findFiles(root, predicate) {
  if (!fs.existsSync(root)) return [];
  /** @type {string[]} */
  const files = [];
  /** @param {string} directory */
  const visit = (directory) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const fullPath = path.join(directory, entry.name);
      if (entry.isDirectory()) visit(fullPath);
      else if (predicate(fullPath)) files.push(fullPath);
    }
  };
  visit(root);
  return files.sort();
}

/**
 * @param {string} worktree
 * @param {{platform?: NodeJS.Platform, execPath?: string}} [options]
 * @returns {CompilerCommand}
 */
export function resolveTsp(
  worktree,
  { platform = process.platform, execPath = process.execPath } = {},
) {
  const candidates = [
    ...(platform === "win32" ? [path.join(worktree, "node_modules", ".bin", "tsp.cmd")] : []),
    path.join(worktree, "node_modules", ".bin", "tsp"),
  ];
  const displayExecutable = candidates.find(fs.existsSync);
  if (!displayExecutable) {
    throw new Error(`TypeSpec compiler not found under ${worktree}\\node_modules\\.bin.`);
  }
  if (platform !== "win32") {
    return { executable: displayExecutable, args: [], displayExecutable };
  }
  const packageRoot = path.join(worktree, "node_modules", "@typespec", "compiler");
  const manifestPath = path.join(packageRoot, "package.json");
  if (!fs.existsSync(manifestPath)) {
    throw new Error(`TypeSpec compiler package manifest not found at ${manifestPath}.`);
  }
  const manifest = readJsonObject(manifestPath);
  const binValue = manifest.bin;
  const bin =
    typeof binValue === "string"
      ? binValue
      : isRecord(binValue) && typeof binValue.tsp === "string"
        ? binValue.tsp
        : undefined;
  const cli = bin && path.resolve(packageRoot, bin);
  if (!cli || !fs.existsSync(cli)) {
    throw new Error(`TypeSpec compiler CLI is unavailable in ${manifestPath}.`);
  }
  return { executable: execPath, args: [cli], displayExecutable };
}

/**
 * @param {{
 *   worktree: string,
 *   project: string,
 *   emitter: string,
 *   output: string,
 *   log: string,
 *   apiVersion?: string,
 *   workRoot: string
 * }} options
 * @returns {EmitterRun}
 */
function runEmitter({ worktree, project, emitter, output, log, apiVersion, workRoot }) {
  fs.mkdirSync(output, { recursive: true });
  fs.mkdirSync(path.dirname(log), { recursive: true });
  const command = resolveTsp(worktree);
  const args = [
    "compile",
    path.join(worktree, project),
    `--emit=${emitter}`,
    `--option=${emitter}.emitter-output-dir=${output}`,
    "--warn-as-error",
  ];
  if (emitter === "@azure-tools/typespec-client-generator-core") {
    const emptyExamples = path.join(workRoot, "inputs", "empty-examples");
    fs.mkdirSync(emptyExamples, { recursive: true });
    const projectExamples = path.join(worktree, project, "examples");
    if (fs.existsSync(projectExamples)) {
      for (const entry of fs.readdirSync(projectExamples, { withFileTypes: true })) {
        if (entry.isDirectory())
          fs.mkdirSync(path.join(emptyExamples, entry.name), { recursive: true });
      }
    }
    if (apiVersion) fs.mkdirSync(path.join(emptyExamples, apiVersion), { recursive: true });
    args.push(`--option=${emitter}.examples-dir=${emptyExamples}`);
  }
  if (apiVersion) {
    const option =
      emitter === "@azure-tools/typespec-client-generator-core" ? "api-version" : "version";
    args.push(`--option=${emitter}.${option}=${apiVersion}`);
  }
  const started = performance.now();
  const result = spawnSync(command.executable, [...command.args, ...args], {
    cwd: worktree,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
  });
  const durationMs = Math.round(performance.now() - started);
  fs.writeFileSync(
    log,
    [`> ${command.displayExecutable} ${args.join(" ")}`, result.stdout, result.stderr]
      .filter(Boolean)
      .join("\n"),
  );
  return {
    status: result.status === 0 ? "succeeded" : "failed",
    command: { executable: path.relative(worktree, command.displayExecutable), args },
    exitCode: result.status,
    durationMs,
    configPath: path.relative(workRoot, path.join(worktree, project, "tspconfig.yaml")),
    configHash: hashFile(path.join(worktree, project, "tspconfig.yaml")),
    logPath: path.relative(workRoot, log),
  };
}

/**
 * @param {string} output
 * @param {string} workRoot
 * @returns {OpenApiArtifact[]}
 */
function describeAutorest(output, workRoot) {
  return findFiles(output, (file) => file.endsWith(".json"))
    .map(
      /** @returns {OpenApiArtifact | null} */ (file) => {
        try {
          const document = readJsonObject(file);
          if (document.swagger !== "2.0") return null;
          const info = isRecord(document.info) ? document.info : undefined;
          const name = path.basename(file).toLowerCase();
          return {
            path: path.relative(workRoot, file),
            ...(typeof info?.version === "string" ? { apiVersion: info.version } : {}),
            documentRole: name.includes("common")
              ? "common"
              : name === "openapi.json"
                ? "primary"
                : "feature",
            contentHash: hashFile(file),
          };
        } catch {
          return null;
        }
      },
    )
    .filter((value) => value !== null);
}

/**
 * @param {{
 *   worktree: string,
 *   project: string,
 *   projectId: string,
 *   comparisonRole: string,
 *   sourceRevision: string,
 *   sourceCommit: string,
 *   workRoot: string,
 *   apiVersion?: string
 * }} options
 */
export function runProjectCompilers({
  worktree,
  project,
  projectId,
  comparisonRole,
  sourceRevision,
  sourceCommit,
  workRoot,
  apiVersion,
}) {
  const base = path.join(workRoot, "projects", projectId, comparisonRole);
  const autorestOutput = path.join(base, "autorest");
  const tcgcOutput = path.join(base, "tcgc");
  const autorest = runEmitter({
    worktree,
    project,
    emitter: "@azure-tools/typespec-autorest",
    output: autorestOutput,
    log: path.join(workRoot, "logs", `${projectId}-${comparisonRole}-autorest.log`),
    apiVersion,
    workRoot,
  });
  const tcgc = runEmitter({
    worktree,
    project,
    emitter: "@azure-tools/typespec-client-generator-core",
    output: tcgcOutput,
    log: path.join(workRoot, "logs", `${projectId}-${comparisonRole}-tcgc.log`),
    apiVersion,
    workRoot,
  });
  return {
    comparisonRole,
    sourceRevision,
    sourceCommit,
    apiVersion,
    autorest: {
      ...autorest,
      comparisonRole,
      sourceRevision,
      sourceCommit,
      selectedApiVersion: apiVersion,
      format: "swagger-2.0",
      files: describeAutorest(base, workRoot).filter(
        (file) => !apiVersion || file.apiVersion === apiVersion,
      ),
      serviceManifestPath: findFiles(base, (file) => path.basename(file) === "service.yaml").map(
        (file) => path.relative(workRoot, file),
      )[0],
    },
    tcgc: {
      ...tcgc,
      comparisonRole,
      sourceRevision,
      sourceCommit,
      selectedApiVersion: apiVersion,
      format: "tcgc-yaml",
      files: findFiles(tcgcOutput, (file) => path.basename(file) === "tcgc-output.yaml").map(
        (file) => ({ path: path.relative(workRoot, file), contentHash: hashFile(file) }),
      ),
    },
  };
}
