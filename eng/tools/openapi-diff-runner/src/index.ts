import { exit } from "node:process";
import { existsSync, mkdirSync } from "node:fs";
import { detectBreakingChange } from "./commands.js";
import { initContext } from "./command-helpers.js";
import { Logger } from "./logger.js";

export async function main() {
  // Get the arguments passed to the script
  const args: string[] = process.argv.slice(2);
  // Log the arguments to the console
  console.log("Arguments passed to the script:", args.join(" "));
  console.log("Current working directory:", process.cwd());
  const context = initContext();
  let statusCode = 0;
  statusCode = await detectBreakingChange(context);
  exit(statusCode);
}
