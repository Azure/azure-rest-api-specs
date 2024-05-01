import { access, constants, readFile } from "fs/promises";
import { minimatch } from "minimatch";
import { dirname, join, relative, resolve } from "path";
import { exit } from "process";
import { parse as yamlParse } from "yaml";

interface Suppression {
  tool: string;
  path: string;
  reason: string;
  suppressionsFile?: string;
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
  let suppressionsFile = await findSuppressionsYaml(path);
  if (suppressionsFile) {
    const suppressions: Suppression[] = yamlParse(
      await readFile(suppressionsFile, { encoding: "utf8" }),
    );
    return suppressions
      .filter((s) => s.tool === tool)
      .filter((s) => minimatch(path, join(dirname(suppressionsFile), s.path)))
      .map((s) => ({
        ...s,
        suppressionsFile: relative(path, suppressionsFile),
      }));
  } else {
    return [];
  }
}

// "path" is absolute path to file being analyzed
async function findSuppressionsYaml(path: string): Promise<string | undefined> {
  let currentDirectory = dirname(path);
  while (true) {
    const suppressionsFile = join(currentDirectory, "suppressions.yaml");
    try {
      // Throws if file cannot be read
      await access(suppressionsFile, constants.R_OK);
      return suppressionsFile;
    } catch {
      const parentDirectory = dirname(currentDirectory);
      if (parentDirectory !== currentDirectory) {
        currentDirectory = parentDirectory;
      } else {
        // Reached fs root but no "suppressions.yaml" found
        return;
      }
    }
  }
}
