import * as core from "@actions/core";
import { context, getOctokit } from "@actions/github";
import type { WorkflowArguments } from "./github.ts";

export { context, core };

export function createWorkflowArguments(): WorkflowArguments {
  const token = process.env.GITHUB_TOKEN;
  if (!token) {
    throw new Error("GITHUB_TOKEN must be set for commands that call the GitHub API");
  }
  return {
    github: getOctokit(token, { log: core.isDebug() ? console : undefined }),
    context,
    core,
  };
}

export async function runWorkflow(
  main: () => unknown,
  resultEncoding: "json" | "string" = "json",
): Promise<void> {
  try {
    const result = await main();
    core.setOutput("result", resultEncoding === "string" ? String(result) : JSON.stringify(result));
  } catch (error) {
    console.error(error);
    core.setFailed(`Unhandled error: ${String(error)}`);
  }
}
