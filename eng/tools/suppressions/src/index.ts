import { resolve } from "path";

export async function main() {
  const args = process.argv.slice(2);

  if (args.length === 2) {
    const tool = args[0];
    const path = args[1];
    await getSuppressions(tool, resolve(path));
  } else {
    console.log("  Usage: npx get-suppressions <tool-name> <path-to-file>");
    console.log(
      "Returns: JSON array of suppressions, with specified tool name, applying to file (may be empty)",
    );
    console.log();
    console.log(
      "Example: npx get-suppressions TypeSpecRequirement specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json",
    );
    console.log(
      'Returns: [{"tool":"TypeSpecRequirement","path":"/home/user/.../data-plane/**/*.json","reason":"foo"}]',
    );
  }
}

async function getSuppressions(tool: string, path: string) {
  console.log(`getSuppressions(${tool}, ${path})`);
}

// async function findSuppressionsYaml(file: string) {}
