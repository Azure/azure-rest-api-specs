// @ts-check

import { readFile, readdir } from "fs/promises";
import { join, extname, dirname } from "path";
import { includesFolder, getVersionFromInputFile, getBaseNameForSwagger } from "./path.js";

/**
 * @typedef {'stable' | 'preview'} ApiVersionLifecycleStage
 */

/**
 * @typedef {Object} OperationMetadata
 * @property {string} path - API path
 * @property {string} operationId - The operation ID
 * @property {string} httpMethod - HTTP method (GET, POST, etc.)
 * @property {string} [swagger] - Optional swagger file path
 */

/**
 * @typedef {Object} SwaggerMetadata
 * @property {string} version - API version
 * @property {ApiVersionLifecycleStage} versionType - Lifecycle stage (stable/preview)
 * @property {string} fileName - Base name of the swagger file
 * @property {string} folder - Folder path
 * @property {string} fullPath - Full path to the swagger file
 */

/**
 * SwaggerVersionCache - Caches and manages version information for swagger files
 */
export class SwaggerVersionCache {
  // map of RP folder paths to their swagger metadata
  /** @type {Map<string, SwaggerMetadata[]>} */
  #versionsByRp = new Map();

  // map of swagger file paths to their operations
  /** @type {Map<string, OperationMetadata[]>} */
  #operationsBySwagger = new Map();

  // map of RP folder paths to their swagger file paths
  /** @type {Map<string, string[]>} */
  #swaggersByRp = new Map();

  /**
   * Get all swagger files in the RP folder (with caching)
   * @param {string} rpFolderPath - Path to the RP folder
   * @returns {Promise<string[]>} - Array of swagger file paths
   */
  async getAllSwaggers(rpFolderPath) {
    // Check cache first
    const cached = this.#swaggersByRp.get(rpFolderPath);
    if (cached) {
      return cached;
    }

    try {
      // Use fs.readdir with recursive option (Node.js 20+) for efficient file discovery
      const allEntries = await readdir(rpFolderPath, {
        recursive: true,
        withFileTypes: true,
      });

      const swaggerFiles = [];

      for (const entry of allEntries) {
        if (entry.isFile()) {
          const fullPath = join(entry.path, entry.name);
          const ext = extname(entry.name).toLowerCase();
          // Check if it's a JSON file and not in examples folder
          if (ext === ".json" && !includesFolder(fullPath, "examples")) {
            swaggerFiles.push(fullPath);
          }
        }
      }

      // Cache the result
      this.#swaggersByRp.set(rpFolderPath, swaggerFiles);
      return swaggerFiles;
    } catch (/** @type {any} */ error) {
      // Fallback to empty array if readdir fails
      console.warn(`Failed to scan directory ${rpFolderPath}:`, error.message);
      return [];
    }
  }

  /**
   * Get metadata for all swagger files in RP folder (with caching)
   * @param {string} rpFolderPath - Path to the RP folder
   * @returns {Promise<SwaggerMetadata[]>} - Array of swagger metadata
   */
  async getVersionMapping(rpFolderPath) {
    // Check cache first
    const cached = this.#versionsByRp.get(rpFolderPath);
    if (cached) {
      return cached;
    }

    const swaggerFiles = await this.getAllSwaggers(rpFolderPath);
    const metadata = [];

    for (const swaggerPath of swaggerFiles) {
      try {
        const version = getVersionFromInputFile(swaggerPath);
        if (!version) {
          continue; // Skip files without valid version
        }

        const fileName = getBaseNameForSwagger(swaggerPath);
        const versionType = SwaggerVersionCache.getVersionType(swaggerPath);

        metadata.push({
          version,
          versionType,
          fileName,
          folder: rpFolderPath,
          fullPath: swaggerPath,
        });
      } catch {
        // Skip files that can't be parsed
      }
    }

    // Cache the result
    this.#versionsByRp.set(rpFolderPath, metadata);
    return metadata;
  }

  /**
   * Get operations for a specific swagger file (with caching)
   * @param {string} swaggerPath - Path to the swagger file
   * @returns {Promise<OperationMetadata[]>} - Array of operation metadata
   */
  async getOperations(swaggerPath) {
    // Check cache first
    const cached = this.#operationsBySwagger.get(swaggerPath);
    if (cached) {
      return cached;
    }

    try {
      const content = await readFile(swaggerPath, "utf8");
      const swagger = JSON.parse(content);

      const operations = [];

      // Process regular paths
      if (swagger.paths) {
        for (const [path, pathItem] of Object.entries(swagger.paths)) {
          for (const [method, operation] of Object.entries(pathItem)) {
            if (typeof operation === "object" && operation.operationId && method !== "parameters") {
              operations.push({
                operationId: operation.operationId,
                httpMethod: method.toUpperCase(),
                path: path,
              });
            }
          }
        }
      }

      // Process x-ms-paths (Azure extension)
      if (swagger["x-ms-paths"]) {
        for (const [path, pathItem] of Object.entries(swagger["x-ms-paths"])) {
          for (const [method, operation] of Object.entries(pathItem)) {
            if (typeof operation === "object" && operation.operationId && method !== "parameters") {
              operations.push({
                operationId: operation.operationId,
                httpMethod: method.toUpperCase(),
                path: path,
              });
            }
          }
        }
      }

      // Cache the result
      this.#operationsBySwagger.set(swaggerPath, operations);
      return operations;
    } catch {
      // Return empty array if file can't be parsed
      return [];
    }
  }

  /**
   * Clear all caches (useful for testing or when files change)
   */
  clearCaches() {
    this.#versionsByRp.clear();
    this.#operationsBySwagger.clear();
    this.#swaggersByRp.clear();
  }

  /**
   * Clear cache for a specific RP folder
   * @param {string} rpFolderPath - Path to the RP folder
   */
  clearCacheForFolder(rpFolderPath) {
    this.#versionsByRp.delete(rpFolderPath);
    this.#swaggersByRp.delete(rpFolderPath);

    // Clear operations cache for all files in this folder
    for (const [filePath] of this.#operationsBySwagger) {
      if (filePath.startsWith(rpFolderPath)) {
        this.#operationsBySwagger.delete(filePath);
      }
    }
  }

  /**
   * Get cache statistics (useful for debugging)
   */
  getCacheStats() {
    return {
      versionsByRp: this.#versionsByRp.size,
      operationsBySwagger: this.#operationsBySwagger.size,
      swaggersByRp: this.#swaggersByRp.size,
    };
  }

  // Instance methods that leverage caching internally

  /**
   * Get the most recent preceding version of a specific type
   * @param {string} swaggerFile - Path to the swagger file
   * @param {ApiVersionLifecycleStage} swaggerVersionType - Type of version to find ('stable' | 'preview')
   * @returns {Promise<string | undefined>} - Path to the most recent preceding version file, or undefined
   */
  async getMostRecentPrecedingVersion(swaggerFile, swaggerVersionType) {
    const rpFolder = SwaggerVersionCache.getRPFolder(swaggerFile);
    if (!rpFolder) {
      return undefined;
    }

    const versions = await this.getVersionMapping(rpFolder);
    const fileName = getBaseNameForSwagger(swaggerFile);
    const currentVersion = getVersionFromInputFile(swaggerFile);

    try {
      const version = versions
        .filter(
          (v) =>
            v.fileName === fileName &&
            v.versionType === swaggerVersionType &&
            v.version <= (currentVersion || "") &&
            v.fullPath !== swaggerFile,
        )
        .reduce((previous, current) => (previous.version > current.version ? previous : current));
      return version.fullPath;
    } catch {
      return undefined;
    }
  }

  /**
   * Get preceding preview version for a given swagger file
   * @param {string} swaggerFile - Path to the swagger file
   * @returns {Promise<string | undefined>} - Path to the closest preview version, or undefined
   */
  async getPrecedingPreview(swaggerFile) {
    return await this.getMostRecentPrecedingVersion(swaggerFile, "preview");
  }

  /**
   * Get preceding stable version for a given swagger file
   * @param {string} swaggerFile - Path to the swagger file
   * @returns {Promise<string | undefined>} - Path to the closest stable version, or undefined
   */
  async getPrecedingStable(swaggerFile) {
    return await this.getMostRecentPrecedingVersion(swaggerFile, "stable");
  }

  /**
   * Get operations from all previous versions that also exist in current swagger
   * @param {string} swaggerFile - Path to the current swagger file
   * @returns {Promise<OperationMetadata[]>} - Operations that exist in both previous versions and current version
   */
  async getLegacyVersionOperations(swaggerFile) {
    /** @type {OperationMetadata[]} */
    let result = [];

    const rpFolder = SwaggerVersionCache.getRPFolder(swaggerFile);
    if (!rpFolder) {
      return result;
    }

    const versions = await this.getVersionMapping(rpFolder);
    const fileName = getBaseNameForSwagger(swaggerFile);
    const currentVersion = getVersionFromInputFile(swaggerFile);
    const currentVersionType = SwaggerVersionCache.getVersionType(swaggerFile);

    // Get operations from current swagger file
    const currentOperations = await this.getOperations(swaggerFile);

    // Get all previous versions of the same type (stable/preview) and same file name
    const previousVersions = versions
      .filter(
        (v) =>
          v.fileName === fileName &&
          v.versionType === currentVersionType &&
          v.version < (currentVersion || "") &&
          v.fullPath !== swaggerFile,
      )
      .sort((a, b) => a.version.localeCompare(b.version));

    // Collect operations from all previous versions that also exist in current version
    for (const versionMeta of previousVersions) {
      try {
        const previousOperations = await this.getOperations(versionMeta.fullPath);

        // Find operations that exist in both this previous version AND current version
        const matchingOperations = previousOperations
          .filter((operation) => {
            // Use custom find instead of lodash _.find()
            return currentOperations.some(
              (currentOp) =>
                currentOp.path === operation.path &&
                currentOp.operationId === operation.operationId &&
                currentOp.httpMethod === operation.httpMethod,
            );
          })
          .map((o) => {
            // Add swagger file reference to track which old version contained this operation
            return { ...o, swagger: versionMeta.fullPath };
          });

        result.push(...matchingOperations);
      } catch {
        // Skip versions that can't be processed
      }
    }

    return result;
  }

  /**
   * Get version type from swagger file path
   * @param {string} swaggerPath - Path to swagger file
   * @returns {ApiVersionLifecycleStage} - Version type
   */
  static getVersionType(swaggerPath) {
    return dirname(swaggerPath).includes("/preview/") ? "preview" : "stable";
  }

  /**
   * Get RP folder path from swagger path (matches original TypeScript implementation)
   * Example:
   * input: specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json
   * returns: specification/network/resource-manager/Microsoft.Network
   * @param {string} swaggerFile - Path to swagger file
   * @returns {string | undefined} - RP folder path, or undefined if not found
   */
  static getRPFolder(swaggerFile) {
    const segments = swaggerFile.split(/\\|\//);
    if (segments && segments.length > 3) {
      let rpIndex = -3;
      segments.some((v, idx) => {
        if (v.startsWith("Microsoft.")) {
          rpIndex = idx + 1;
          return true;
        }
        return false;
      });
      if (segments[0] === "dev") {
        segments[0] = "specification";
      }
      return segments.slice(0, rpIndex).join("/");
    }
    return undefined;
  }
}
