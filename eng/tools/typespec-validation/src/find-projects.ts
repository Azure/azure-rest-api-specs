import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import {
  findTypeSpecProjects,
  findTypeSpecProjectsInChangedServices,
} from "@azure-tools/specs-shared/typespec-projects";
import { join } from "pathe";

export interface ChangedProjectsOptions {
  baseCommitish: string;
  headCommitish: string;
  ignoreCoreFiles?: boolean;
  logger: ILogger;
}

const coreFiles = new Set([
  ".gitattributes",
  ".oxfmtrc.json",
  ".prettierrc.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
  "package.json",
  "tsconfig.json",
  "specification/suppressions.yaml",
]);

function isCoreFile(file: string): boolean {
  return (
    coreFiles.has(file) ||
    (file.startsWith(".github/") &&
      file !== ".github/CODEOWNERS" &&
      !file.startsWith(".github/arm-leases/")) ||
    (file.startsWith("eng/") && !file.startsWith("eng/common/")) ||
    file.startsWith("specification/common-types/")
  );
}

export async function findChangedProjects(
  root: string,
  options: ChangedProjectsOptions,
): Promise<{ projects: string[]; checkingAllSpecs: boolean }> {
  const changedFiles = (
    await getChangedFiles({
      cwd: root,
      baseCommitish: options.baseCommitish,
      headCommitish: options.headCommitish,
      logger: options.logger,
    })
  ).filter((file) => !file.includes("ChangedFiles-Functions"));

  if (!options.ignoreCoreFiles && changedFiles.some(isCoreFile)) {
    console.log("Found changes to core eng or root files so checking all specs.");
    return {
      projects: await findTypeSpecProjects(join(root, "specification")),
      checkingAllSpecs: true,
    };
  }

  return {
    projects: await findTypeSpecProjectsInChangedServices(root, changedFiles, options.logger),
    checkingAllSpecs: false,
  };
}
