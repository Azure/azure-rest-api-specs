import { exit } from "node:process";
import { validateBreakingChange } from "./commands.js";
import { buildPrInfo, initContext } from "./command-helpers.js";

export async function main() {
  // Get the arguments passed to the script
  const args: string[] = process.argv.slice(2);
  // Log the arguments to the console
  console.log("Arguments passed to the script:", args.join(" "));
  console.log("Current working directory:", process.cwd());
  const context = initContext();
  await buildPrInfo(context);
  let statusCode = 0;
  statusCode = await validateBreakingChange(context);
  exit(statusCode);
}
