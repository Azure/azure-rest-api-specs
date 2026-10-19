/**
 * Sets up the local evaluation environment:
 * 1. Selects the prebuilt MCP Vally environment.
 * 2. Verifies a pinned prebuilt MCP artifact supplied by the caller.
 * 3. Installs the spec repository's pinned pnpm and frozen workspace dependencies.
 * 4. Generates fixture metadata from the current checkout and copies its instructions.
 * 5. Verifies fixture dependencies and outputs variables for local Vally runs.
 */
import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDir, "../../../../..");
const evalsDir = path.resolve(scriptDir, "../evals");
const fixtureRoot = path.resolve(scriptDir, "../fixtures/Microsoft.Widget/Widget");
const evalToolsDir = path.join(repoRoot, "eng", "common", "scripts", "eval");

const kindArgIndex = process.argv.indexOf("--mcp-kind");
const mcpKind = kindArgIndex === -1 ? undefined : process.argv[kindArgIndex + 1];
const rootArgIndex = process.argv.indexOf("--mcp-root");
const suppliedMcpRoot =
  rootArgIndex === -1 ? process.env.AZSDK_EVAL_MCP_ROOT : process.argv[rootArgIndex + 1];
const mcpRoot = path.resolve(suppliedMcpRoot || path.join(repoRoot, "artifacts", "mcp"));
if (
  !["live", "mock"].includes(mcpKind) ||
  (rootArgIndex !== -1 && !process.argv[rootArgIndex + 1])
) {
  process.stderr.write(
    "Usage: node scripts/setup-environment.js --mcp-kind live|mock [--mcp-root <path>]\n",
  );
  process.exit(1);
}

/**
 * @param {string} command
 * @param {string[]} args
 * @param {import("node:child_process").ExecFileSyncOptions} [options]
 */
function run(command, args, options = {}) {
  process.stderr.write(`> ${command} ${args.join(" ")}\n`);
  execFileSync(command, args, {
    stdio: ["inherit", 2, "inherit"],
    ...options,
  });
}

/**
 * @param {string[]} args
 * @param {import("node:child_process").ExecFileSyncOptions} [options]
 */
function runPnpm(args, options = {}) {
  if (process.platform === "win32") {
    run(process.env.ComSpec || "cmd.exe", ["/d", "/s", "/c", `pnpm ${args.join(" ")}`], options);
    return;
  }
  run("pnpm", args, options);
}

/**
 * @param {string[]} args
 * @param {import("node:child_process").ExecFileSyncOptions} [options]
 */
function runNpm(args, options = {}) {
  if (process.platform === "win32") {
    run(process.env.ComSpec || "cmd.exe", ["/d", "/s", "/c", `npm ${args.join(" ")}`], options);
    return;
  }
  run("npm", args, options);
}

const evalEnvironment = mcpKind === "live" ? "azsdk-mcp-local" : "azsdk-mcp-mock-local";
for (const fileName of fs.readdirSync(evalsDir).filter((name) => name.endsWith(".eval.yaml"))) {
  const filePath = path.join(evalsDir, fileName);
  const content = fs.readFileSync(filePath, "utf8");
  const environmentPattern = /^environment:[ \t]+\S+[ \t]*(?=\r?$)/m;
  if (!environmentPattern.test(content)) {
    continue;
  }
  const updatedContent = content.replace(environmentPattern, `environment: ${evalEnvironment}`);
  if (updatedContent !== content) {
    fs.writeFileSync(filePath, updatedContent);
  }
}
process.stderr.write(`==> Using local prebuilt MCP startup (${evalEnvironment}).\n`);

process.stderr.write("==> Installing the repository-pinned Vally toolchain...\n");
runNpm(["ci", "--no-audit", "--no-fund"], { cwd: evalToolsDir });
const vallyExecutable = path.join(
  evalToolsDir,
  "node_modules",
  ".bin",
  process.platform === "win32" ? "vally.cmd" : "vally",
);
const vallyVersion =
  process.platform === "win32"
    ? execFileSync(
        process.env.ComSpec || "cmd.exe",
        ["/d", "/s", "/c", "node_modules\\.bin\\vally.cmd --version"],
        { cwd: evalToolsDir, encoding: "utf8" },
      ).trim()
    : execFileSync(vallyExecutable, ["--version"], { encoding: "utf8" }).trim();
if (vallyVersion !== "0.14.0") {
  throw new Error(
    `The repository-pinned Vally executable must be 0.14.0; resolved ${vallyVersion || "no version"} from ${vallyExecutable}.`,
  );
}
process.stderr.write(`==> Using Vally ${vallyVersion} from ${vallyExecutable}.\n`);

const mcpBinary =
  mcpKind === "live"
    ? path.join(mcpRoot, "cli", "azsdk.dll")
    : path.join(mcpRoot, "mock", "azsdk-mock.dll");
if (!fs.existsSync(mcpBinary)) {
  throw new Error(
    `Pinned prebuilt ${mcpKind} MCP artifact is missing: ${mcpBinary}. ` +
      "Supply an approved artifact with --mcp-root; setup does not clone or build azure-sdk-tools.",
  );
}
process.stderr.write(`==> Using prebuilt MCP artifact ${mcpBinary}.\n`);

process.stderr.write("==> Installing frozen spec repository dependencies with pnpm...\n");
run(process.execPath, [path.join(repoRoot, "eng", "scripts", "install-pnpm.mts")], {
  cwd: repoRoot,
});
runPnpm(["install", "--frozen-lockfile"], { cwd: repoRoot });

process.stderr.write("==> Preparing fixture files from the current checkout...\n");
run(process.execPath, [path.join(scriptDir, "setup-fixture-files.js")], {
  cwd: repoRoot,
});
run(process.execPath, [path.join(scriptDir, "check-node-dependencies.js"), "packages"], {
  cwd: fixtureRoot,
  env: {
    ...process.env,
    FIXTURE_NODE_MODULES: path.join(repoRoot, "node_modules"),
  },
});

const nodeModules = path.join(repoRoot, "node_modules");
const nodeBin = path.join(nodeModules, ".bin");
const evalToolsBin = path.dirname(vallyExecutable);
const shell = process.env.SHELL ?? "";
const isPowerShell = !shell && process.platform === "win32" && !process.env.BASH;
if (isPowerShell) {
  console.log(`$env:AZSDK_EVAL_REPO_ROOT="${repoRoot}"`);
  console.log(`$env:AZSDK_EVAL_MCP_ROOT="${mcpRoot}"`);
  console.log(`$env:FIXTURE_NODE_MODULES="${nodeModules}"`);
  console.log(`$env:PATH="${evalToolsBin};${nodeBin};$env:PATH"`);
} else {
  console.log(`export AZSDK_EVAL_REPO_ROOT="${repoRoot}"`);
  console.log(`export AZSDK_EVAL_MCP_ROOT="${mcpRoot}"`);
  console.log(`export FIXTURE_NODE_MODULES="${nodeModules}"`);
  console.log(`export PATH="${evalToolsBin}:${nodeBin}:$PATH"`);
}
process.stderr.write("==> Setup complete.\n");
