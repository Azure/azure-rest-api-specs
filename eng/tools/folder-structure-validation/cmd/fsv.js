#!/usr/bin/env node

import { readFile } from "fs/promises";
import { join } from "path";
import { URL } from "url";
import { FolderStructureRule } from "../dist/src/index.js";

const packageJsonPath = join(new URL(".", import.meta.url).pathname, "..", "package.json");
const packageJson = JSON.parse(await readFile(packageJsonPath, "utf-8"));

console.log(`Folder Structure Validator v${packageJson.version}\n`);

if (process.argv.length < 3) {
  console.error("Usage: fsv <folder-path>");
  console.error("Example: fsv specification/contoso/Contoso.Management");
  process.exit(1);
}

const folderPath = process.argv[2];

try {
  const rule = new FolderStructureRule();
  const result = await rule.execute(folderPath);

  if (result.stdOutput) {
    console.log(result.stdOutput);
  }

  if (result.errorOutput) {
    console.error(result.errorOutput);
  }

  if (!result.success) {
    process.exit(1);
  }

  console.log("✅ Folder structure validation passed!");
} catch (error) {
  console.error("❌ Error during validation:", error.message);
  process.exit(1);
}
