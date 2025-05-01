#!/usr/bin/env node

import { existsSync, statSync } from "node:fs";
import { ConsoleLogger } from "../src/logger.js";
import { getSpecModel } from "../src/spec-model.js";

const USAGE =
  "Usage: npx spec-model path/to/spec [--debug]\n" +
  "Example: npx spec-model ../../specfication/contosowidgetmanager";

// Exclude first two args (node, script file)
let args = process.argv.slice(2);

const debug = args.includes("--debug");
args = args.filter((a) => a != "--debug");

if (args.length < 1) {
  console.error(USAGE);
  process.exit(1);
}

if (args.length > 1) {
  console.error("ERROR: Too many arguments\n");
  console.error(USAGE);
  process.exit(1);
}

const specPath = args[0];

if (!existsSync(specPath) || !statSync(specPath).isDirectory()) {
  console.error(`ERROR: Directory not found: ${specPath}\n`);
  console.error(USAGE);
  process.exit(1);
}

const specModel = await getSpecModel(specPath, {
  logger: new ConsoleLogger(debug),
});

console.log(JSON.stringify(specModel, null, 2));
