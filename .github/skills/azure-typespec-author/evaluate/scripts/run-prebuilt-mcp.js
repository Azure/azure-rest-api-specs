#!/usr/bin/env node

import { spawn } from "node:child_process";
import path from "node:path";

const mcpKind = process.env.AZSDK_EVAL_MCP_KIND;
const repoRoot = process.env.AZSDK_EVAL_REPO_ROOT || process.cwd();
if (!["live", "mock"].includes(mcpKind) || !repoRoot) {
  console.error("MCP kind must be live or mock, and the repository root must be available.");
  process.exit(1);
}

const serverCommand =
  mcpKind === "live"
    ? ["artifacts/mcp/cli/azsdk.dll", "start"]
    : ["artifacts/mcp/mock/azsdk-mock.dll"];
const [relativeDllPath, ...serverArgs] = serverCommand;
const dllPath = path.resolve(repoRoot, relativeDllPath);
const child = spawn("dotnet", [dllPath, ...serverArgs], {
  stdio: "inherit",
  env: process.env,
});

child.on("error", (error) => {
  console.error(error.message);
  process.exit(1);
});

child.on("exit", (code, signal) => {
  if (signal) {
    process.kill(process.pid, signal);
    return;
  }

  process.exit(code ?? 1);
});
