import * as fs from "node:fs";
import * as path from "node:path";

const mode = process.argv[2];
const nodeModulesRoot = process.env.FIXTURE_NODE_MODULES || "node_modules";

if (!mode || !["node_modules", "packages"].includes(mode)) {
  console.error(
    "[dependency-check] usage: node check-node-dependencies.js <node_modules|packages>",
  );
  process.exit(2);
}

if (!fs.existsSync(nodeModulesRoot)) {
  console.error(`[dependency-check:node_modules] missing: ${nodeModulesRoot}`);
  process.exit(2);
}

if (mode === "node_modules") {
  console.log("[dependency-check:node_modules] ok");
  process.exit(0);
}

/** @type {unknown} */
const fixturePackage = JSON.parse(fs.readFileSync("package.json", "utf8"));
if (
  typeof fixturePackage !== "object" ||
  fixturePackage === null ||
  !("devDependencies" in fixturePackage) ||
  typeof fixturePackage.devDependencies !== "object" ||
  fixturePackage.devDependencies === null
) {
  console.error("[dependency-check:packages] package.json has no devDependencies");
  process.exit(2);
}

const requiredPackages = Object.keys(fixturePackage.devDependencies);
if (!requiredPackages.length) {
  console.error("[dependency-check:packages] package.json has no devDependencies");
  process.exit(2);
}

const missing = requiredPackages.filter((packageName) => {
  return !fs.existsSync(path.join(nodeModulesRoot, ...packageName.split("/"), "package.json"));
});

if (missing.length) {
  console.error(`[dependency-check:packages] missing: ${missing.join(", ")}`);
  process.exit(2);
}

console.log("[dependency-check:packages] ok");
