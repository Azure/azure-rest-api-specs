import { access } from "fs/promises";

/**
 * Enumerate files in a directory that match the given string ending
 * @param dir Directory to search
 * @param endsWith String to match at the end of the file
 */
// async function listFiles(dir: string, endsWith: string): Promise<string[]> {
//   const files = await readdir(dir, { recursive: true });
//   return files.filter((file) => file.endsWith(endsWith));
// }

/**
 * Check if a path exists
 * @param path Path to check for existence
 * @returns true if the path exists, false otherwise
 */
export async function pathExists(path: string): Promise<boolean> {
  try {
    await access(path);
    return true;
  } catch {
    return false;
  }
}
