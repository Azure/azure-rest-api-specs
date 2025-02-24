import path from "node:path";
import {
  getChangedFiles,
  searchRelatedParentFolders,
  searchSharedLibrary,
  searchRelatedTypeSpecProjectBySharedLibrary,
} from "./utils.js";
import { logMessage } from "./log.js";
import { SpecGenSdkCmdInput } from "./types.js";

const readmeMdRegex = /^readme.md$/i;
const typespecProjectRegex = /^tspconfig.yaml$/i;
const typespecProjectSharedLibraryRegex = /[^/]+\.Shared/;

type ChangedSpecs = {
  [K in "readmeMd" | "typespecProject"]?: string;
} & {
  specs: string[];
};

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

  // Combine results
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
      logMessage(`\t tspconfig.yaml file: ${cs.typespecProject}`);
    } else {
      cs.readmeMd = path.join(folderPath, "readme.md");
      cs.specs = readmeMDResult[folderPath];
      logMessage(`\t readme.md file: ${cs.readmeMd}`);
    }

    changedSpecs.push(cs);
  }

  return changedSpecs;
}
