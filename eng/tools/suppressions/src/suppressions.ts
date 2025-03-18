import { Stats } from "fs";
import { access, constants, lstat, readFile } from "fs/promises";
import { minimatch } from "minimatch";
import { dirname, join, resolve, sep } from "path";
import { sep as posixSep } from "path/posix";
import { parse as yamlParse } from "yaml";
import { z } from "zod";
import { fromError } from "zod-validation-error";

export interface Suppression {
  tool: string;
  // Output only exposes "paths".  For input, if "path" is defined, it is inserted at the start of "paths".
  paths: string[];
  rules?: string[];
  subRules?: string[];
  reason: string;
}

const suppressionSchema = z.array(
  z
    .object({
      tool: z.string(),
      // For now, input allows "path" alongside "paths".  Lather, may deprecate "path".
      path: z.string().optional(),
      paths: z.array(z.string()).optional(),
      rules: z.array(z.string()).optional(),
      "sub-rules": z.array(z.string()).optional(),
      reason: z.string(),
    })
    .refine((data) => data.path || data.paths?.[0], {
      message: "Either 'path' or 'paths' must be present",
      path: ["path", "paths"],
    })
    .transform((s) => {
      let paths: string[] = Array.from(s.paths || []);
      if (s.path) {
        // if "path" is defined, it is inserted at the start of "paths".
        paths.unshift(s.path);
      }
      return {
        tool: s.tool,
        paths: paths,
        rules: s.rules,
        subRules: s["sub-rules"],
        reason: s.reason,
      } as Suppression;
    }),
);

/**
 * Returns the suppressions for a tool applicable to a path.  Walks up the directory tree to find all files named
 * "suppressions.yaml", parses and validates the contents, and returns the suppressions matching the tool and path.
 * Suppressions are ordered by file (closest to path is first), then within the file (closest to top is first).
 *
 * @param tool Name of tool. Matched against property "tool" in suppressions.yaml.
 * @param path Path to file or directory under analysis.
 * @returns Array of suppressions matching tool and path (may be empty).
 *
 * @example
 * ```
 * // Prints
 * // '[{
 * //   "tool":"TypeSpecRequirement",
 * //   "paths":["data-plane/foo/stable/2024-01-01/*.json"],
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

  let suppressionsFiles: string[] = await findSuppressionsFiles(path);
  let suppressions: Suppression[] = [];

  for (let suppressionsFile of suppressionsFiles) {
    suppressions = suppressions.concat(
      getSuppressionsFromYaml(
        tool,
        path,
        suppressionsFile,
        await readFile(suppressionsFile, { encoding: "utf8" }),
      ),
    );
  }

  return suppressions;
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
 *  '- tool: TypeSpecRequirement\n paths: ["data-plane/foo/stable/2024-01-01/*.json"]\n reason: foo'
 * )));
 * ```
 */
export function getSuppressionsFromYaml(
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
      const pathPosix: string = path.split(sep).join(posixSep);

      return s.paths.some((suppressionPath) => {
        const pattern: string = join(dirname(suppressionsFile), suppressionPath)
          .split(sep)
          .join(posixSep);
        return minimatch(pathPosix, pattern);
      });
    });
}

/**
 * Returns absolute paths to all suppressions.yaml files applying to input (or "undefined" if none found).
 * Walks up directory tree, returning all files matching "suppressions.yaml", in order (may be empty);
 *
 * @param path Path to file under analysis.
 *
 * @example
 * ```
 * // Prints
 * //   '/home/user/specs/specification/foo/suppressions.yaml'
 * //   '/home/user/specs/specification/suppressions.yaml
 * console.log(findSuppressionsYaml(
 *   "specification/foo/data-plane/Foo/stable/2024-01-01/foo.json"
 * ));
 * ```
 */
async function findSuppressionsFiles(path: string): Promise<string[]> {
  const suppressionsFiles: string[] = [];

  path = resolve(path);

  const stats: Stats = await lstat(path);
  let currentDirectory: string = stats.isDirectory() ? path : dirname(path);

  while (true) {
    const suppressionsFile: string = join(currentDirectory, "suppressions.yaml");
    try {
      // Throws if file cannot be read
      await access(suppressionsFile, constants.R_OK);
      suppressionsFiles.push(suppressionsFile);
    } catch {
      // File does not exist (or cannot be read), so skip this directory and check the parent
    }

    const parentDirectory: string = dirname(currentDirectory);
    if (parentDirectory !== currentDirectory) {
      currentDirectory = parentDirectory;
    } else {
      // Reached fs root
      break;
    }
  }

  return suppressionsFiles;
}
