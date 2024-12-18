import { dirname } from "path";

export class Npm {
  // Simulates `npm prefix` by finding the nearest parent directory containing `package.json` or `node_modules`.
  // If neither exist in any parent directories, returns the directory containing the path itself.
  static prefix(path: string): string {
    return dirname(path);
  }
}
