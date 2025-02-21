import path from "node:path";
import {
  execAsync,
  getChangedFiles,
  searchRelatedParentFolders,
  searchRelatedTypeSpecProjectBySharedLibrary,
  searchSharedLibrary,
} from "./utils.js";
import { logMessage } from "./log.js";
import { SpecGenSdkCmdInput } from "./types.js";

const readmeMdRegex = /^readme.md$/;
const typespecProjectRegex = /^tspconfig.yaml$/;
const typespecProjectSharedLibraryRegex = /[^/]+\.Shared/;

type ChangedSpecs = {
  [K in "readmeMd" | "typespecProject"]?: string;
} & {
  specs: string[];
};

export async function detectChangedSpecConfigFiles(
  commandInput: SpecGenSdkCmdInput,
): Promise<ChangedSpecs[]> {
  const prChangedFiles: string[] = getChangedFiles(commandInput.localSpecRepoPath) ?? [];
  if (prChangedFiles.length === 0) {
    logMessage("No files changed in the PR");
  }
  logMessage(`Changed files in the PR: ${prChangedFiles.length}`);
  const fileList = prChangedFiles.filter((p) => !p.includes("/scenarios/"));
  const { stdout: headCommitRaw } = await execAsync("git rev-parse HEAD");
  const headCommit = headCommitRaw.trim(); // Trim any newline characters
  const { stdout: treeIdRaw } = await execAsync(`git rev-parse ${headCommit}^{tree}`);
  const treeId = treeIdRaw.trim();

  logMessage(`Related readme.md and typespec project list:`);
  const changedSpecs: ChangedSpecs[] = [];
  const readmeMDResult = await searchRelatedParentFolders(fileList, {
    searchFileRegex: readmeMdRegex,
    specFolder: commandInput.localSpecRepoPath,
    treeId,
  });
  const typespecProjectResult = await searchRelatedParentFolders(fileList, {
    searchFileRegex: typespecProjectRegex,
    specFolder: commandInput.localSpecRepoPath,
    treeId,
  });
  const typespecProjectSharedLibraries = searchSharedLibrary(fileList, {
    searchFileRegex: typespecProjectSharedLibraryRegex,
    specFolder: commandInput.localSpecRepoPath,
    treeId,
  });
  const typespecProjectResultSearchedBySharedLibrary =
    await searchRelatedTypeSpecProjectBySharedLibrary(typespecProjectSharedLibraries, {
      searchFileRegex: typespecProjectRegex,
      specFolder: commandInput.localSpecRepoPath,
      treeId,
    });
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
  const result: { [folderPath: string]: string[] } = {};
  for (const folderPath of Object.keys(readmeMDResult)) {
    result[folderPath] = readmeMDResult[folderPath];
  }

  for (const folderPath of Object.keys(typespecProjectResult)) {
    result[folderPath] = typespecProjectResult[folderPath];
  }
  for (const folderPath of Object.keys(result)) {
    const readmeMdPath = path.join(folderPath, "readme.md");
    const cs: ChangedSpecs = {
      readmeMd: readmeMdPath,
      specs: readmeMDResult[folderPath],
    };

    if (typespecProjectResult[folderPath]) {
      delete cs.readmeMd;
      cs.specs = typespecProjectResult[folderPath];
      cs.typespecProject = path.join(folderPath, "tspconfig.yaml");
      logMessage(`\t tspconfig.yaml file: ${cs.typespecProject}`);
    } else {
      logMessage(`\t readme.md file: ${readmeMdPath}`);
    }
    changedSpecs.push(cs);
  }

  return changedSpecs;
}
