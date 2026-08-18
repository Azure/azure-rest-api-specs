// @ts-check

/**
 * Extracts per-folder TypeSpec validation failures from the logs of a
 * "TypeSpec Validation - All" (TSV-All) run.
 *
 * TSV-All is not modified by this pipeline; its logs are simply read. TypeSpec-Validation.ps1
 * wraps each folder in a `##[group]Validating <folder>` ... `##[endgroup]` block, so failures can
 * be attributed back to the specific spec folder that produced them.
 *
 * Inputs (env):
 *   RUN_ID     - TSV-All run being harvested
 *   REF_KEY    - matrix ref key ("default" or "next")
 *   TARGET_REF - actual branch name the PR should target
 *
 * Outputs: harvest/failures.json and harvest/failures.md
 */

import { readdirSync, readFileSync, mkdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const LOG_DIR = "logs";
const OUT_DIR = "harvest";

const runId = process.env.RUN_ID ?? "";
const refKey = process.env.REF_KEY ?? "";
const targetRef = process.env.TARGET_REF ?? "";
const repo = process.env.GITHUB_REPOSITORY ?? "";
const serverUrl = process.env.GITHUB_SERVER_URL ?? "https://github.com";

/** Strip the GitHub Actions ISO-8601 timestamp prefix from a raw log line. */
function stripTimestamp(line) {
  return line.replace(/^\S+Z\s?/, "");
}

/**
 * Classify a failure into a suppression category.
 *
 * Only categories with a well-understood, mechanical cause are marked eligible. Anything else --
 * notably real `tsp compile` errors -- is deliberately left for a human.
 */
function classify(body) {
  const text = body.join("\n");

  if (/FolderStructure/i.test(text) && /MustUseV2/i.test(text)) {
    return { rule: "FolderStructure", subRule: "MustUseV2", eligible: true };
  }
  if (/ExtraSwagger/i.test(text)) {
    return { rule: "Compile", subRule: "ExtraSwagger", eligible: true };
  }
  if (/SdkTspConfigValidation/i.test(text)) {
    return { rule: "SdkTspConfigValidation", subRule: null, eligible: true };
  }
  // Infrastructure problems must be rerun, never suppressed.
  if (/(ETIMEDOUT|ECONNRESET|ENOTFOUND|socket hang up|npm ERR!|The runner has received a shutdown signal)/i.test(text)) {
    return { rule: "Infrastructure", subRule: null, eligible: false, infrastructure: true };
  }
  return { rule: "Unclassified", subRule: null, eligible: false };
}

/** Parse one job log into its per-folder validation results. */
function parseLog(content) {
  const results = [];
  let current = null;

  for (const raw of content.split(/\r?\n/)) {
    const line = stripTimestamp(raw);

    const start = line.match(/^##\[group\]Validating (\S+)/);
    if (start) {
      current = { folder: start[1], body: [] };
      continue;
    }

    if (/^##\[endgroup\]/.test(line)) {
      if (current) {
        results.push(current);
        current = null;
      }
      continue;
    }

    if (current) {
      current.body.push(line);
    }
  }

  return results;
}

const logFiles = (() => {
  try {
    return readdirSync(LOG_DIR).filter((f) => f.endsWith(".log"));
  } catch {
    return [];
  }
})();

if (logFiles.length === 0) {
  console.log(`::error::No TSV-All job logs found in ${LOG_DIR}/`);
  process.exit(1);
}

const failures = [];
let foldersSeen = 0;
let suppressedAlready = 0;

for (const file of logFiles) {
  const content = readFileSync(join(LOG_DIR, file), "utf8");

  for (const { folder, body } of parseLog(content)) {
    foldersSeen++;

    // Already covered by an existing suppression; nothing to do.
    if (body.some((l) => l.includes("Suppressed:"))) {
      suppressedAlready++;
      continue;
    }

    const failed = body.some(
      (l) =>
        l.includes("TypeSpec Validation failed for project") ||
        /^##\[error\]/.test(l),
    );
    if (!failed) continue;

    // Keep the log excerpt bounded so the agent prompt stays a reasonable size.
    const excerpt = body
      .filter((l) => l.trim().length > 0)
      .slice(-40)
      .join("\n");

    failures.push({ folder, ...classify(body), excerpt, sourceLog: file });
  }
}

const eligible = failures.filter((f) => f.eligible);
const ineligible = failures.filter((f) => !f.eligible);

const summary = {
  runId,
  refKey,
  targetRef,
  runUrl: `${serverUrl}/${repo}/actions/runs/${runId}`,
  jobLogsParsed: logFiles.length,
  foldersSeen,
  suppressedAlready,
  totalFailures: failures.length,
  eligibleCount: eligible.length,
  failures,
};

mkdirSync(OUT_DIR, { recursive: true });
writeFileSync(join(OUT_DIR, "failures.json"), JSON.stringify(summary, null, 2));

const md = [
  `# TypeSpec validation failures on \`${targetRef}\``,
  "",
  `Harvested from [TSV-All run ${runId}](${summary.runUrl}) — no specs were recompiled.`,
  "",
  `- Job logs parsed: ${logFiles.length}`,
  `- Spec folders seen: ${foldersSeen}`,
  `- Already suppressed: ${suppressedAlready}`,
  `- Failures: ${failures.length} (${eligible.length} eligible for auto-suppression)`,
  "",
  "## Eligible for auto-suppression",
  "",
  eligible.length
    ? eligible
        .map(
          (f) =>
            `### \`${f.folder}\`\n\n- Rule: \`${f.rule}\`${f.subRule ? ` / \`${f.subRule}\`` : ""}\n\n\`\`\`\n${f.excerpt}\n\`\`\``,
        )
        .join("\n\n")
    : "_None._",
  "",
  "## Not eligible — needs human attention",
  "",
  ineligible.length
    ? ineligible
        .map(
          (f) =>
            `### \`${f.folder}\`\n\n- Reason: ${f.infrastructure ? "infrastructure failure, needs a rerun" : "unclassified failure"}\n\n\`\`\`\n${f.excerpt}\n\`\`\``,
        )
        .join("\n\n")
    : "_None._",
  "",
].join("\n");

writeFileSync(join(OUT_DIR, "failures.md"), md);

console.log(
  `Parsed ${logFiles.length} job log(s): ${foldersSeen} folders, ${failures.length} failures, ${eligible.length} eligible.`,
);
