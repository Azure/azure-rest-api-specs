// @ts-check

import { existsSync, readFileSync } from "fs";
import { basename, resolve, sep } from "path";

/**
 *
 * @param {string} path
 * @param {string} folder
 * @returns {boolean} True if path contains the named folder
 */
export function includesFolder(path, folder) {
  return resolve(path).includes(sep + folder + sep);
}

/**
 * Extract version string from input file path (matches original TypeScript implementation)
 * @param {string} filePath - Path to the input file
 * @param {boolean} [withPreview=false] - Whether to include preview suffix
 * @returns {string | undefined} - Version string extracted from path
 */
export function getVersionFromInputFile(filePath, withPreview = false) {
  const apiVersionRegex = /^\d{4}-\d{2}-\d{2}(|-preview|-privatepreview|-alpha|-beta|-rc)$/;
  const segments = filePath.split("/");

  if (filePath.indexOf("data-plane") !== -1) {
    if (segments && segments.length > 1) {
      for (const s of segments.entries()) {
        if (["stable", "preview"].some((v) => v === s[1])) {
          const version = segments[s[0] + 1];
          if (version) {
            return apiVersionRegex.test(version) && !withPreview ? version.substr(0, 10) : version;
          }
        }
      }
    }
  } else {
    if (segments && segments.length > 1) {
      for (const s of segments) {
        if (apiVersionRegex.test(s)) {
          return withPreview ? s : s.substr(0, 10);
        }
      }
    }
  }

  if (existsSync(filePath)) {
    try {
      return JSON.parse(readFileSync(filePath).toString())?.info?.version;
    } catch {
      // Ignore JSON parse errors
    }
  }

  return undefined;
}

/**
 * Get base name for swagger file (matches original TypeScript implementation)
 * @param {string} filePath - Path to swagger file
 * @returns {string} - Base name for the swagger file
 */
export function getBaseNameForSwagger(filePath) {
  const version = getVersionFromInputFile(filePath);
  if (version) {
    const segments = filePath.split("/");
    const index = segments.findIndex((v) => v.startsWith(version));
    if (index !== -1) {
      return segments.slice(index + 1).join("/");
    }
  }
  return basename(filePath);
}
