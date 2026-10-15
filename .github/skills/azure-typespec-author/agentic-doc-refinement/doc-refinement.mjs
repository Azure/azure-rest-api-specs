#!/usr/bin/env node
// @ts-check
//
// Code-based agentic doc-refinement loop for the azure-typespec-author skill,
// driven programmatically by the GitHub Copilot SDK (@github/copilot-sdk).
//
// Vally needs the internal QA-bot KB backend + azsdk-cli MCP server. Step 3 runs
// on the tools repository's ADO benchmark pool using the skill from this repository.
//
// Steps (see README.md):
//   1. Agent updates reference documents          (prompts/01-update-reference-docs.md)
//   2. Agent updates the skill markdown if needed (prompts/02-update-skill.md)
//   3. Trigger the Vally benchmark pipeline      (ADO definition 8178)
//   4. Agent analyzes results / attributes gaps   (prompts/04-analyze-results.md)
//   5. Agent generates the gap report             (prompts/05-generate-report.md)
//
// Prereqs:
//   - `npm ci` in this folder (installs @github/copilot-sdk, the @github/copilot
//     CLI it spawns, and the artifact ZIP dependency).
//   - GitHub Copilot CLI authenticated (the SDK spawns the bundled copilot CLI), OR
//     pass a token via COPILOT_GITHUB_TOKEN. Override the CLI with COPILOT_CLI_PATH.
//   - For step 3: Azure CLI authenticated with access to the azure-sdk/internal
//     project, and the skill changes committed and pushed to a branch or PR ref.
//
// Usage:
//   npm run refine                                 # full loop via ADO pipeline
//   npm run refine -- --skip-eval                  # only steps 1-2
//   node doc-refinement.mjs --skip-eval            # only steps 1-2
//   node doc-refinement.mjs --skill-ref refs/heads/main
//   node doc-refinement.mjs --model gpt-5.5 --idle-timeout 1800
//   node doc-refinement.mjs --help

import { CopilotClient } from "@github/copilot-sdk";
import AdmZip from "adm-zip";
import { spawn } from "node:child_process";
import { readFile, mkdir, readdir, stat } from "node:fs/promises";
import { readFileSync, existsSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createRequire } from "node:module";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
// This folder: .github/skills/azure-typespec-author/agentic-doc-refinement → repo root is 4 up.
const REPO_ROOT = path.resolve(__dirname, "..", "..", "..", "..");
const SKILL_DIR = path.resolve(__dirname, ".."); // azure-typespec-author
const SKILLS_ROOT = path.resolve(__dirname, "..", ".."); // .github/skills
const PROMPTS_DIR = path.join(__dirname, "prompts");
const RESULT_DIR = path.join(__dirname, "results");
const ADO_ORGANIZATION = "azure-sdk";
const ADO_PROJECT = "internal";
const ADO_DEFINITION_ID = 8178;
const ADO_RESOURCE_ID = "499b84ac-1321-427f-aa17-267ca6975798";
const ADO_BUILD_TIMEOUT_MS = 4 * 60 * 60 * 1000;
const ADO_API_BASE = `https://dev.azure.com/${ADO_ORGANIZATION}/${ADO_PROJECT}/_apis`;
const UPSTREAM_REPOSITORY = "https://github.com/Azure/azure-rest-api-specs.git";
const EVALUATED_PATHS = [path.join(SKILL_DIR, "SKILL.md"), path.join(SKILL_DIR, "references")];
const EXPECTED_CODE_QUALITY_SUITES = [
  "versioning",
  "armtemplate",
  "lro",
  "decorators",
  "warning",
  "dataplane",
];

/** @param {unknown} value @returns {value is Record<string, unknown>} */
function isRecord(value) {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

/** @param {unknown} value @returns {value is unknown[]} */
function isArray(value) {
  return Array.isArray(value);
}

/** @param {string} text @returns {unknown} */
function parseJson(text) {
  return JSON.parse(text);
}

/** @param {unknown} value @param {string} label */
function requireRecord(value, label) {
  if (!isRecord(value)) throw new Error(`${label} must be a JSON object`);
  return value;
}

/** @param {unknown} value @param {string} label */
function requireString(value, label) {
  if (typeof value !== "string" || !value) {
    throw new Error(`${label} must be a non-empty string`);
  }
  return value;
}

/**
 * Resolve the Copilot CLI entry point from the installed @github/copilot package's
 * `bin` field. Returns undefined if it can't be found (SDK falls back to its own
 * resolver / COPILOT_CLI_PATH).
 * @returns {string | undefined}
 */
function resolveCopilotCliPath() {
  try {
    const require = createRequire(import.meta.url);
    const pkgJsonPath = require.resolve("@github/copilot/package.json");
    const pkgDir = path.dirname(pkgJsonPath);
    const pkg = requireRecord(parseJson(readFileSync(pkgJsonPath, "utf8")), "Copilot package");
    const binRel =
      typeof pkg.bin === "string"
        ? pkg.bin
        : isRecord(pkg.bin) && typeof pkg.bin.copilot === "string"
          ? pkg.bin.copilot
          : undefined;
    if (!binRel) return undefined;
    const binPath = path.join(pkgDir, binRel);
    return existsSync(binPath) ? binPath : undefined;
  } catch {
    return undefined;
  }
}

// -------------------------- arg parsing --------------------------
const HELP = `Usage: node doc-refinement.mjs [options]

Workflow:
  --skip-eval                Run steps 1-2 only; skip eval, analysis, and report (steps 3-5)

Evaluation:
  --skill-ref <ref>          Git branch or refs/pull/<number>/head to evaluate
  --results-dir <path>       Base directory for timestamped run outputs

Agent:
  --model <model>            Copilot model (default: AGENT_MODEL or gpt-5.5)
  --idle-timeout <seconds>   Agent idle timeout (default: 1800)

General:
  -h, --help                 Show this help

Examples:
  node doc-refinement.mjs
  node doc-refinement.mjs --skip-eval
  node doc-refinement.mjs --skill-ref refs/heads/main
`;

/** @param {string[]} argv */
function parseArgs(argv) {
  const args = [...argv];
  /** @param {string} option */
  const npmForwardingError = (option) =>
    `${option} was consumed by npm. Use direct node invocation or add a second separator: ` +
    `npm run refine -- -- ${option} <value>`;

  const npmModelConfig = process.env.npm_config_model;
  let npmModel;
  if (npmModelConfig && npmModelConfig !== "true") {
    npmModel = npmModelConfig;
  } else if (npmModelConfig === "true" && args.length === 1 && !args[0].startsWith("--")) {
    // npm 10 on Windows consumes option names after `npm run ... --` into
    // npm_config_* variables but forwards a space-separated option value.
    npmModel = args.shift();
  }

  if (process.env.npm_config_update_skill_only === "true") {
    throw new Error("--update-skill-only was removed; use --skip-eval");
  }
  if (process.env.npm_config_skip_docs === "true") {
    throw new Error("--skip-docs is no longer supported");
  }
  if (
    process.env.npm_config_skip_update === "true" ||
    process.env.npm_config_skip_report === "true"
  ) {
    throw new Error(
      "--skip-update and --skip-report are no longer supported; use --skip-eval to skip steps 3-5",
    );
  }
  if (process.env.npm_config_skill_ref === "true") {
    throw new Error(npmForwardingError("--skill-ref"));
  }
  if (process.env.npm_config_results_dir === "true") {
    throw new Error(npmForwardingError("--results-dir"));
  }
  if (process.env.npm_config_idle_timeout === "true") {
    throw new Error(npmForwardingError("--idle-timeout"));
  }

  const opts = {
    help: false,
    skipEval: process.env.npm_config_skip_eval === "true",
    skillRef:
      process.env.npm_config_skill_ref && process.env.npm_config_skill_ref !== "true"
        ? process.env.npm_config_skill_ref
        : null,
    resultsDir:
      process.env.npm_config_results_dir && process.env.npm_config_results_dir !== "true"
        ? path.resolve(process.env.npm_config_results_dir)
        : RESULT_DIR,
    model: process.env.AGENT_MODEL || npmModel || "gpt-5.5",
    idleTimeoutMs:
      Number(process.env.npm_config_idle_timeout || process.env.AGENT_IDLE_TIMEOUT_SEC || 1800) *
      1000,
  };

  /** @param {string} option @param {number} index */
  const takeValue = (option, index) => {
    const value = args[index + 1];
    if (!value || value.startsWith("--")) {
      throw new Error(`${option} requires a value`);
    }
    return value;
  };

  for (let i = 0; i < args.length; i++) {
    const a = args[i];
    if (a === "--update-skill-only") {
      throw new Error("--update-skill-only was removed; use --skip-eval");
    } else if (a === "--skip-docs") {
      throw new Error("--skip-docs is no longer supported");
    } else if (a === "--skip-update" || a === "--skip-report") {
      throw new Error(`${a} is no longer supported; use --skip-eval to skip steps 3-5`);
    } else if (a === "-h" || a === "--help") opts.help = true;
    else if (a === "--skip-eval") opts.skipEval = true;
    else if (a === "--skill-ref") {
      opts.skillRef = takeValue(a, i);
      i++;
    } else if (a === "--results-dir") {
      opts.resultsDir = path.resolve(takeValue(a, i));
      i++;
    } else if (a === "--model") {
      opts.model = takeValue(a, i);
      i++;
    } else if (a === "--idle-timeout") {
      opts.idleTimeoutMs = Number(takeValue(a, i)) * 1000;
      i++;
    } else throw new Error(`Unknown argument: ${a}`);
  }

  if (opts.help) return opts;
  if (!Number.isFinite(opts.idleTimeoutMs) || opts.idleTimeoutMs <= 0) {
    throw new Error("--idle-timeout must be a positive number");
  }
  return opts;
}

// -------------------------- helpers --------------------------
/** @param {string} msg */
function log(msg) {
  process.stderr.write(`\n\x1b[36m==> ${msg}\x1b[0m\n`);
}

function runId() {
  return new Date().toISOString().replace(/[:.]/g, "-");
}

/**
 * Run a command and return trimmed stdout.
 * @param {string} command
 * @param {string[]} args
 * @returns {Promise<string>}
 */
function runCommand(command, args) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      cwd: REPO_ROOT,
      shell: process.platform === "win32",
      stdio: ["ignore", "pipe", "pipe"],
    });
    let stdout = "";
    let stderr = "";
    child.stdout.on("data", (data) => (stdout += data));
    child.stderr.on("data", (data) => (stderr += data));
    child.on("error", reject);
    child.on("close", (code) => {
      if (code === 0) resolve(stdout.trim());
      else {
        reject(
          new Error(`${command} ${args.join(" ")} exited with code ${code}: ${stderr.trim()}`),
        );
      }
    });
  });
}

async function upstreamRemote() {
  for (const name of ["upstream", "origin"]) {
    try {
      const url = await runCommand("git", ["remote", "get-url", name]);
      if (
        url.replace(/\.git$/, "").toLowerCase() ===
        UPSTREAM_REPOSITORY.replace(/\.git$/, "").toLowerCase()
      ) {
        return name;
      }
    } catch {
      // Try the next conventional remote name.
    }
  }
  return UPSTREAM_REPOSITORY;
}

/** @param {string} remote @param {string} ref */
async function remoteRefSha(remote, ref) {
  const output = await runCommand("git", ["ls-remote", remote, ref]);
  const firstLine = output.split(/\r?\n/, 1)[0];
  if (!firstLine) throw new Error(`Remote ref not found: ${ref}`);
  return firstLine.split(/\s+/, 1)[0];
}

/** @param {string} ref */
function validateSkillRef(ref) {
  if (!/^[A-Za-z0-9._/-]+$/.test(ref)) {
    throw new Error(`Invalid skill ref: ${ref}`);
  }
}

/** @param {string | null} explicitRef */
async function resolveSkillRef(explicitRef) {
  const remote = await upstreamRemote();
  if (explicitRef) {
    validateSkillRef(explicitRef);
    const ref = explicitRef.startsWith("refs/") ? explicitRef : `refs/heads/${explicitRef}`;
    await remoteRefSha(remote, ref);
    return explicitRef;
  }

  const branch = await runCommand("git", ["branch", "--show-current"]);
  if (!branch) {
    throw new Error("Cannot infer the pipeline skill ref from a detached HEAD; pass --skill-ref");
  }
  validateSkillRef(branch);

  const branchRef = `refs/heads/${branch}`;
  try {
    const remoteSha = await remoteRefSha(remote, branchRef);
    const localSha = await runCommand("git", ["rev-parse", "HEAD"]);
    if (remoteSha !== localSha) {
      throw new Error(`Current branch '${branch}' is not pushed to the upstream repository`);
    }
    return branch;
  } catch (branchError) {
    try {
      const prNumber = await runCommand("gh", [
        "pr",
        "view",
        branch,
        "--repo",
        "Azure/azure-rest-api-specs",
        "--json",
        "number",
        "--jq",
        ".number",
      ]);
      const prRef = `refs/pull/${prNumber}/head`;
      const remoteSha = await remoteRefSha(remote, prRef);
      const localSha = await runCommand("git", ["rev-parse", "HEAD"]);
      if (remoteSha !== localSha) {
        throw new Error(`PR #${prNumber} does not contain the local HEAD`, { cause: branchError });
      }
      return prRef;
    } catch (prError) {
      throw new Error(
        `Cannot resolve a pushed pipeline ref for '${branch}'. Push the branch or ` +
          `open/update its PR, then pass --skill-ref if needed.\n` +
          `Branch check: ${String(branchError)}\nPR check: ${String(prError)}`,
        { cause: prError },
      );
    }
  }
}

async function ensureEvaluatedFilesAreCommitted() {
  const status = await runCommand("git", [
    "status",
    "--porcelain",
    "--untracked-files=all",
    "--",
    ...EVALUATED_PATHS,
  ]);
  if (status) {
    throw new Error(
      "The pipeline cannot evaluate local changes. Run with --skip-eval first, " +
        "review and commit/push SKILL.md and references/, then rerun.\n" +
        status,
    );
  }
}

function createAdoAuth() {
  let token = "";
  let expiresAt = 0;
  return {
    async token(forceRefresh = false) {
      if (!forceRefresh && token && Date.now() < expiresAt - 5 * 60 * 1000) {
        return token;
      }
      const response = requireRecord(
        parseJson(
          await runCommand("az", [
            "account",
            "get-access-token",
            "--resource",
            ADO_RESOURCE_ID,
            "--output",
            "json",
          ]),
        ),
        "Azure CLI access token response",
      );
      token = requireString(response.accessToken, "Azure CLI ADO access token");
      expiresAt =
        Number(response.expires_on) * 1000 ||
        (typeof response.expiresOn === "string" ? Date.parse(response.expiresOn) : NaN) ||
        Date.now() + 45 * 60 * 1000;
      return token;
    },
  };
}

/**
 * @param {string} url
 * @param {ReturnType<typeof createAdoAuth>} auth
 * @param {RequestInit} [options]
 */
async function adoRequest(url, auth, options = {}) {
  const send = async (forceRefresh = false) =>
    fetch(url, {
      ...options,
      headers: {
        Authorization: `Bearer ${await auth.token(forceRefresh)}`,
        ...(options.body ? { "Content-Type": "application/json" } : {}),
        ...options.headers,
      },
    });
  let response = await send();
  if (response.status === 401) response = await send(true);
  if (!response.ok) {
    throw new Error(
      `ADO request failed (${response.status} ${response.statusText}): ` +
        `${await response.text()}`,
    );
  }
  return response;
}

/** @param {number} buildId @param {ReturnType<typeof createAdoAuth>} auth */
async function waitForBuild(buildId, auth) {
  const url = `${ADO_API_BASE}/build/builds/${buildId}?api-version=7.0`;
  const deadline = Date.now() + ADO_BUILD_TIMEOUT_MS;
  while (true) {
    const build = requireRecord(await (await adoRequest(url, auth)).json(), "ADO build");
    if (requireString(build.status, "ADO build status") === "completed") {
      return { result: requireString(build.result, "ADO build result") };
    }
    if (Date.now() >= deadline) {
      throw new Error(`Timed out waiting for ADO build ${buildId}`);
    }
    await new Promise((resolve) => setTimeout(resolve, 60_000));
  }
}

/** @param {string} skillRef @param {string} outputDir */
async function runPipeline(skillRef, outputDir) {
  const auth = createAdoAuth();
  const queueUrl = `${ADO_API_BASE}/build/builds?api-version=7.0`;
  const body = {
    definition: { id: ADO_DEFINITION_ID },
    sourceBranch: "refs/heads/main",
    templateParameters: {
      SkillBranch: skillRef,
      SkillRepository: UPSTREAM_REPOSITORY,
    },
  };
  const queued = requireRecord(
    await (
      await adoRequest(queueUrl, auth, {
        method: "POST",
        body: JSON.stringify(body),
      })
    ).json(),
    "ADO queued build",
  );
  const buildId = queued.id;
  if (typeof buildId !== "number" || !Number.isSafeInteger(buildId) || buildId <= 0) {
    throw new Error("ADO queued build is missing a valid build ID");
  }
  const links = isRecord(queued._links) ? queued._links : undefined;
  const web = links && isRecord(links.web) ? links.web : undefined;
  const buildUrl =
    web && typeof web.href === "string" && web.href
      ? web.href
      : `https://dev.azure.com/${ADO_ORGANIZATION}/${ADO_PROJECT}/_build/results?buildId=${buildId}`;
  log(`ADO build queued: ${buildUrl}`);

  const build = await waitForBuild(buildId, auth);
  log(`ADO build completed: ${build.result}`);
  if (!["succeeded", "partiallySucceeded"].includes(build.result)) {
    throw new Error(`ADO build ${buildId} completed with result '${build.result}': ${buildUrl}`);
  }

  const artifactsUrl = `${ADO_API_BASE}/build/builds/${buildId}/artifacts?api-version=7.0`;
  const artifacts = requireRecord(
    await (await adoRequest(artifactsUrl, auth)).json(),
    "ADO artifacts",
  );
  if (!isArray(artifacts.value))
    throw new Error("ADO artifacts response is missing its value array");
  const artifactName = `eval-results-code-quality-${buildId}`;
  const artifact = artifacts.value.find((item) => isRecord(item) && item.name === artifactName);
  if (!isRecord(artifact) || !isRecord(artifact.resource)) {
    throw new Error(`Build ${buildId} did not publish artifact '${artifactName}': ${buildUrl}`);
  }

  const downloadUrl = requireString(artifact.resource.downloadUrl, "ADO artifact download URL");
  const zipResponse = await adoRequest(downloadUrl, auth);
  const zip = new AdmZip(Buffer.from(await zipResponse.arrayBuffer()));
  zip.extractAllTo(outputDir, true);
  return { buildId, buildUrl, result: build.result };
}

/** @param {string} name */
async function readPrompt(name) {
  return readFile(path.join(PROMPTS_DIR, name), "utf8");
}

/**
 * Return whether a requested path is contained by one of the allowed roots.
 * @param {string} requestedPath
 * @param {string[]} allowedRoots
 */
function isAllowedPath(requestedPath, allowedRoots) {
  const resolvedPath = path.resolve(REPO_ROOT, requestedPath);
  return allowedRoots.some((root) => {
    const relative = path.relative(root, resolvedPath);
    return relative === "" || (!relative.startsWith("..") && !path.isAbsolute(relative));
  });
}

/**
 * Create an autonomous agent session with least-privilege file access.
 * @param {CopilotClient} client
 * @param {{ model: string, idleTimeoutMs: number }} cfg
 * @param {{ read: string[], write: string[] }} allowedPaths
 */
async function createAgentSession(client, cfg, allowedPaths) {
  return client.createSession({
    model: cfg.model,
    workingDirectory: REPO_ROOT,
    skillDirectories: [SKILLS_ROOT],
    onPermissionRequest: (request) => {
      if (request.kind === "write") {
        const fileName = "fileName" in request ? request.fileName : null;
        if (typeof fileName === "string" && isAllowedPath(fileName, allowedPaths.write)) {
          return { kind: "approve-once" };
        }
        return {
          kind: "reject",
          feedback: "Writes are restricted to the workflow's approved output directories.",
        };
      }
      if (request.kind === "read") {
        const requestedPath = "path" in request ? request.path : null;
        if (typeof requestedPath === "string" && isAllowedPath(requestedPath, allowedPaths.read)) {
          return { kind: "approve-once" };
        }
        return {
          kind: "reject",
          feedback: "Local reads are restricted to the repository and workflow output.",
        };
      }
      if (request.kind === "mcp" || request.kind === "url") {
        return { kind: "approve-once" };
      }
      return {
        kind: "reject",
        feedback: "Shell and other unscoped tools are disabled for this autonomous workflow.",
      };
    },
    systemMessage: {
      mode: "append",
      content:
        "You are running fully autonomously in a script; never ask for confirmation " +
        "or further input. Make the edits directly, then stop. " +
        "Shell commands are disabled. " +
        "Leave every change unstaged in the working tree so the user can review and " +
        "decide whether to commit.",
    },
  });
}

/**
 * Run a single autonomous agent turn in an existing session.
 * @param {import("@github/copilot-sdk").CopilotSession} session
 * @param {string} prompt
 * @param {{ idleTimeoutMs: number }} cfg
 */
async function runAgent(session, prompt, cfg) {
  const result = await session.sendAndWait({ prompt }, cfg.idleTimeoutMs);
  return result?.data?.content ?? "";
}

/** Recursively collect every results.jsonl produced by Vally under a dir. @param {string} dir */
async function findResultFiles(dir) {
  /** @type {string[]} */
  const out = [];
  /** @param {string} d */
  async function walk(d) {
    let entries;
    try {
      entries = await readdir(d, { withFileTypes: true });
    } catch {
      return;
    }
    for (const e of entries) {
      const full = path.join(d, e.name);
      if (e.isDirectory()) await walk(full);
      else if (e.name === "results.jsonl") out.push(full);
    }
  }
  await walk(dir);
  return out;
}

/** @param {string[]} resultFiles */
async function validateResultSuites(resultFiles) {
  /** @type {Set<string>} */
  const suites = new Set();
  for (const resultFile of resultFiles) {
    const lines = (await readFile(resultFile, "utf8")).split(/\r?\n/);
    for (const line of lines) {
      if (!line.trim()) continue;
      /** @type {unknown} */
      let record;
      try {
        record = parseJson(line);
      } catch {
        continue;
      }
      if (!isRecord(record) || record.type !== "trial-result") continue;
      const trajectory = isRecord(record.trajectory) ? record.trajectory : undefined;
      const stimulus =
        trajectory && isRecord(trajectory.stimulus) ? trajectory.stimulus : undefined;
      const tags = stimulus && isRecord(stimulus.tags) ? stimulus.tags : undefined;
      if (tags && typeof tags.suite === "string" && tags.suite) suites.add(tags.suite);
      break;
    }
  }
  const missing = EXPECTED_CODE_QUALITY_SUITES.filter((suite) => !suites.has(suite));
  if (missing.length) {
    throw new Error(
      `Code-quality artifact is incomplete; missing suite results: ${missing.join(", ")}`,
    );
  }
}

// -------------------------- main --------------------------
async function main() {
  const opts = parseArgs(process.argv.slice(2));
  if (opts.help) {
    process.stdout.write(HELP);
    return;
  }

  const currentResultDir = path.join(opts.resultsDir, runId());
  const analysisPath = path.join(currentResultDir, "analysis.md");
  const reportPath = path.join(currentResultDir, "document-gaps.md");

  if (!opts.skipEval) {
    await mkdir(currentResultDir, { recursive: true });
  }

  log(
    `Doc-refinement loop | model=${opts.model} | ` +
      `evalAndReport=${!opts.skipEval} | ` +
      `results=${currentResultDir}`,
  );

  const cliPath = process.env.COPILOT_CLI_PATH || resolveCopilotCliPath();
  const client = new CopilotClient({
    ...(cliPath ? { cliPath } : {}),
    ...(process.env.COPILOT_GITHUB_TOKEN ? { gitHubToken: process.env.COPILOT_GITHUB_TOKEN } : {}),
  });

  try {
    await client.start();
    const auth = await client.getAuthStatus();
    if (!auth.isAuthenticated) {
      throw new Error(
        "GitHub Copilot is not authenticated. Run `copilot login`, or set COPILOT_GITHUB_TOKEN.",
      );
    }

    // ---- Steps 1-2: update reference documents and skill markdown ----
    const updateSession = await createAgentSession(client, opts, {
      read: [REPO_ROOT],
      write: [SKILL_DIR],
    });
    try {
      log("Step 1 — update reference documents");
      await runAgent(updateSession, await readPrompt("01-update-reference-docs.md"), opts);

      log("Step 2 — update skill markdown if needed");
      await runAgent(updateSession, await readPrompt("02-update-skill.md"), opts);
    } finally {
      await updateSession.disconnect();
    }

    if (opts.skipEval) {
      log("Skipping steps 3-5 (--skip-eval)");
      log("Done. Reference documents and skill markdown updated.");
      return;
    }

    // ---- Step 3: run Vally benchmark pipeline ----
    await ensureEvaluatedFilesAreCommitted();
    const skillRef = await resolveSkillRef(opts.skillRef);
    log(`Step 3 — trigger ADO benchmark pipeline for ${skillRef}`);
    const pipeline = await runPipeline(skillRef, currentResultDir);

    // ---- Step 4: analyze results ----
    const resultFiles = await findResultFiles(currentResultDir);
    if (resultFiles.length === 0) {
      throw new Error(
        `No results.jsonl found under ${currentResultDir}. Step 3 did not produce results.`,
      );
    }
    await validateResultSuites(resultFiles);
    log(`Step 4 — analyze ${resultFiles.length} result file(s)`);
    const analysisContext =
      `\n\nThe Vally results.jsonl files to analyze are:\n` +
      resultFiles.map((f) => `- ${f}`).join("\n") +
      `\n\nADO build: ${pipeline.buildUrl} (${pipeline.result}).` +
      `\n\nWrite your structured analysis to ${analysisPath}.`;
    const analysisSession = await createAgentSession(client, opts, {
      read: [REPO_ROOT, currentResultDir],
      write: [currentResultDir],
    });
    try {
      await runAgent(
        analysisSession,
        (await readPrompt("04-analyze-results.md")) + analysisContext,
        opts,
      );
      await stat(analysisPath).catch(() => {
        throw new Error(`Expected analysis was not written: ${analysisPath}`);
      });

      // ---- Step 5: generate the gap report ----
      log("Step 5 — generate documentation-gap report");
      const reportContext =
        `\n\nUse ${analysisPath} as the step-4 analysis input. ` +
        `Write the final report to ${reportPath}.`;
      await runAgent(
        analysisSession,
        (await readPrompt("05-generate-report.md")) + reportContext,
        opts,
      );

      await stat(reportPath).catch(() => {
        throw new Error(`Expected report was not written: ${reportPath}`);
      });
    } finally {
      await analysisSession.disconnect();
    }
    log(`Done. Report: ${reportPath}`);
  } finally {
    const errs = await client.stop().catch(() => []);
    if (errs && errs.length) {
      process.stderr.write(`Cleanup warnings: ${errs.map((e) => e.message).join("; ")}\n`);
    }
  }
}

main().catch((err) => {
  process.stderr.write(
    `\x1b[31mFAILED: ${err instanceof Error ? err.stack : String(err)}\x1b[0m\n`,
  );
  process.exit(1);
});
