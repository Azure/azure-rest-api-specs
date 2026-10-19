/**
 * Sets up the local evaluation environment:
 * 1. Selects the prebuilt MCP Vally environment.
 * 2. Sparse-clones azure-sdk-tools and builds the live and mock MCP binaries.
 * 3. Installs the spec repository's pinned pnpm and frozen workspace dependencies.
 * 4. Copies the current checkout's Copilot instructions into the fixture.
 * 5. Outputs the shell commands that configure local Vally runs.
 */
import { execFileSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDir, "../../../../..");
const evalsDir = path.resolve(scriptDir, "../evals");
const toolsRoot = path.resolve(repoRoot, "artifacts", "azure-sdk-tools");
const copilotNpmRegistryUrl =
  process.env.COPILOT_NPM_REGISTRY_URL ?? "https://packagefeedproxy.microsoft.io/npm/";
const pnpmCommand = process.platform === "win32" ? "pnpm.cmd" : "pnpm";

const kindArgIndex = process.argv.indexOf("--mcp-kind");
const mcpKind = kindArgIndex === -1 ? undefined : process.argv[kindArgIndex + 1];
if (!["live", "mock"].includes(mcpKind) || process.argv.length !== 4) {
  process.stderr.write("Usage: node scripts/setup-environment.js --mcp-kind live|mock\n");
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
    shell: process.platform === "win32",
    ...options,
  });
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

if (!fs.existsSync(path.join(toolsRoot, ".git"))) {
  fs.mkdirSync(path.dirname(toolsRoot), { recursive: true });
  run("git", [
    "clone",
    "--depth",
    "1",
    "--filter=blob:none",
    "--sparse",
    "https://github.com/Azure/azure-sdk-tools.git",
    toolsRoot,
  ]);
  run("git", ["-C", toolsRoot, "sparse-checkout", "set", "tools"]);
} else {
  run("git", ["-C", toolsRoot, "fetch", "--depth", "1", "origin", "main"]);
  run("git", ["-C", toolsRoot, "checkout", "--detach", "FETCH_HEAD"]);
}

process.stderr.write("==> Building prebuilt MCP binaries into artifacts/mcp...\n");
for (const [project, output] of [
  ["Azure.Sdk.Tools.Cli", "cli"],
  ["Azure.Sdk.Tools.Mock", "mock"],
]) {
  run(
    "dotnet",
    [
      "build",
      `tools/azsdk-cli/${project}`,
      "-c",
      "Release",
      "-o",
      path.join(repoRoot, "artifacts", "mcp", output),
      "--nologo",
      `/p:CopilotNpmRegistryUrl=${copilotNpmRegistryUrl}`,
    ],
    { cwd: toolsRoot },
  );
}

process.stderr.write("==> Installing frozen spec repository dependencies with pnpm...\n");
run(process.execPath, [path.join(repoRoot, "eng", "scripts", "install-pnpm.mts")], {
  cwd: repoRoot,
});
run(pnpmCommand, ["install", "--frozen-lockfile"], { cwd: repoRoot });

process.stderr.write("==> Preparing fixture files from the current checkout...\n");
run(process.execPath, [path.join(scriptDir, "setup-fixture-files.js")], {
  cwd: repoRoot,
});

const nodeModules = path.join(repoRoot, "node_modules");
const shell = process.env.SHELL ?? "";
const isPowerShell = !shell && process.platform === "win32" && !process.env.BASH;
if (isPowerShell) {
  console.log(`$env:AZSDK_EVAL_REPO_ROOT="${repoRoot}"`);
  console.log(`$env:FIXTURE_NODE_MODULES="${nodeModules}"`);
} else {
  console.log(`export AZSDK_EVAL_REPO_ROOT="${repoRoot}"`);
  console.log(`export FIXTURE_NODE_MODULES="${nodeModules}"`);
}
process.stderr.write("==> Setup complete.\n");
