import { access, constants, readFile } from "fs/promises";
import { minimatch } from "minimatch";
import { dirname, join, resolve, sep } from "path";
import { sep as posixSep } from "path/posix";
import { exit } from "process";
import { parse as yamlParse } from "yaml";
import { z } from "zod";
import { fromError } from "zod-validation-error";

function getUsage(): string {
  return (
    "  Usage: npx get-suppressions <tool-name> <path-to-file>\n" +
    "Returns: JSON array of suppressions, with specified tool name, applying to file (may be empty)\n" +
    "\n" +
    "Example: npx get-suppressions TypeSpecRequirement specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json\n" +
    'Returns: [{"tool":"TypeSpecRequirement","path":"data-plane/Foo/stable/2023-01-01/*.json","reason":"foo"}]\n'
  );
}

export interface Suppression {
  tool: string;
  path: string;
  reason: string;
}

const suppressionSchema = z.array(
  z.object({
    tool: z.string(),
    path: z.string(),
    reason: z.string(),
  }),
);

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

/**
 * Returns the suppressions for a tool applicable to a path.  Walks up the directory tree to the first file named
 * "suppressions.yaml", parses and validates the contents, and returns the suppressions matching the tool and path.
 *
 * @param tool Name of tool. Matched against property "tool" in suppressions.yaml.
 * @param path Path to file under analysis.
 * @returns Array of suppressions matching tool and path (may be empty).
 *
 * @example
 * ```
 * // Prints
 * // '[{
 * //   "tool":"TypeSpecRequirement",
 * //   "path":"data-plane/foo/stable/2024-01-01/*.json",
 * //   "reason":"foo"
 * //  }]':
 * console.log(JSON.stringify(getSuppressions(
 *   "TypeSpecRequirement",
 *   "specification/foo/data-plane/Foo/stable/2024-01-01/foo.json"))
 * );
 * ```
 */
export async function getSuppressions(tool: string, path: string): Promise<Suppression[]> {
  path = resolve(path);

  // If path doesn't exist, throw instead of returning "[]" to prevent confusion
  await access(path, constants.R_OK);

  let suppressionsFile: string | undefined = await findSuppressionsYaml(path);
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

/**
 * Returns the suppressions for a tool applicable to a path, given the path and content of the suppressions.yaml.
 * Extracted for unit testing.
 *
 * @internal
 *
 * @param tool Name of tool. Matched against property "tool" in suppressions.yaml.
 * @param path Path to file under analysis.
 * @param suppressionsFile Path to suppressions.yaml file.
 * @param suppressionsYaml Content of suppressions.yaml file.
 * @returns Array of suppressions matching tool and path (may be empty).
 * @example
 * ```
 * // Prints
 * // '[{
 * //    "tool":"TypeSpecRequirement",
 * //    "path":"data-plane/foo/stable/2024-01-01/*.json",
 * //    "reason":"foo"
 * // }]':
 * console.log(JSON.stringify(_getSuppressionsFromYaml(
 *  "TypeSpecRequirement",
 *  "specification/foo/data-plane/Foo/stable/2024-01-01/foo.json",
 *  "specification/foo/suppressions.yaml",
 *  '- tool: TypeSpecRequirement\n path: "data-plane/foo/stable/2024-01-01/*.json"\n reason: foo'
 * )));
 * ```
 */
export function _getSuppressionsFromYaml(
  tool: string,
  path: string,
  suppressionsFile: string,
  suppressionsYaml: string,
): Suppression[] {
  path = resolve(path);
  suppressionsFile = resolve(suppressionsFile);

  // Treat empty yaml as empty array
  const parsedYaml: any = yamlParse(suppressionsYaml) ?? [];

  let suppressions: Suppression[];
  try {
    // Throws if parsedYaml doesn't match schema
    suppressions = suppressionSchema.parse(parsedYaml);
  } catch (err) {
    throw fromError(err);
  }

  return suppressions
    .filter((s) => s.tool === tool)
    .filter((s) => {
      // Minimatch only allows forward-slashes in patterns and input
      const pattern: string = join(dirname(suppressionsFile), s.path).split(sep).join(posixSep);
      const pathPosix: string = path.split(sep).join(posixSep);
      return minimatch(pathPosix, pattern);
    });
}

/**
 * Returns absolute path to suppressions.yaml applying to input (or "undefined" if none found).
 * Walks up directory tree until first file matching "suppressions.yaml".
 *
 * @param path Path to file under analysis.
 *
 * @example
 * ```
 * // Prints '/home/user/specs/specification/foo/suppressions.yaml':
 * console.log(findSuppressionsYaml(
 *   "specification/foo/data-plane/Foo/stable/2024-01-01/foo.json"
 * ));
 * ```
 */
async function findSuppressionsYaml(path: string): Promise<string | undefined> {
  path = resolve(path);

  let currentDirectory: string = dirname(path);
  while (true) {
    const suppressionsFile: string = join(currentDirectory, "suppressions.yaml");
    try {
      // Throws if file cannot be read
      await access(suppressionsFile, constants.R_OK);
      return suppressionsFile;
    } catch {
      const parentDirectory: string = dirname(currentDirectory);
      if (parentDirectory !== currentDirectory) {
        currentDirectory = parentDirectory;
      } else {
        // Reached fs root but no "suppressions.yaml" found
        return;
      }
    }
  }
}
