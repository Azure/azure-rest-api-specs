// @ts-check

import { relative, resolve, sep } from "path";

/**
 * @param {string} path
 * @param {string} folder
 * @returns {boolean} True if path contains the named folder
 */
export function includesFolder(path, folder) {
  return resolve(path).includes(sep + folder + sep);
}

/**
 * Resolves {path} against {options.cwd} (if specified), or the current directory
 *
 * @param {string} path
 * @param {Object} [options]
 * @param {string} [options.cwd] Current working directory.  Default: process.cwd().
 * @returns {string}
 */
export function resolveCwd(path, options = {}) {
  // Could also set cwd="", but I think it's more correct to call resolve with one path
  const { cwd } = options;
  return cwd === undefined ? resolve(path) : resolve(cwd, path);
}

/**
 * Solve the relative path from {from} to {options.cwd} (if specified), or the current directory
 *
 * @param {string} path
 * @param {Object} [options]
 * @param {string} [options.cwd] Current working directory.  Default: process.cwd().
 * @returns {string}
 */
export function relativeCwd(path, options = {}) {
  // relative() requires two paths, but "" means "current directory"
  const { cwd = "" } = options;
  return relative(cwd, path);
}
