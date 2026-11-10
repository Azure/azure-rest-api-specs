import { execFileSync } from "node:child_process";
import { fileURLToPath } from "node:url";

export function $onValidate() {
  execFileSync(process.execPath, [fileURLToPath(new URL("./validate-examples.mjs", import.meta.url))], {
    stdio: "inherit",
  });
}
