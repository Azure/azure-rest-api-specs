import { resolve } from "node:path";
import { checkCatalogUsage } from "../src/check-catalog.ts";

try {
  const errors = checkCatalogUsage(resolve(import.meta.dirname, "../../.."));
  if (errors.length > 0) {
    console.error(errors.join("\n"));
    console.error(
      '\nAll external dependencies must use "catalog:". Add their versions to pnpm-workspace.yaml and replace the versions in package.json with "catalog:". Keep local dependencies as "workspace:".',
    );
    process.exitCode = 1;
  } else {
    console.log("All workspace dependencies use catalog: or workspace: protocols.");
  }
} catch (error) {
  console.error("Failed to validate workspace catalog usage:", error);
  process.exitCode = 1;
}
