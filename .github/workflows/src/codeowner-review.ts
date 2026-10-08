import ignore from "ignore";
import { minimatch } from "minimatch";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { details, inlineCode, link, table } from "../../shared/src/markdown.ts";
import type { Core, GitHub } from "./github.ts";

// Leave room for the existing Next Steps to Merge content within GitHub's comment limit.
const MAX_TABLE_LENGTH = 48_000;
const PROTECTED_PATHS = [
  ".gitignore",
  "cspell.json",
  "cspell.yaml",
  "package.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
  ".github/**",
  ".vscode/**",
  "eng/**",
];
const EXCLUDED_PATHS = [".github/CODEOWNERS", ".github/skills/*", ".github/skills/*/**"];
const SYNCED_PATHS = [
  ".github/skills/azsdk-common-*",
  ".github/skills/azsdk-common-*/**",
  "eng/common",
  "eng/common/**",
];

function matchesAny(file: string, patterns: string[]): boolean {
  // Preserve the protected-path policy's case-insensitive matching, not CODEOWNERS semantics.
  return patterns.some((pattern) =>
    minimatch(file, pattern, { dot: true, nocase: true, platform: "linux" }),
  );
}

export function getProtectedFiles(changedFiles: string[]): string[] {
  return changedFiles.filter(
    (file) =>
      matchesAny(file, SYNCED_PATHS) ||
      (matchesAny(file, PROTECTED_PATHS) && !matchesAny(file, EXCLUDED_PATHS)),
  );
}

interface OwnershipRule {
  pattern: string;
  owners: string[];
  line: number;
  matches: ReturnType<typeof ignore>;
}

function parseCodeOwners(contents: string, core: Core): OwnershipRule[] {
  const rules: OwnershipRule[] = [];
  for (const [index, line] of contents.split(/\r?\n/).entries()) {
    const text = line.trim();
    if (!text || text.startsWith("#")) continue;
    const pattern = text.match(/^(?:\\.|[^\s])+/)?.[0];
    if (!pattern) continue;
    const owners = text.slice(pattern.length).split("#", 1)[0].trim().split(/\s+/).filter(Boolean);
    if (
      pattern.startsWith("!") ||
      pattern.startsWith("\\#") ||
      pattern.includes("[") ||
      pattern.includes("]") ||
      owners.some(
        (owner) => !/^@[\w-]+(?:\/[\w.-]+)?$/.test(owner) && !/^[^\s@]+@[^\s@]+$/.test(owner),
      )
    ) {
      core.warning(`Skipping invalid CODEOWNERS entry on line ${index + 1}.`);
      continue;
    }
    rules.push({
      pattern,
      owners,
      line: index + 1,
      matches: ignore({ ignorecase: false }).add(pattern),
    });
  }
  return rules;
}

function guidanceFor(file: string): string {
  if (matchesAny(file, SYNCED_PATHS)) {
    return (
      "Synchronized from [Azure/azure-sdk-tools](https://github.com/Azure/azure-sdk-tools). " +
      "Make source changes there; edits to these copies can be overwritten."
    );
  }
  return "Repository-managed file; changes need review from repository maintainers or the applicable tooling owners.";
}

function ownerLink(owner: string): string {
  if (!owner.startsWith("@")) return inlineCode(owner);
  const [user, team] = owner.slice(1).split("/");
  return link(
    inlineCode(owner),
    team ? `https://github.com/orgs/${user}/teams/${team}` : `https://github.com/${user}`,
  );
}

function areaFor(file: string): string {
  const [root, directory, tool] = file.split("/");
  if (root === "eng" && directory === "tools" && tool) return `eng/tools/${tool}/`;
  return file.includes("/") ? `${root}/` : "Repository root";
}

export function createCodeOwnerReviewGuidance(
  contents: string,
  changedFiles: string[],
  sourceUrl: string,
  core: Core,
): string {
  const protectedFiles = getProtectedFiles(changedFiles);
  if (protectedFiles.length === 0) return "This PR does not change protected files.";
  const changesSpecifications = changedFiles.some((file) =>
    matchesAny(file, ["specification", "specification/**"]),
  );
  const rules = parseCodeOwners(contents, core).reverse();
  const groups: {
    area: string;
    rule: OwnershipRule | undefined;
    guidance: string;
    files: string[];
  }[] = [];
  for (const file of new Set(protectedFiles)) {
    const area = areaFor(file);
    const rule = rules.find((candidate) => candidate.matches.ignores(file));
    const guidance = guidanceFor(file);
    const group = groups.find(
      (candidate) =>
        candidate.area === area && candidate.rule === rule && candidate.guidance === guidance,
    );
    if (group) group.files.push(file);
    else groups.push({ area, rule, guidance, files: [file] });
  }
  const rows = groups.map(({ area, rule, guidance, files }) => [
    inlineCode(area) +
      "<br />" +
      (rule
        ? link(inlineCode(rule.pattern), `${sourceUrl}#L${rule.line}`)
        : "No matching CODEOWNERS entry"),
    rule?.owners.length ? rule.owners.map(ownerLink).join(", ") : "No code owner assigned",
    files.slice(0, 5).map(inlineCode).join("<br />") +
      (files.length > 5 ? `<br />${files.length - 5} more files` : ""),
    guidance,
  ]);
  const visibleRows = [
    [
      "Protected area (CODEOWNERS rule)",
      "Listed code owners",
      "Protected files changed",
      "Guidance",
    ],
  ];
  let report = table(visibleRows);
  let omitted = 0;
  for (const [index, row] of rows.entries()) {
    const next = table([...visibleRows, row]);
    if (next.length > MAX_TABLE_LENGTH) {
      omitted = rows.length - index;
      core.warning(`Code-owner guidance omitted ${omitted} areas to fit GitHub's comment limit.`);
      break;
    }
    visibleRows.push(row);
    report = next;
  }
  return [
    "> [!WARNING]",
    changesSpecifications
      ? "> These repository-managed files are outside the scope of a specification contribution. " +
        "Remove unrelated changes from your specification PR. If a tooling change is needed, " +
        "open an issue for the repository maintainers or propose a separate maintenance PR."
      : "> This PR changes repository-managed tooling or configuration. " +
        "These changes need review from repository maintainers or the applicable tooling owners.",
    "",
    "For intentional repository maintenance, normal CODEOWNERS review and other merge requirements still apply. " +
      "GitHub enforces approval; a successful Protected Files check does not mean approval has been granted.",
    "",
    "Ownership below comes from the PR's base-branch " +
      link("CODEOWNERS", sourceUrl) +
      ". The last matching rule wins. Areas without an assigned owner still need normal PR review.",
    "",
    details("Protected files changed and their code owners", report),
    ...(omitted
      ? [
          "",
          `${omitted} additional areas are not shown due to GitHub's comment limit. ` +
            "Use the PR's Files changed tab and the linked CODEOWNERS for the complete ownership information.",
        ]
      : []),
  ].join("\n");
}

export async function getCodeOwnerReviewGuidance(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  prNumber: number,
  headSha: string,
): Promise<string | undefined> {
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: prNumber });
  if (pr.state !== "open" || pr.head.sha !== headSha) {
    core.info("Skipping code-owner guidance for a closed PR or an outdated head SHA.");
    return undefined;
  }
  const files = await github.paginate(github.rest.pulls.listFiles, {
    owner,
    repo,
    pull_number: prNumber,
    per_page: PER_PAGE_MAX,
  });
  if (files.length !== pr.changed_files) {
    throw new Error(
      "Cannot generate code-owner guidance: GitHub returned an incomplete changed-file list",
    );
  }
  const changedFiles = files.flatMap((file) =>
    file.previous_filename ? [file.previous_filename, file.filename] : [file.filename],
  );
  if (getProtectedFiles(changedFiles).length === 0) {
    core.info("No changes to protected files; leaving specification ownership to GitHub.");
    return undefined;
  }
  const { data } = await github.rest.repos.getContent({
    owner,
    repo,
    path: ".github/CODEOWNERS",
    ref: pr.base.sha,
  });
  if (Array.isArray(data) || data.type !== "file" || data.encoding !== "base64") {
    throw new Error("Code-owner guidance requires a base64-encoded CODEOWNERS file");
  }
  return createCodeOwnerReviewGuidance(
    Buffer.from(data.content, "base64").toString("utf8"),
    changedFiles,
    `https://github.com/${owner}/${repo}/blob/${pr.base.sha}/.github/CODEOWNERS`,
    core,
  );
}
