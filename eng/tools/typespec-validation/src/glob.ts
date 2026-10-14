import { glob, stat } from "node:fs/promises";
import { matchesGlob, resolve } from "node:path";

/** Finds files using native glob semantics, without traversing directory symlinks. */
export async function globFiles(
  pattern: string | string[],
  options: { cwd?: string; exclude?: string[] } = {},
): Promise<string[]> {
  const files: string[] = [];
  const { cwd, exclude } = options;
  for await (const file of glob(pattern, options)) {
    // Native glob's exclusions do not cover every absolute-pattern match.
    if (exclude?.some((excluded) => matchesGlob(file, excluded))) {
      continue;
    }
    // Native glob also returns matching directories.
    if ((await stat(resolve(cwd ?? ".", file))).isFile()) {
      files.push(file);
    }
  }
  return files;
}
