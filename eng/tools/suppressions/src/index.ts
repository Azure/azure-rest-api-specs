import { exit } from "process";
import { getSuppressions, Suppression } from "./suppressions.js";

function getUsage(): string {
  return (
    "  Usage: npx get-suppressions <tool-name> <path-to-file-or-directory>\n" +
    "Returns: JSON array of suppressions, with specified tool name, applying to file or directory (may be empty)\n" +
    "\n" +
    "Example: npx get-suppressions TypeSpecRequirement specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json\n" +
    'Returns: [{"tool":"TypeSpecRequirement","paths":["data-plane/Foo/stable/2023-01-01/*.json"],"reason":"foo"}]\n' +
    "\n" +
    "Example: npx get-suppressions TypeSpecValidation specification/foo/Microsoft.Foo\n" +
    'Returns: [{"tool":"TypeSpecValidation","paths":["**"],"reason":"foo"}]\n'
  );
}

export async function main() {
  const args: string[] = process.argv.slice(2);

  if (args.length === 2) {
    const tool: string = args[0];
    const path: string = args[1];
    const suppressions: Suppression[] = await getSuppressions(tool, path);
    console.log(JSON.stringify(suppressions));
    exit(0);
  } else {
    console.error(getUsage());
    exit(1);
  }
}
