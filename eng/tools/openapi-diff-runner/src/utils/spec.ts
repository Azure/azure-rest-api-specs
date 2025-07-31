import { mapAsync } from "@azure-tools/specs-shared/array";
import { basename } from "node:path";
import { logError } from "../log.js";
import { ApiVersionLifecycleStage } from "../types/breaking-change.js";
import { getVersionFromInputFile } from "./common-utils.js";

// Type definitions
export interface Operation {
  id: string;
  path: string;
  httpMethod: string;
}

export interface Swagger {
  path: string;
  versionKind?: string;
  getOperations?(): Promise<Map<string, Operation>>;
}

/**
 * Get preceding swagger version for a specific lifecycle stage
 */
async function getPrecedingSwaggerByType(
  targetSwaggerPath: string,
  availableSwaggers: Swagger[],
  versionKind: ApiVersionLifecycleStage,
): Promise<string | undefined> {
  if (availableSwaggers.length === 0) {
    return undefined;
  }

  const currentVersion = await getVersionFromInputFile(targetSwaggerPath);
  const fileName = getBaseNameForSwagger(targetSwaggerPath, currentVersion);

  // Load version info for all swaggers to enable filtering
  const swaggersWithVersions = await mapAsync(availableSwaggers, async (swagger) => {
    const version = await getVersionFromInputFile(swagger.path);
    const versionWithPreview = await getVersionFromInputFile(swagger.path, true);
    return {
      swagger,
      version,
      fileName: getBaseNameForSwagger(swagger.path, version),
      versionKind: versionWithPreview.includes("preview")
        ? ApiVersionLifecycleStage.PREVIEW
        : ApiVersionLifecycleStage.STABLE,
    };
  });

  const versionsOfType = swaggersWithVersions.filter(
    (item) =>
      item.fileName === fileName &&
      item.versionKind === versionKind &&
      item.version <= currentVersion,
  );

  if (versionsOfType.length > 0) {
    const mostRecent = versionsOfType.reduce((previous, current) =>
      previous.version > current.version ? previous : current,
    );
    return mostRecent.swagger.path;
  }

  return undefined;
}

/**
 * Get operations from all previous versions that also exist in current swagger
 */
export async function getExistedVersionOperations(
  targetSwaggerPath: string,
  availableSwaggers: Swagger[],
  targetOperations: Operation[],
): Promise<Map<string, Operation[]>> {
  const result = new Map<string, Operation[]>();

  if (availableSwaggers.length === 0 || targetOperations.length === 0) {
    return result;
  }

  const currentVersion = await getVersionFromInputFile(targetSwaggerPath);
  const fileName = getBaseNameForSwagger(targetSwaggerPath, currentVersion);

  // Load version info for all swaggers to enable filtering
  const swaggersWithVersions = await Promise.all(
    availableSwaggers.map(async (swagger) => {
      const version = await getVersionFromInputFile(swagger.path);
      return {
        swagger,
        version,
        fileName: getBaseNameForSwagger(swagger.path, version),
      };
    }),
  );

  // Get all current and previous versions of the swaggers with different fileNames
  const previousVersionSwaggers = swaggersWithVersions
    .filter((item) => item.fileName !== fileName && item.version <= currentVersion)
    .sort((a, b) => a.version.localeCompare(b.version))
    .map((item) => item.swagger);

  // Collect operations from all previous versions that also exist in current version
  for (const previousSwagger of previousVersionSwaggers) {
    try {
      // Check if getOperations method exists
      if (!previousSwagger.getOperations) {
        continue;
      }

      const previousOperationsMap = await previousSwagger.getOperations();
      const previousOperations = [...previousOperationsMap.values()];

      // Find operations that exist in both this previous version AND current version
      const matchingOperations = previousOperations.filter((operation) => {
        return targetOperations.some(
          (currentOp) =>
            currentOp.path === operation.path &&
            currentOp.id === operation.id &&
            currentOp.httpMethod === operation.httpMethod,
        );
      });
      result.set(previousSwagger.path, matchingOperations);
    } catch (e) {
      logError(
        `Failed to get operations for previous swagger: ${previousSwagger.path}. This may be due to the swagger file being inaccessible or malformed.`,
      );
      throw e;
    }
  }

  return result;
}

/**
 * Get preceding swagger versions for a given swagger file
 */
export async function getPrecedingSwaggers(
  targetSwaggerPath: string,
  availableSwaggers: Swagger[],
): Promise<{ preview?: string; stable?: string }> {
  return {
    preview: await getPrecedingSwaggerByType(
      targetSwaggerPath,
      availableSwaggers,
      ApiVersionLifecycleStage.PREVIEW,
    ),
    stable: await getPrecedingSwaggerByType(
      targetSwaggerPath,
      availableSwaggers,
      ApiVersionLifecycleStage.STABLE,
    ),
  };
}

/**
 * Get base name for swagger file
 * @param {string} filePath - Path to swagger file
 * @param {string} [version] - Version string to use for base name
 * @returns {string} - Base name for the swagger file
 */
export function getBaseNameForSwagger(filePath: string, version: string = ""): string {
  if (version) {
    const segments = filePath.split("/");
    const index = segments.findIndex((v) => v.startsWith(version));
    if (index !== -1) {
      return segments.slice(index + 1).join("/");
    }
  }
  return basename(filePath);
}

/**
 * Deduplicate swagger objects in an array by their path.
 * @param swaggers The array of swagger objects to deduplicate.
 * @returns A new array with duplicate swagger objects removed.
 */
export function deduplicateSwaggers(swaggers: Swagger[]): Swagger[] {
  // Deduplicate by path
  return [...new Map(swaggers.map((s) => [s.path, s])).values()];
}
