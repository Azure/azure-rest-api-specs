import { dirname, join, resolve } from "path";
import { stat, access } from "fs/promises";

export class Npm {
  // Simulates `npm prefix` by finding the nearest parent directory containing `package.json` or `node_modules`.
  // If neither exist in any parent directories, returns the directory containing the path itself.
  // Always returns an absolute path.
  static async prefix(path: string): Promise<string> {
    path = resolve(path);

    const initialDir = (await stat(path)).isDirectory() ? path : dirname(path);

    for (
      var currentDir = initialDir;
      dirname(currentDir) != currentDir;
      currentDir = dirname(currentDir)
    ) {
      try {
        await access(join(currentDir, "package.json"));
        return currentDir;
      } catch {}

      try {
        await access(join(currentDir, "node_modules"));
        return currentDir;
      } catch {}
    }

    // Neither found in an parent dir
    return initialDir;
  }
}
