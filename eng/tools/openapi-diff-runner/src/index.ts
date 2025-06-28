import { exit } from "node:process";
import { validateBreakingChange } from "./commands.js";
import { buildPrInfo, initContext } from "./command-helpers.js";
import { logMessage } from "./log.js";

export async function main() {
  // Get the arguments passed to the script
  const args: string[] = process.argv.slice(2);
  // Log the arguments to the console
  logMessage(`Arguments passed to the script: ${args.join(" ")}`);
  logMessage(`Current working directory: ${process.cwd()}`);
  const context = initContext();
  await buildPrInfo(context);
  let statusCode = 0;
  statusCode = await validateBreakingChange(context);
  exit(statusCode);
}
