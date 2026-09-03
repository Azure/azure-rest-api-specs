import { mkdirSync, writeFileSync } from "node:fs";
import path from "node:path";
import process from "node:process";
import { parseCliArguments } from "./args.ts";
import { postReleasePlanComment, postReleasePlanErrorComment } from "./pr-comment.ts";
import {
  createAzdskRunner,
  ensureReleasePlan,
  getApiReleaseType,
  getNextMonthTarget,
  getSdkReleaseType,
} from "./release-plan.ts";
import type { CliArguments, OctokitLike, TypeSpecProjectInfo } from "./types.ts";
import {
  createOctokit,
  FOLDER_MIGRATION_LABEL,
  getCommitChangedFiles,
  getPrChangedFiles,
  getPullRequestLabels,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
  NEW_API_VERSION_LABEL,
} from "./typespec-project.ts";

/**
 * Main CLI entry point.
 */
export async function main(): Promise<void> {
  let projectInfo: TypeSpecProjectInfo | null = null;
  let resolvedPrNumber: number | undefined;
  let hasNewApiVersionLabel = false;
  let isTspConfigChanged = false;
  let releasePlanEnsured = false;
  let args: CliArguments;
  let octokit: OctokitLike;

  try {
    args = parseCliArguments();
    octokit = createOctokit(undefined);

    // Use provided PR number if available, otherwise fall back to commit SHA
    if (args.prNumber) {
      console.log(`Analyzing PR #${args.prNumber} in ${args.owner}/${args.repo}`);

      const labels = await getPullRequestLabels({
        octokit,
        owner: args.owner,
        repo: args.repo,
        prNumber: args.prNumber,
      });

      if (labels.includes(FOLDER_MIGRATION_LABEL)) {
        console.log(
          `PR #${args.prNumber} has the '${FOLDER_MIGRATION_LABEL}' label. Skipping release plan processing.`,
        );
        process.exit(0);
      }

      // Check for new-api-version label
      hasNewApiVersionLabel = labels.includes(NEW_API_VERSION_LABEL);

      // Check if PR contains TypeSpec files (.tsp or tspconfig.yaml)
      const allFiles = await getPrChangedFiles({
        octokit,
        owner: args.owner,
        repo: args.repo,
        prNumber: args.prNumber,
      });

      const specFiles = allFiles.filter((f) => f.filename.startsWith("specification/"));
      isTspConfigChanged = specFiles.some((f) => f.filename.endsWith("tspconfig.yaml"));
      const hasTspFiles = specFiles.some((f) => f.filename.endsWith(".tsp"));

      // Skip only if both conditions are true: no label AND no TypeSpec files
      if (!hasNewApiVersionLabel && !hasTspFiles && !isTspConfigChanged) {
        console.log(
          `PR #${args.prNumber} does not have the '${NEW_API_VERSION_LABEL}' label and does not contain TypeSpec files. Skipping release plan processing.`,
        );
        process.exit(0);
      }

      projectInfo = await getTypeSpecProjectInfoFromPr({
        prNumber: args.prNumber,
        owner: args.owner,
        repo: args.repo,
        workspace: args.workspace,
        octokit,
      });

      resolvedPrNumber = args.prNumber;
    } else {
      const commitSha = args.commitSha as string;
      console.log(`Analyzing commit ${commitSha} in ${args.owner}/${args.repo}`);

      const commitResult = await getTypeSpecProjectInfoFromCommit({
        commitSha,
        owner: args.owner,
        repo: args.repo,
        workspace: args.workspace,
        octokit,
      });

      if (commitResult.isFolderMigration) {
        console.log(
          `Commit ${commitSha} is associated with a '${FOLDER_MIGRATION_LABEL}' labeled PR. Skipping release plan processing.`,
        );
        process.exit(0);
      }

      hasNewApiVersionLabel = commitResult.hasNewApiVersionLabel;

      // Check if commit contains TypeSpec files (.tsp or tspconfig.yaml)
      const commitFiles = commitResult.prNumber
        ? await getPrChangedFiles({
            octokit,
            owner: args.owner,
            repo: args.repo,
            prNumber: commitResult.prNumber,
          })
        : await getCommitChangedFiles({
            octokit,
            owner: args.owner,
            repo: args.repo,
            commitSha,
          });

      const specFiles = commitFiles.filter((f) => f.filename.startsWith("specification/"));
      const hasTspFiles = specFiles.some((f) => f.filename.endsWith(".tsp"));
      isTspConfigChanged = specFiles.some((f) => f.filename.endsWith("tspconfig.yaml"));

      // Skip only if both conditions are true: no label AND no TypeSpec files
      if (!hasNewApiVersionLabel && !hasTspFiles && !isTspConfigChanged) {
        console.log(
          `Commit ${commitSha} is not associated with a PR that has the '${NEW_API_VERSION_LABEL}' label and does not contain TypeSpec files. Skipping release plan processing.`,
        );
        process.exit(0);
      }

      projectInfo = commitResult.projectInfo;
      resolvedPrNumber = commitResult.prNumber;
    }

    const prUrl = resolvedPrNumber
      ? `https://github.com/${args.owner}/${args.repo}/pull/${resolvedPrNumber}`
      : undefined;

    if (projectInfo === null) {
      console.log("There are no TypeSpec changes in the PR or commit.");
      process.exit(0);
    }

    console.log(
      `Found TypeSpec project at ${projectInfo.tspProjectPath} with API version ${projectInfo.apiVersion}`,
    );
    const apiReleaseType = getApiReleaseType(projectInfo.isPreview, args.repo);
    const sdkReleaseType = getSdkReleaseType(projectInfo.isPreview);
    const targetMonth = getNextMonthTarget();

    const result = ensureReleasePlan(
      {
        prUrl,
        tspProjectPath: projectInfo.tspProjectPath,
        apiReleaseType,
        sdkReleaseType,
        targetMonth,
        apiVersion: projectInfo.apiVersion,
        testReleasePlan: args.testReleasePlan,
      },
      createAzdskRunner(),
      hasNewApiVersionLabel || isTspConfigChanged,
    );
    releasePlanEnsured = true;

    console.log(JSON.stringify(result, null, 2));

    if (args.outputFile) {
      const outputPath = path.resolve(args.outputFile);
      mkdirSync(path.dirname(outputPath), { recursive: true });
      writeFileSync(outputPath, `${JSON.stringify(result, null, 2)}\n`, "utf8");
      console.log(`Wrote release plan details to ${outputPath}`);
    }

    // Post comment on PR if release plan was created
    if (result.outcome === "created" && resolvedPrNumber) {
      try {
        const planLinkValue = result.releasePlan?.release_plan_link;
        const planIdValue = result.releasePlan?.ReleasePlanId;
        const planLink = typeof planLinkValue === "string" ? planLinkValue : "";
        const planId =
          typeof planIdValue === "string" || typeof planIdValue === "number" ? planIdValue : "";

        await postReleasePlanComment({
          octokit,
          owner: args.owner,
          repo: args.repo,
          prNumber: resolvedPrNumber,
          planId,
          planLink,
          apiVersion: projectInfo.apiVersion,
          tspProjectPath: projectInfo.tspProjectPath,
        });

        console.log("Posted release plan comment on PR.");
      } catch (commentError) {
        const message = commentError instanceof Error ? commentError.message : String(commentError);
        console.warn(`Warning: Failed to post comment on PR: ${message}`);
      }
    } else if (result.outcome === "created") {
      console.log("Release plan created, but no associated PR was found. Skipping PR comment.");
    } else if (result.outcome === "not_found") {
      console.log("new-api-version label not present and no existing release plan was found.");
    }
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    console.error(`release-plan tool failed: ${message}`);

    // Try to post error comment on PR if available and PR has new-api-version label
    if (
      !releasePlanEnsured &&
      resolvedPrNumber &&
      projectInfo &&
      (hasNewApiVersionLabel || isTspConfigChanged)
    ) {
      try {
        await postReleasePlanErrorComment({
          octokit: octokit!,
          owner: args!.owner,
          repo: args!.repo,
          prNumber: resolvedPrNumber,
          error: message,
          tspProjectPath: projectInfo.tspProjectPath,
        });
        console.log("Posted error comment on PR.");
      } catch (commentError) {
        const commentMsg =
          commentError instanceof Error ? commentError.message : String(commentError);
        console.warn(`Warning: Failed to post error comment on PR: ${commentMsg}`);
      }
    }

    process.exit(1);
  }
}

export { parseCliArguments } from "./args.ts";
export {
  buildReleaseplanCommentBody,
  postReleasePlanComment,
  postReleasePlanErrorComment,
} from "./pr-comment.ts";
export type { CommentBodyParams, ErrorCommentParams, PrCommentParams } from "./pr-comment.ts";
export {
  createAzdskRunner,
  ensureReleasePlan,
  getApiReleaseType,
  getNextMonthTarget,
  getReleasePlanById,
  getSdkReleaseType,
  runAzdskCommand,
} from "./release-plan.ts";
export type {
  ApiReleaseType,
  AzsdkRunner,
  CliArguments,
  CommandResult,
  EnsureReleasePlanResult,
  OctokitLike,
  PullRequestChangedFile,
  ReleasePlanCommandContext,
  TypeSpecProjectInfo,
} from "./types.ts";
export {
  collectTypeSpecProjectPaths,
  compareApiVersionsDesc,
  createOctokit,
  detectApiVersions,
  findTspConfigDir,
  FOLDER_MIGRATION_LABEL,
  getAssociatedPrNumber,
  getCommitChangedFiles,
  getPrChangedFiles,
  getPullRequestLabels,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
  getTypeSpecProjectVersionFromMetadata,
  NEW_API_VERSION_LABEL,
  parseApiVersion,
  resolveTypeSpecMetadata,
} from "./typespec-project.ts";
