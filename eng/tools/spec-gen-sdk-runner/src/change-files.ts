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
  getLastPathSegment,
} from "./utils.js";
import { logMessage } from "./log.js";
import { SpecGenSdkCmdInput } from "./types.js";

const readmeMdRegex = /^readme.md$/i;
const typespecProjectRegex = /^tspconfig.yaml$/i;
const typespecProjectSharedLibraryRegex = /[^/]+\.Shared/;

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
