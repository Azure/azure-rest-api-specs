// @ts-check

import { accessSync, constants as fsConstants } from "fs";
import { resolve } from "path";

/**
 * @param {string} path
 * @param {number} [mode] default: fs.constants.R_OK
 * @returns string
 */
export function resolveCheckAccess(path, mode = fsConstants.R_OK) {
  const pathResolved = resolve(path);

  // Throws if file cannot be accessed
  accessSync(pathResolved, mode);

  return pathResolved;
}
