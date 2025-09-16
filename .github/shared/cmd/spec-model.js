#!/usr/bin/env node

import { ConsoleLogger } from "../src/logger.js";
import { SpecModel } from "../src/spec-model.js";

const USAGE =
  "Usage: npx spec-model path/to/spec [--debug] [--include-refs] [--relative-paths]\n" +
  "Example: npx spec-model specfication/contosowidgetmanager";

// Exclude first two args (node, script file)
let args = process.argv.slice(2);

const debug = args.includes("--debug");
args = args.filter((a) => a != "--debug");

const includeRefs = args.includes("--include-refs");
args = args.filter((a) => a != "--include-refs");

const relativePaths = args.includes("--relative-paths");
args = args.filter((a) => a != "--relative-paths");

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

const specModel = new SpecModel(specPath, {
  logger: new ConsoleLogger(debug),
});

console.log(JSON.stringify(await specModel.toJSONAsync({ includeRefs, relativePaths }), null, 2));
