import { resolve } from "path";
import { exit } from "process";

interface Suppression {
  tool: string;
  path: string;
  reason: string;
  suppressionFile: string;
}

export async function main() {
  const args = process.argv.slice(2);

  if (args.length === 2) {
    const tool = args[0];
    const path = args[1];

    const suppressions = await getSuppressions(tool, resolve(path));
    console.log(JSON.stringify(suppressions));

    exit(0);
  } else {
    console.error(getUsage());
    exit(1);
  }
}

function getUsage(): string {
  return (
    "  Usage: npx get-suppressions <tool-name> <path-to-file>\n" +
    "Returns: JSON array of suppressions, with specified tool name, applying to file (may be empty)\n" +
    "\n" +
    "Example: npx get-suppressions TypeSpecRequirement specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json\n" +
    'Returns: [{"tool":"TypeSpecRequirement","path":"**/*.json","reason":"foo",suppressionFile:"../../../suppressions.yaml"}]\n'
  );
}

async function getSuppressions(tool: string, path: string): Promise<Suppression[]> {
  let suppressions: Suppression[] = [];

  suppressions.push({
    tool: "TypeSpecRequirement",
    path: "**/*.json",
    reason: "Test reason from node",
    suppressionFile: "../../../suppressions.yaml",
  });

  let suppressionsFile = await findSuppressionsYaml(path);
  if (suppressionsFile) {
    if (tool) {
    }
  }

  return suppressions;
}

async function findSuppressionsYaml(path: string) {
  return path ? null : undefined;
}
