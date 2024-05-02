import { access, constants, readFile } from "fs/promises";
import { minimatch } from "minimatch";
import { dirname, join, relative, resolve } from "path";
import { exit } from "process";
import { parse as yamlParse } from "yaml";

interface SuppressionFromFile {
  tool: string;
  path: string;
  reason: string;
}

export interface Suppression extends SuppressionFromFile {
  suppressionsFile?: string;
}

export async function main() {
  const args = process.argv.slice(2);

  if (args.length === 2) {
    const tool = args[0];
    const path = args[1];
    const suppressions = await getSuppressions(tool, path);
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

// tool: Name of tool
// example: TypeSpecRequirement
//
// path: Path to file under analysis
// example: specification/foo/data-plane/Foo/stable/2024-01-01/foo.json
//
// returns: Array of suppressions matching tool and path (may be empty)
// suppressionsFile property: Path to suppressions.yaml file containing the suppression, relative to the file under analysis
// example: [{"tool":"TypeSpecRequirement","path":"**/*.json","reason":"foo",suppressionFile:"../../../suppressions.yaml"}]
export async function getSuppressions(tool: string, path: string): Promise<Suppression[]> {
  path = resolve(path);

  // If path doesn't exist, throw instead of returning "[]" to prevent confusion
  await access(path, constants.R_OK);

  let suppressionsFile = await findSuppressionsYaml(path);
  if (suppressionsFile) {
    return _getSuppressionsFromYaml(
      tool,
      path,
      suppressionsFile,
      await readFile(suppressionsFile, { encoding: "utf8" }),
    );
  } else {
    return [];
  }
}

// Function extracted for unit testing
//
// tool: Name of tool
// example: TypeSpecRequirement
//
// path: Path to file under analysis
// example: specification/foo/data-plane/Foo/stable/2024-01-01/foo.json
//
// suppressionsFile: Path to suppressions.yaml (required to join relative paths in suppressions)
// example: specification/foo/suppressions.yaml
//
// suppressionsYaml: String content of suppressions.yaml file
// example: "- tool: TypeSpecRequirement ..."
//
// returns: Array of suppressions matching tool and path (may be empty)
// suppressionsFile property: Path to suppressions.yaml file containing the suppression, relative to the file under analysis
// example: [{"tool":"TypeSpecRequirement","path":"**/*.json","reason":"foo",suppressionFile:"../../../suppressions.yaml"}]
export function _getSuppressionsFromYaml(
  tool: string,
  path: string,
  suppressionsFile: string,
  suppressionsYaml: string,
): Suppression[] {
  path = resolve(path);
  suppressionsFile = resolve(suppressionsFile);

  const suppressions: SuppressionFromFile[] = yamlParse(suppressionsYaml);
  return suppressions
    .filter((s) => s.tool === tool)
    .filter((s) => minimatch(path, join(dirname(suppressionsFile), s.path)))
    .map((s) => ({
      ...s,
      suppressionsFile: relative(path, suppressionsFile),
    }));
}

// path: Absolute path to file under analysis
// example: /home/user/specs/specification/foo/data-plane/Foo/stable/2024-01-01/foo.json
//
// returns: Absolute path to suppressions.yaml file, or "undefined" if none found
// example: /home/user/specs/specification/foo/suppressions.yaml
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
