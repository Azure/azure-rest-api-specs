import path from "node:path";
import { logMessage } from "./log.js";
import { SpecGenSdkCmdInput } from "./types.js";
import {
  createCombinedSpecs,
  getChangedFiles,
  getLastPathSegment,
  groupPathsByService,
  searchRelatedParentFolders,
  searchRelatedTypeSpecProjectBySharedLibrary,
  searchSharedLibrary,
  type ChangedSpecs,
  type SpecConfigs,
  type SpecResults,
} from "./utils.js";

export const readmeMdRegex = /^readme.md$/;
export const typespecProjectRegex = /^tspconfig.yaml$/;
export const typespecProjectSharedLibraryRegex = /[^/]+\.Shared/;

/**
 * Processes typespec projects that follow the resource-manager or data-plane folder structure
 * and matches them with corresponding readme files if they exist in the same folder.
 * @param readmeMDResult - Object mapping folder paths to readme file paths
 * @param typespecProjectResult - Object mapping folder paths to typespec project file paths
 * @returns An array of ChangedSpecs objects containing the paths to the readme and TypeSpec config files
 */
export function processTypeSpecProjectsV2FolderStructure(
  readmeMDResult: { [folderPath: string]: string[] },
  typespecProjectResult: { [folderPath: string]: string[] },
): ChangedSpecs[] {
  const changedSpecs: ChangedSpecs[] = [];

  // Iterate through each typespec project folder
  for (const folderPath of Object.keys(typespecProjectResult)) {
    // Split the path into segments to check for specific components
    const segments = folderPath.split(/[/\\]/);
    // Check if the folder path contains resource-manager or data-plane segments
    if (segments.includes("resource-manager") || segments.includes("data-plane")) {
      const cs: ChangedSpecs = {
        specs: [],
      };

      // Set the typespec project path
      cs.typespecProject = path.join(folderPath, "tspconfig.yaml");
      // Initialize the specs array with typespec project files
      cs.specs = [...typespecProjectResult[folderPath]]; // Check if the same folder has a readme.md file
      if (readmeMDResult[folderPath]) {
        cs.readmeMd = path.join(folderPath, "readme.md");
        // Merge the specs arrays, removing duplicates
        cs.specs = [...new Set([...cs.specs, ...readmeMDResult[folderPath]])];
        // Remove the processed entry from readmeMDResult
        delete readmeMDResult[folderPath];
      }

      // Add the ChangedSpecs object to the result array
      changedSpecs.push(cs);
      // Remove the processed entry from typespecProjectResult
      delete typespecProjectResult[folderPath];

      // Delete readme entries that match specific folder structure patterns and are in the same parent folder hierarchy
      // such as:
      // "specification/service/data-plane"
      // "specification/service/resource-manager"
      // "specification/service/resource-manager/Microsoft.Service"
      for (const readmePath of Object.keys(readmeMDResult)) {
        // Split the paths into segments to work with path components rather than raw strings with separators
        const folderSegments = folderPath.split(/[/\\]/); // Split on either / or \
        const readmeSegments = readmePath.split(/[/\\]/);

        // Find the position of "resource-manager" or "data-plane" in folder segments
        const rmIndex = folderSegments.indexOf("resource-manager");
        const dpIndex = folderSegments.indexOf("data-plane");

        // For resource-manager paths
        if (rmIndex !== -1) {
          // Get the service path segments (everything before resource-manager)
          const serviceSegments = folderSegments.slice(0, rmIndex);
          // Check if readmePath shares the same service prefix
          const isRelatedService = serviceSegments.every(
            (segment, i) => i < readmeSegments.length && readmeSegments[i] === segment,
          );

          if (isRelatedService) {
            // Case 1: Readme ends with resource-manager
            // Example: specification/service/resource-manager
            if (
              readmeSegments.length === rmIndex + 1 &&
              readmeSegments[rmIndex] === "resource-manager"
            ) {
              logMessage(`\t Removing related readme: ${readmePath} for folder: ${folderPath}`);
              delete readmeMDResult[readmePath];
              continue;
            }

            // Case 2: Readme is one level down from resource-manager
            // Example: specification/service/resource-manager/Microsoft.Service
            if (
              readmeSegments.length === rmIndex + 2 &&
              readmeSegments[rmIndex] === "resource-manager" &&
              folderSegments.length > rmIndex + 1 &&
              folderSegments[rmIndex + 1] === readmeSegments[rmIndex + 1]
            ) {
              logMessage(`\t Removing related readme: ${readmePath} for folder: ${folderPath}`);
              delete readmeMDResult[readmePath];
              continue;
            }
          }
        }
        // For data-plane paths
        else if (dpIndex !== -1) {
          // Get the service path segments (everything before data-plane)
          const serviceSegments = folderSegments.slice(0, dpIndex);
          // Check if readmePath shares the same service prefix and ends with data-plane
          const isRelatedService = serviceSegments.every(
            (segment, i) => i < readmeSegments.length && readmeSegments[i] === segment,
          );

          if (
            isRelatedService &&
            readmeSegments.length === dpIndex + 1 &&
            readmeSegments[dpIndex] === "data-plane"
          ) {
            logMessage(`\t Removing related readme: ${readmePath} for folder: ${folderPath}`);
            delete readmeMDResult[readmePath];
          }
        }
      }
    }
  }

  return changedSpecs;
}

export function detectChangedSpecConfigFiles(commandInput: SpecGenSdkCmdInput): ChangedSpecs[] {
  const prChangedFiles: string[] = getChangedFiles(commandInput.localSpecRepoPath) ?? [];
  if (prChangedFiles.length === 0) {
    logMessage("No files changed in the PR");
  }
  const normalizedChangedFiles = prChangedFiles.map((f) => f.replaceAll("\\", "/"));
  logMessage(`Changed files in the PR: ${normalizedChangedFiles.length}`);
  for (const file of normalizedChangedFiles) {
    logMessage(`\t${file}`);
  }
  const fileList = normalizedChangedFiles
    .filter((p) => p.startsWith("specification/"))
    .filter((p) => !p.includes("/scenarios/"));

  if (fileList.length === 0) {
    logMessage("No relevant files changed under 'specification' folder in the PR");
    return [];
  }
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

  // Process TypeSpec projects with the V2 folder structure
  const newFolderStructureSpecs = processTypeSpecProjectsV2FolderStructure(
    readmeMDResult,
    typespecProjectResult,
  );

  if (newFolderStructureSpecs.length > 0) {
    logMessage(`Found ${newFolderStructureSpecs.length} specs with the new folder structure`);
    changedSpecs.push(...newFolderStructureSpecs);
    for (const spec of newFolderStructureSpecs) {
      logMessage(`\t\t tspconfig: ${spec.typespecProject}, readme: ${spec.readmeMd}`);
    }
  }

  // Process TypeSpec projects with the old folder structure
  if (Object.keys(readmeMDResult).length > 0 && Object.keys(typespecProjectResult).length > 0) {
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
