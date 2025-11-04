import { Octokit } from "@octokit/rest";
import { FileCategory, FileChange, PRSummary, PRSummaryOptions } from "./types.js";

/**
 * Categorizes files based on their path and extension
 */
function categorizeFile(filename: string): string {
  // TypeSpec files
  if (
    filename.endsWith(".tsp") ||
    filename.includes("/tsp-location.yaml") ||
    filename.includes("/tspconfig.yaml")
  ) {
    return "TypeSpec";
  }

  // OpenAPI/Swagger specs
  if (
    filename.match(/\.json$/) &&
    filename.includes("/specification/") &&
    !filename.includes("/examples/")
  ) {
    return "OpenAPI Specs";
  }

  // Examples
  if (filename.includes("/examples/")) {
    return "Examples";
  }

  // Documentation
  if (filename.match(/\.(md|txt)$/i)) {
    return "Documentation";
  }

  // Configuration files
  if (
    filename.match(/\.(ya?ml|json)$/) &&
    (filename.includes("package") ||
      filename.includes("tsconfig") ||
      filename.includes("config") ||
      filename.startsWith("."))
  ) {
    return "Configuration";
  }

  // Test files
  if (filename.includes("/test/") || filename.includes(".test.") || filename.includes(".spec.")) {
    return "Tests";
  }

  // Workflow/CI files
  if (filename.includes(".github/workflows") || filename.includes(".azure-pipelines")) {
    return "CI/CD";
  }

  // Scripts
  if (filename.match(/\.(js|ts|py|sh|ps1)$/) && !filename.includes("/test/")) {
    return "Scripts";
  }

  return "Other";
}

/**
 * Fetches PR details and files from GitHub API
 */
export async function fetchPRDetails(
  octokit: Octokit,
  options: PRSummaryOptions,
): Promise<PRSummary> {
  const { owner, repo, number } = options;

  // Fetch PR details
  const { data: pr } = await octokit.rest.pulls.get({
    owner,
    repo,
    pull_number: number,
  });

  // Fetch all files changed in the PR
  const files: FileChange[] = [];
  let page = 1;
  const perPage = 100;
  let hasMore = true;

  while (hasMore) {
    const { data: prFiles } = await octokit.rest.pulls.listFiles({
      owner,
      repo,
      pull_number: number,
      per_page: perPage,
      page,
    });

    files.push(
      ...prFiles.map((file) => ({
        filename: file.filename,
        status: file.status as FileChange["status"],
        additions: file.additions,
        deletions: file.deletions,
        changes: file.changes,
        patch: file.patch,
      })),
    );

    hasMore = prFiles.length === perPage;
    page++;
  }

  // Categorize files
  const categoriesMap = new Map<string, FileCategory>();

  for (const file of files) {
    const categoryName = categorizeFile(file.filename);

    if (!categoriesMap.has(categoryName)) {
      categoriesMap.set(categoryName, {
        name: categoryName,
        files: [],
        totalAdditions: 0,
        totalDeletions: 0,
        totalChanges: 0,
      });
    }

    const category = categoriesMap.get(categoryName)!;
    category.files.push(file);
    category.totalAdditions += file.additions;
    category.totalDeletions += file.deletions;
    category.totalChanges += file.changes;
  }

  // Sort categories by total changes (descending)
  const categories = Array.from(categoriesMap.values()).sort(
    (a, b) => b.totalChanges - a.totalChanges,
  );

  return {
    number: pr.number,
    title: pr.title,
    body: pr.body || "",
    author: pr.user?.login || "unknown",
    state: pr.state,
    createdAt: pr.created_at,
    updatedAt: pr.updated_at,
    additions: pr.additions || 0,
    deletions: pr.deletions || 0,
    changedFiles: pr.changed_files || 0,
    commits: pr.commits || 0,
    categories,
  };
}

/**
 * Generates a markdown summary from PR details
 */
export function generateMarkdownSummary(summary: PRSummary): string {
  const lines: string[] = [];

  // Header
  lines.push(`# PR #${summary.number}: ${summary.title}`);
  lines.push("");

  // Metadata
  lines.push("## Metadata");
  lines.push("");
  lines.push(`- **Author**: @${summary.author}`);
  lines.push(`- **State**: ${summary.state}`);
  lines.push(`- **Created**: ${new Date(summary.createdAt).toLocaleString()}`);
  lines.push(`- **Updated**: ${new Date(summary.updatedAt).toLocaleString()}`);
  lines.push(`- **Commits**: ${summary.commits}`);
  lines.push("");

  // Statistics
  lines.push("## Change Statistics");
  lines.push("");
  lines.push(`- **Files Changed**: ${summary.changedFiles}`);
  lines.push(`- **Lines Added**: +${summary.additions}`);
  lines.push(`- **Lines Deleted**: -${summary.deletions}`);
  lines.push(`- **Total Changes**: ${summary.additions + summary.deletions}`);
  lines.push("");

  // Description
  if (summary.body && summary.body.trim()) {
    lines.push("## Description");
    lines.push("");
    lines.push(summary.body.trim());
    lines.push("");
  }

  // Changes by category
  lines.push("## Changes by Category");
  lines.push("");

  for (const category of summary.categories) {
    lines.push(`### ${category.name} (${category.files.length} files)`);
    lines.push("");
    lines.push(
      `- **Additions**: +${category.totalAdditions} | **Deletions**: -${category.totalDeletions} | **Total**: ${category.totalChanges}`,
    );
    lines.push("");

    // List files
    for (const file of category.files) {
      const statusIcon = {
        added: "🆕",
        removed: "🗑️",
        modified: "✏️",
        renamed: "📝",
      }[file.status];

      lines.push(`- ${statusIcon} \`${file.filename}\` (+${file.additions}/-${file.deletions})`);
    }

    lines.push("");
  }

  return lines.join("\n");
}
