import * as path from "path";
import * as fs from "fs/promises";

export class Npm {
  // Simulates `npm prefix` by finding the nearest parent directory containing `package.json` or `node_modules`.
  // If neither exist in any parent directories, returns the directory containing the path itself.
  static async prefix(filePath: string): Promise<string> {
    const stats = await fs.stat(filePath);

    let currentDirectory: string;
    if (stats.isDirectory()) {
        currentDirectory = path.resolve(filePath);
    }
    else {
        currentDirectory = path.dirname(filePath);
    }

    return currentDirectory;
  }
}
