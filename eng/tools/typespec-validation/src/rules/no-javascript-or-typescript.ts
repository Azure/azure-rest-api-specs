import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import type { RuleResult } from "@azure-tools/specs-shared/rule-result";
import { join } from "pathe";
import type { ChangedProjectsOptions } from "../find-projects.ts";

export async function checkNoJavaScriptOrTypeScript(
  root: string,
  options: ChangedProjectsOptions,
): Promise<RuleResult> {
  const changes = await getChangedFilesStatuses({
    cwd: root,
    baseCommitish: options.baseCommitish,
    headCommitish: options.headCommitish,
    gitOptions: ["--find-renames"],
    logger: options.logger,
  });
  const files = [...changes.additions, ...changes.renames.map(({ to }) => to)].filter(
    (path) => path.startsWith("specification/") && /\.(?:[cm]?[jt]s|[jt]sx)$/i.test(path),
  );

  if (files.length === 0) {
    return { success: true, skipped: "No JavaScript or TypeScript files added." };
  }

  return {
    success: false,
    diagnostics: files.map((path) => ({
      severity: "error",
      code: "no-javascript-or-typescript",
      message:
        "JavaScript and TypeScript files must not be added under specification/. " +
        "Remove this file or move tooling code outside specification/.",
      path: join(root, path),
    })),
  };
}
