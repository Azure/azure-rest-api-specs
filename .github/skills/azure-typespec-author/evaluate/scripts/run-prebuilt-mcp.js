#!/usr/bin/env node

import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

const mcpKind = process.env.AZSDK_EVAL_MCP_KIND;
const repoRoot = process.env.AZSDK_EVAL_REPO_ROOT || process.cwd();
const mcpRoot = process.env.AZSDK_EVAL_MCP_ROOT || path.join(repoRoot, "artifacts", "mcp");
if (!["live", "mock"].includes(mcpKind)) {
  console.error("MCP kind must be live or mock.");
  process.exit(1);
}

const serverCommand = mcpKind === "live" ? ["cli/azsdk.dll", "mcp"] : ["mock/azsdk-mock.dll"];
const [relativeDllPath, ...serverArgs] = serverCommand;
const dllPath = path.resolve(mcpRoot, relativeDllPath);
if (!fs.existsSync(dllPath)) {
  console.error(`Prebuilt ${mcpKind} MCP binary does not exist: ${dllPath}`);
  process.exit(1);
}

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
