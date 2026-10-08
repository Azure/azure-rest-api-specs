import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { execFile } from "../../shared/src/exec.ts";
import { inlineCode } from "../../shared/src/markdown.ts";
import { createCodeOwnerReviewGuidance, getProtectedFiles } from "./codeowner-review.ts";
import { CoreLogger } from "./core-logger.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

export async function runProtectedFiles(args: Pick<GitHubScriptArgs, "context" | "core">) {
  const { core } = args;
  let result;
  try {
    result = await checkProtectedFiles(args);
  } catch (error) {
    const title = "Unable to generate code-owner review guidance";
    const message = error instanceof Error ? error.message : String(error);
    core.error(error instanceof Error ? error : message);
    core.setFailed(title);
    await core.summary
      .addRaw(
        `## ${title}\n\n` +
          "> [!CAUTION]\n" +
          "> Protected Files could not evaluate this PR. This is an automation error, not a missing code-owner approval.\n\n" +
          `**Evaluation error:** ${inlineCode(message)}\n\n` +
          "Rerun the failed job. If it still fails, contact the repository maintainers " +
          "and include this error and the workflow run link.\n\n" +
          "GitHub's required code-owner reviews and other merge requirements still apply.",
      )
      .write();
    throw error;
  }
  await core.summary.addRaw(`## ${result.title}\n\n${result.summary}`).write();
  return result;
}

export async function checkProtectedFiles({
  context,
  core,
}: Pick<GitHubScriptArgs, "context" | "core">): Promise<{
  conclusion: "success";
  title: string;
  summary: string;
  protectedFiles: string[];
}> {
  if (context.eventName !== "pull_request") {
    throw new Error(`Unsupported event for Protected Files: '${context.eventName}'`);
  }
  const payload = context.payload as WebhookEvent<"pull-request">;
  if (!payload.pull_request?.base?.sha) {
    throw new Error("Protected Files requires a pull request base SHA");
  }
  const logger = new CoreLogger(core);
  const changedFiles = await getChangedFiles({
    // Include deletions and both sides of renames in review guidance.
    gitOptions: ["--no-renames"],
    logger,
  });
  const protectedFiles = getProtectedFiles(changedFiles);
  if (protectedFiles.length === 0) {
    core.info("No changes to protected files.");
    return {
      conclusion: "success",
      title: "No changes to protected files",
      summary: "This PR does not change protected files.",
      protectedFiles,
    };
  }
  const { stdout: codeOwners } = await execFile("git", ["show", "HEAD^:.github/CODEOWNERS"], {
    logger,
  });
  const { owner, repo } = context.repo;
  const summary = createCodeOwnerReviewGuidance(
    codeOwners,
    changedFiles,
    `https://github.com/${owner}/${repo}/blob/${payload.pull_request.base.sha}/.github/CODEOWNERS`,
    core,
  );
  core.info(
    "Code-owner review guidance generated; GitHub's required reviews remain the approval gate.",
  );
  return { conclusion: "success", title: "Changes to protected files", summary, protectedFiles };
}
