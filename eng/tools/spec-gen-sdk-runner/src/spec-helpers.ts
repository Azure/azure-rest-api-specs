import path from "node:path";
import {
  getChangedFiles,
  searchRelatedParentFolders,
  searchSharedLibrary,
  searchRelatedTypeSpecProjectBySharedLibrary,
  groupPathsByService,
  createCombinedSpecs,
  type SpecResults,
  type ChangedSpecs,
  type SpecConfigs,
  getLastPathSegment,
} from "./utils.js";
import { logMessage } from "./log.js";
import { SpecGenSdkCmdInput } from "./types.js";

export const readmeMdRegex = /^readme.md$/;
export const typespecProjectRegex = /^tspconfig.yaml$/;
export const typespecProjectSharedLibraryRegex = /[^/]+\.Shared/;

export function detectChangedSpecConfigFiles(commandInput: SpecGenSdkCmdInput): ChangedSpecs[] {
  const prChangedFiles: string[] = getChangedFiles(commandInput.localSpecRepoPath) ?? [];
  if (prChangedFiles.length === 0) {
    logMessage("No files changed in the PR");
  }
  logMessage(`Changed files in the PR: ${prChangedFiles.length}`);
  for (const file of prChangedFiles) {
    logMessage(`\t${file}`);
  }
  const fileList = prChangedFiles
    .filter((p) => p.startsWith("specification/"))
    .filter((p) => !p.includes("/scenarios/"));

  logMessage(`Related readme.md and typespec project list:`);
  const changedSpecs: ChangedSpecs[] = [];

  const readmeMDResult = searchRelatedParentFolders(fileList, {
    searchFileRegex: readmeMdRegex,
    specRepoFolder: commandInput.localSpecRepoPath,
    stopAtFolder: "specification",
  });

  const typespecProjectResult = searchRelatedParentFolders(fileList, {
    searchFileRegex: typespecProjectRegex,
    specRepoFolder: commandInput.localSpecRepoPath,
    stopAtFolder: "specification",
  });

  const typespecProjectSharedLibraries = searchSharedLibrary(fileList, {
    searchFileRegex: typespecProjectSharedLibraryRegex,
    specRepoFolder: commandInput.localSpecRepoPath,
  });

  const typespecProjectResultSearchedBySharedLibrary = searchRelatedTypeSpecProjectBySharedLibrary(
    typespecProjectSharedLibraries,
    {
      searchFileRegex: typespecProjectRegex,
      specRepoFolder: commandInput.localSpecRepoPath,
    },
  );

  // Merge typespec project results
  for (const folderPath of Object.keys(typespecProjectResultSearchedBySharedLibrary)) {
    if (typespecProjectResult[folderPath]) {
      typespecProjectResult[folderPath] = [
        ...typespecProjectResult[folderPath],
        ...typespecProjectResultSearchedBySharedLibrary[folderPath],
      ];
    } else {
      typespecProjectResult[folderPath] = typespecProjectResultSearchedBySharedLibrary[folderPath];
    }
  }

  // Group paths by service
  const serviceMap = groupPathsByService(readmeMDResult, typespecProjectResult);

  const results: SpecResults = { readmeMDResult, typespecProjectResult };

  // Process each service
  for (const [, info] of serviceMap) {
    // Case: Resource Manager with .Management
    if (info.managementPaths.length > 0) {
      if (info.resourceManagerPaths.length === 1) {
        // Single resource-manager path - match with all Management paths
        const newSpecs = createCombinedSpecs(
          info.resourceManagerPaths[0].path,
          info.managementPaths,
          results,
        );
        changedSpecs.push(...newSpecs);
        logMessage(
          `\t readme folders: ${info.resourceManagerPaths[0].path}, tspconfig folders: ${info.managementPaths}`,
        );
        for (const p of info.managementPaths) {
          delete typespecProjectResult[p];
        }
        delete readmeMDResult[info.resourceManagerPaths[0].path];
      } else {
        // Multiple resource-manager paths - match by subfolder name
        for (const rmPath of info.resourceManagerPaths) {
          const matchingManagements = info.managementPaths.filter((mPath) => {
            const rmSubPath = rmPath.subPath;
            const managementName = getLastPathSegment(mPath).replace(".Management", "");
            return rmSubPath && rmSubPath === managementName;
          });
          if (matchingManagements.length > 0) {
            const newSpecs = createCombinedSpecs(rmPath.path, matchingManagements, results);
            changedSpecs.push(...newSpecs);
            logMessage(
              `\t readme folders: ${rmPath.path}, tspconfig folders: ${matchingManagements}`,
            );
            for (const p of matchingManagements) {
              delete typespecProjectResult[p];
            }
            delete readmeMDResult[rmPath.path];
          }
        }
      }
    }

    // Case: Data Plane matching
    if (info.dataPlanePaths.length > 0 && info.otherTypeSpecPaths.length > 0) {
      if (info.dataPlanePaths.length === 1) {
        // Single data-plane path - match with all non-Management TypeSpec paths
        const newSpecs = createCombinedSpecs(
          info.dataPlanePaths[0].path,
          info.otherTypeSpecPaths,
          results,
        );
        changedSpecs.push(...newSpecs);
        logMessage(
          `\t readme folders: ${info.dataPlanePaths[0].path}, tspconfig folders: ${info.otherTypeSpecPaths}`,
        );
        for (const p of info.otherTypeSpecPaths) {
          delete typespecProjectResult[p];
        }
        delete readmeMDResult[info.dataPlanePaths[0].path];
      } else {
        // Multiple data-plane paths - match by subfolder name
        for (const dpPath of info.dataPlanePaths) {
          const matchingTypeSpecs = info.otherTypeSpecPaths.filter((tsPath) => {
            const dpSubFolder = dpPath.subFolder;
            const tsLastSegment = getLastPathSegment(tsPath);
            return dpSubFolder && dpSubFolder === tsLastSegment;
          });
          if (matchingTypeSpecs.length > 0) {
            const newSpecs = createCombinedSpecs(dpPath.path, matchingTypeSpecs, results);
            changedSpecs.push(...newSpecs);
            logMessage(
              `\t readme folders: ${dpPath.path}, tspconfig folders: ${matchingTypeSpecs}`,
            );
            for (const p of matchingTypeSpecs) {
              delete typespecProjectResult[p];
            }
            delete readmeMDResult[dpPath.path];
          }
        }
      }
    }
  }

  // Process remaining unmatched paths
  for (const folderPath of new Set([
    ...Object.keys(readmeMDResult),
    ...Object.keys(typespecProjectResult),
  ])) {
    const cs: ChangedSpecs = {
      specs: [],
    };

    if (typespecProjectResult[folderPath]) {
      cs.specs = typespecProjectResult[folderPath];
      cs.typespecProject = path.join(folderPath, "tspconfig.yaml");
      logMessage(`\t tspconfig: ${cs.typespecProject}`);
    } else {
      cs.readmeMd = path.join(folderPath, "readme.md");
      cs.specs = readmeMDResult[folderPath];
      logMessage(`\t readme: ${cs.readmeMd}`);
    }

    changedSpecs.push(cs);
  }

  return changedSpecs;
}

/**
 * Grouping spec configs by service based on the provided TypeSpec configs and readme files.
 * @param tspconfigs - Array of TypeSpec config file paths.
 * @param readmes - Array of readme file paths.
 * @param skipUnmatchedReadme - Flag to skip unmatched readme files.
 * @returns An array of SpecConfigs objects containing the paths to the readme and TypeSpec config files.
 */
export function groupSpecConfigPaths(
  tspconfigs?: string[],
  readmes?: string[],
  skipUnmatchedReadme: boolean = false,
): SpecConfigs[] {
  const emptyArray: string[] = [];
  const safeTspConfigs = tspconfigs ?? emptyArray;
  const safeReadmes = readmes ?? emptyArray;

  // Quick return for simple cases
  if (safeTspConfigs.length === 0 && safeReadmes.length === 0) {
    return [];
  } else if (safeTspConfigs.length > 0 && safeReadmes.length === 0) {
    return safeTspConfigs.map((c) => ({ tspconfigPath: c }));
  } else if (safeReadmes.length > 0 && safeTspConfigs.length === 0) {
    return safeReadmes.map((c) => ({ readmePath: c }));
  }

  // Get folder paths from spec configs
  const tspconfigFolderPaths: string[] = safeTspConfigs.map((p) =>
    p.slice(0, Math.max(0, p.lastIndexOf("/"))),
  );
  const readmeFolderPaths: string[] = safeReadmes.map((p) =>
    p.slice(0, Math.max(0, p.lastIndexOf("/"))),
  );

  // Create plain objects to satisfy the input of groupPathsByService
  const tspconfigFolderMap: { [folderPath: string]: string[] } = {};
  for (const folderPath of tspconfigFolderPaths) {
    tspconfigFolderMap[folderPath] = [];
  }

  const readmeFolderMap: { [folderPath: string]: string[] } = {};
  for (const folderPath of readmeFolderPaths) {
    readmeFolderMap[folderPath] = [];
  }

  // Group paths by service
  const serviceMap = groupPathsByService(readmeFolderMap, tspconfigFolderMap);

  const changedSpecs: ChangedSpecs[] = [];
  const results: SpecResults = {
    readmeMDResult: readmeFolderMap,
    typespecProjectResult: tspconfigFolderMap,
  };

  // Process each service
  for (const [, info] of serviceMap) {
    // Case: Resource Manager with .Management
    if (info.managementPaths.length > 0) {
      if (info.resourceManagerPaths.length === 1) {
        // Single resource-manager path - match with all Management paths
        const newSpecs = createCombinedSpecs(
          info.resourceManagerPaths[0].path,
          info.managementPaths,
          results,
        );
        changedSpecs.push(...newSpecs);
        logMessage(
          `\t readme folders: ${info.resourceManagerPaths[0].path}, tspconfig folders: ${info.managementPaths}`,
        );
        for (const p of info.managementPaths) {
          delete tspconfigFolderMap[p];
        }
        delete readmeFolderMap[info.resourceManagerPaths[0].path];
      } else {
        // Multiple resource-manager paths - match by subfolder name
        for (const rmPath of info.resourceManagerPaths) {
          const matchingManagements = info.managementPaths.filter((mPath) => {
            const rmSubPath = rmPath.subPath;
            const managementName = getLastPathSegment(mPath).replace(".Management", "");
            return rmSubPath && rmSubPath === managementName;
          });
          if (matchingManagements.length > 0) {
            const newSpecs = createCombinedSpecs(rmPath.path, matchingManagements, results);
            changedSpecs.push(...newSpecs);
            logMessage(
              `\t readme folders: ${rmPath.path}, tspconfig folders: ${matchingManagements}`,
            );
            for (const p of matchingManagements) {
              delete tspconfigFolderMap[p];
            }
            delete readmeFolderMap[rmPath.path];
          }
        }
      }
    }

    // Case: Data Plane matching
    if (info.dataPlanePaths.length > 0 && info.otherTypeSpecPaths.length > 0) {
      if (info.dataPlanePaths.length === 1) {
        // Single data-plane path - match with all non-Management TypeSpec paths
        const newSpecs = createCombinedSpecs(
          info.dataPlanePaths[0].path,
          info.otherTypeSpecPaths,
          results,
        );
        changedSpecs.push(...newSpecs);
        logMessage(
          `\t readme folders: ${info.dataPlanePaths[0].path}, tspconfig folders: ${info.otherTypeSpecPaths}`,
        );
        for (const p of info.otherTypeSpecPaths) {
          delete tspconfigFolderMap[p];
        }
        delete readmeFolderMap[info.dataPlanePaths[0].path];
      } else {
        // Multiple data-plane paths - match by subfolder name
        for (const dpPath of info.dataPlanePaths) {
          const matchingTypeSpecs = info.otherTypeSpecPaths.filter((tsPath) => {
            const dpSubFolder = dpPath.subFolder;
            const tsLastSegment = getLastPathSegment(tsPath);
            return dpSubFolder && dpSubFolder === tsLastSegment;
          });
          if (matchingTypeSpecs.length > 0) {
            const newSpecs = createCombinedSpecs(dpPath.path, matchingTypeSpecs, results);
            changedSpecs.push(...newSpecs);
            logMessage(
              `\t readme folders: ${dpPath.path}, tspconfig folders: ${matchingTypeSpecs}`,
            );
            for (const p of matchingTypeSpecs) {
              delete tspconfigFolderMap[p];
            }
            delete readmeFolderMap[dpPath.path];
          }
        }
      }
    }
  }

  // Process remaining unmatched paths
  for (const folderPath of new Set([
    ...Object.keys(readmeFolderMap),
    ...Object.keys(tspconfigFolderMap),
  ])) {
    const cs: ChangedSpecs = {
      specs: [],
    };

    if (tspconfigFolderMap[folderPath]) {
      cs.specs = tspconfigFolderMap[folderPath];
      cs.typespecProject = path.join(folderPath, "tspconfig.yaml");
      changedSpecs.push(cs);
      logMessage(`\t tspconfig: ${cs.typespecProject}`);
    } else if (!skipUnmatchedReadme) {
      cs.readmeMd = path.join(folderPath, "readme.md");
      cs.specs = readmeFolderMap[folderPath];
      changedSpecs.push(cs);
      logMessage(`\t readme: ${cs.readmeMd}`);
    }
  }

  // Map ChangedSpecs to SpecConfigs
  const specConfigs = changedSpecs.map((cs) => ({
    readmePath: cs.readmeMd,
    tspconfigPath: cs.typespecProject,
  }));
  return specConfigs;
}
