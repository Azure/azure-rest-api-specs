#!/usr/bin/env node

import { getSpecModel } from "../src/spec-model.js";
import { existsSync, statSync } from "node:fs";
import { join } from "node:path";

const __dirname = new URL(".", import.meta.url).pathname;

const USAGE = `Usage: npm exec spec-model <service-name>
  service-name: Service directory under specification/ to generate the spec model for.`;

if (!process.argv[2]) {
  console.error(USAGE);
  process.exit(1);
}

if (process.argv.length > 3) { 
  console.error("ERROR: Too many arguments\n");
  console.error(USAGE);
  process.exit(1);
}

const specPath = join(__dirname, `../../../specification/${process.argv[2]}`);
if (!existsSync(specPath) || !statSync(specPath).isDirectory()) {
  console.error(`ERROR: Directory not found: ${specPath}\n`);
  console.error(USAGE);
  process.exit(1);
}


function replacer(key, value) {
  if (value instanceof Map) {
    return Object.fromEntries(value);
  }
  if (value instanceof Set) {
    return Array.from(value);
  }
  return value;
}

const specModel = await getSpecModel(`specification/${process.argv[2]}`);

console.log(JSON.stringify(specModel, replacer, 2));
