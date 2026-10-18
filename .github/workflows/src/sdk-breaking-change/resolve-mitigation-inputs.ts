import { mkdir, readFile, writeFile } from "node:fs/promises";
import { dirname, isAbsolute, join, relative, sep } from "node:path";
import { unzipSync } from "fflate";
import { AnalysisResultSchema } from "./types.ts";
import { publishStatus } from "./status.ts";
import type { GitHubScriptArgs } from "../github.ts";
import { SdkName } from "@azure-tools/specs-shared/sdk-types";

function toUint8Array(data: unknown): Uint8Array {
  if (data instanceof ArrayBuffer) {
    return new Uint8Array(data);
  }
  if (ArrayBuffer.isView(data)) {
    return new Uint8Array(data.buffer, data.byteOffset, data.byteLength);
  }
  throw new TypeError("Expected artifact download data to be binary.");
}

async function extractArtifact(data: unknown, destinationPath: string): Promise<void> {
  const files = unzipSync(toUint8Array(data));
  await mkdir(destinationPath, { recursive: true });
  for (const [name, contents] of Object.entries(files)) {
    const outputPath = join(destinationPath, name);
    const relativePath = relative(destinationPath, outputPath);
    if (
      relativePath === "" ||
      relativePath === ".." ||
      relativePath.startsWith(`..${sep}`) ||
      isAbsolute(relativePath)
    ) {
      throw new Error(`Invalid artifact entry path: ${name}`);
    }
    if (name.endsWith("/")) {
      await mkdir(outputPath, { recursive: true });
    } else {
      await mkdir(dirname(outputPath), { recursive: true });
      await writeFile(outputPath, contents);
    }
  }
}

async function downloadArtifactByName({
  artifactName,
  context,
  destinationPath,
  github,
  workflowRunId,
}: Pick<GitHubScriptArgs, "context" | "github"> & {
  artifactName: string;
  destinationPath: string;
  workflowRunId: number;
}): Promise<void> {
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    ...context.repo,
    run_id: workflowRunId,
    per_page: 100,
  });
  const matches = artifacts.filter(({ name }) => name === artifactName);
  if (matches.length !== 1) {
    throw new Error(`Expected one ${artifactName} artifact, found ${matches.length}.`);
  }
  const { data } = await github.rest.actions.downloadArtifact({
    ...context.repo,
    artifact_id: matches[0].id,
    archive_format: "zip",
  });
  await extractArtifact(data, destinationPath);
}

export async function resolveMitigationTrigger({
  github,
  context,
  core,
  analysisArtifactName,
  analysisStatusArtifactName,
  analysisStatusPath,
  mitigationStatusPath,
  publishedResultsPath,
  workflowRunId,
}: GitHubScriptArgs & {
  analysisArtifactName: string;
  analysisStatusArtifactName: string;
  analysisStatusPath: string;
  mitigationStatusPath: string;
  publishedResultsPath: string;
  workflowRunId: number;
}): Promise<void> {
  let shouldRun = "false";
  try {
    await downloadArtifactByName({
      artifactName: analysisStatusArtifactName,
      context,
      destinationPath: dirname(analysisStatusPath),
      github,
      workflowRunId,
    });
    const analysisRun = (await readFile(analysisStatusPath, "utf8")).trim();
    if (analysisRun !== "true") {
      core.notice("The SDK breaking-change analysis was not requested.");
      shouldRun = "false";
      return;
    }

    await downloadArtifactByName({
      artifactName: analysisArtifactName,
      context,
      destinationPath: dirname(publishedResultsPath),
      github,
      workflowRunId,
    });
    const analysis = AnalysisResultSchema.parse(
      JSON.parse(await readFile(publishedResultsPath, "utf8")),
    );
    if (analysis.status !== "success") {
      core.notice("The SDK breaking-change analysis did not succeed.");
      shouldRun = "false";
      return;
    }

    const sdkRepository = SdkName[analysis.sdkLanguage as keyof typeof SdkName];
    const { data: pull } = await github.rest.pulls.get({
      ...context.repo,
      pull_number: analysis.prNumber,
    });
    if (pull.head.sha !== analysis.headSha) {
      core.notice(
        `Pull request head ${pull.head.sha} does not match analyzed head ${analysis.headSha}.`,
      );
      shouldRun = "false";
      return;
    }

    shouldRun = "true";
    core.setOutput("pr-number", analysis.prNumber);
    core.setOutput("sdk-language", analysis.sdkLanguage);
    core.setOutput("sdk-repository", sdkRepository);
    core.setOutput("head-repository", pull.head.repo.full_name);
    core.setOutput("head-sha", pull.head.sha);
    core.setOutput("head-branch", pull.head.ref);
  } finally {
    await publishStatus({
      core,
      statusArtifactPath: mitigationStatusPath,
      shouldRun,
    });
  }
}
