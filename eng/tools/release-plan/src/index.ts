import { mkdirSync, writeFileSync } from "node:fs";
import path from "node:path";
import process from "node:process";
import { parseCliArguments } from "./args.js";
import { postReleasePlanComment } from "./pr-comment.js";
import {
  createAzdskRunner,
  ensureReleasePlan,
  getApiReleaseType,
  getNextMonthTarget,
  getSdkReleaseType,
} from "./release-plan.js";
import type { TypeSpecProjectInfo } from "./types.js";
import {
  checkNewApiVersionLabel,
  createOctokit,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
} from "./typespec-project.js";

/**
 * Main CLI entry point.
 */
export async function main(): Promise<void> {
  try {
    const args = parseCliArguments();
    const octokit = createOctokit(undefined);

    let projectInfo: TypeSpecProjectInfo | null;
    let resolvedPrNumber: number | undefined;
    let hasNewApiVersionLabel: boolean;

    // Use provided PR number if available, otherwise fall back to commit SHA
    if (args.prNumber) {
      console.log(`Analyzing PR #${args.prNumber} in ${args.owner}/${args.repo}`);

      projectInfo = await getTypeSpecProjectInfoFromPr({
        prNumber: args.prNumber,
        owner: args.owner,
        repo: args.repo,
        workspace: args.workspace,
        octokit,
      });

      resolvedPrNumber = args.prNumber;

      hasNewApiVersionLabel = await checkNewApiVersionLabel({
        octokit,
        owner: args.owner,
        repo: args.repo,
        prNumber: args.prNumber,
      });
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

      projectInfo = commitResult.projectInfo;
      resolvedPrNumber = commitResult.prNumber;
      hasNewApiVersionLabel = commitResult.hasNewApiVersionLabel;
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
      createAzdskRunner(args.azsdkPath),
      hasNewApiVersionLabel,
    );

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
    process.exit(1);
  }
}

export { parseCliArguments } from "./args.js";
export { buildReleaseplanCommentBody, postReleasePlanComment } from "./pr-comment.js";
export type { CommentBodyParams, PrCommentParams } from "./pr-comment.js";
export {
  createAzdskRunner,
  ensureReleasePlan,
  getApiReleaseType,
  getNextMonthTarget,
  getSdkReleaseType,
  runAzdskCommand,
} from "./release-plan.js";
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
} from "./types.js";
export {
  collectTypeSpecProjectPaths,
  compareApiVersionsDesc,
  createOctokit,
  detectApiVersions,
  findTspConfigDir,
  getAssociatedPrNumber,
  getCommitChangedFiles,
  getPrChangedFiles,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
  parseApiVersion,
} from "./typespec-project.js";
