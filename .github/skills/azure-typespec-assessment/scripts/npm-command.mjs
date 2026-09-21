import fs from "node:fs";
import path from "node:path";

function resolveWindowsNpmCli(executable, env = process.env) {
  const cliName = {
    "npm.cmd": "npm-cli.js",
    "npx.cmd": "npx-cli.js",
  }[path.basename(executable).toLowerCase()];
  if (!cliName) return null;
  const directories = path.isAbsolute(executable)
    ? [path.dirname(executable)]
    : (env.PATH ?? "").split(path.delimiter);
  for (const directory of directories) {
    const normalized = directory.replace(/^"(.*)"$/, "$1");
    const shim = path.isAbsolute(executable)
      ? executable
      : path.join(normalized, executable);
    if (!fs.existsSync(shim)) continue;
    const cli = path.join(path.dirname(shim), "node_modules", "npm", "bin", cliName);
    if (fs.existsSync(cli)) return cli;
  }
  throw new Error(`Unable to resolve ${cliName} from ${executable}.`);
}

export function dependencyProcessCommand(
  command,
  { platform = process.platform, env = process.env, execPath = process.execPath } = {},
) {
  if (platform !== "win32") return command;
  const cli = resolveWindowsNpmCli(command.executable, env);
  return cli
    ? { executable: execPath, args: [cli, ...command.args] }
    : command;
}
