import { mkdir, writeFile } from "node:fs/promises";
import { dirname } from "node:path";
import type { GitHubScriptArgs } from "../github.ts";

export async function publishStatus({
  core,
  statusArtifactPath,
  shouldRun,
}: {
  core: GitHubScriptArgs["core"];
  statusArtifactPath: string;
  shouldRun: string;
}): Promise<void> {
  core.setOutput("should-run", shouldRun);
  await mkdir(dirname(statusArtifactPath), { recursive: true });
  await writeFile(statusArtifactPath, `${shouldRun}\n`);
}
