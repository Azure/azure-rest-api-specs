import type { WorkflowArguments } from "./github.ts";

export async function requireWorkflowLocks({ github, context, core }: WorkflowArguments) {
  const pr = context.payload.pull_request;
  if (!pr) {
    throw new Error("This workflow must run in the context of a pull request.");
  }
  const files = await github.paginate(github.rest.pulls.listFiles, {
    ...context.repo,
    pull_number: pr.number,
    per_page: 100,
  });
  const changed = new Map(files.map(({ filename, status }) => [filename, status]));
  const sources = files.filter(({ filename }) => /^\.github\/workflows\/[^/]+\.md$/.test(filename));
  const invalid = sources.filter(({ filename, status }) => {
    const lockStatus = changed.get(filename.replace(/\.md$/, ".lock.yml"));
    return status === "removed"
      ? lockStatus !== "removed"
      : !lockStatus || lockStatus === "removed";
  });
  if (invalid.length > 0) {
    core.setFailed(
      `Update the compiled lock for each changed agentic workflow source:\n${invalid
        .map(({ filename, status }) => `  - ${filename} (${status})`)
        .join("\n")}`,
    );
  }
}
