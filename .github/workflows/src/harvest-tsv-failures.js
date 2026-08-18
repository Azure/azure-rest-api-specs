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

/**
 * Strip ANSI color escape sequences.
 *
 * The TypeSpec compiler colorizes diagnostics, so a line like `<file>:<line>:<col> - error <rule>`
 * arrives with escape codes interleaved between every field. Without stripping them first, the
 * diagnostic pattern never matches real log output.
 */
// eslint-disable-next-line no-control-regex
const ANSI_PATTERN = /\u001b\[[0-9;]*m/g;

function stripAnsi(line) {
  return line.replace(ANSI_PATTERN, "");
}

/** Strip the GitHub Actions ISO-8601 timestamp prefix from a raw log line. */
function stripTimestamp(line) {
  return line.replace(/^\S+Z\s?/, "");
}

/**
 * Decide whether a diagnostic can be suppressed inline with a `#suppress` directive.
 *
 * TSV compiles with `--warn-as-error`, so linter warnings are printed with severity `error` and the
 * severity field carries no information -- everything is an error. What actually distinguishes a
 * linter rule from a genuine compile failure is the presence of a namespaced rule id:
 *
 *   ...tsp:76:3 - error @azure-tools/typespec-azure-core/no-openapi-client-extensions: ...
 *   ...tsp:9:1  - error Cannot find name 'Widget'.          <- no rule id, a real compile error
 *
 * A diagnostic is inline-suppressible when it carries a rule id from a TypeSpec linter package,
 * because `#suppress` takes that rule id as its argument. A diagnostic with no rule id cannot be
 * suppressed inline even in principle, and is left for a human.
 */
function isInlineSuppressible(rule) {
  return rule !== null && /^(@azure-tools|@typespec)\//.test(rule);
}

/**
 * Extract individual TypeSpec diagnostics from a folder's log output.
 *
 * The compiler emits `<file>:<line>:<col> - <severity> [<rule-id>: ]<message>`, which is what makes
 * an inline suppression possible: it pins the exact declaration that needs the `#suppress`.
 *
 * The rule id is optional -- a genuine compile error has none -- so it is captured separately and
 * left null in that case rather than skipping the diagnostic. Those still need to be seen, because
 * a folder containing one is not eligible for auto-suppression at all.
 *
 * Diagnostics are deduplicated and returned sorted by descending line number within each file. That
 * ordering matters: inserting a `#suppress` directive adds a line, shifting every later line in the
 * file down by one. Applying edits bottom-up keeps every not-yet-applied line number valid.
 */
function extractDiagnostics(body) {
  const seen = new Set();
  const diagnostics = [];

  for (const line of body) {
    const m = line.match(
      /^\s*(\S+?\.tsp):(\d+):(\d+)\s+-\s+(error|warning)\s+(?:([@\w][\w./-]*\/[\w./-]+)\s*:\s*)?(.*)$/,
    );
    if (!m) continue;

    const [, rawFile, lineNo, col, severity, rawRule, message] = m;
    const rule = rawRule ?? null;

    // Logs carry absolute runner paths; the agent works in a normal checkout.
    const file = rawFile.replace(/^.*?(?=specification\/)/, "");

    // The same diagnostic can be emitted more than once (e.g. by multiple emitters). Collapsing
    // duplicates keeps the suppression count honest and avoids inserting the same directive twice.
    const key = `${file}:${lineNo}:${col}:${rule}`;
    if (seen.has(key)) continue;
    seen.add(key);

    diagnostics.push({
      file,
      line: Number(lineNo),
      column: Number(col),
      severity,
      rule,
      message: message.trim(),
      inlineSuppressible: isInlineSuppressible(rule),
    });
  }

  // Group by file, then order by descending line so edits can be applied bottom-up.
  diagnostics.sort((a, b) => (a.file === b.file ? b.line - a.line : a.file.localeCompare(b.file)));

  return diagnostics;
}

/**
 * Classify a failure into a suppression category.
 *
 * Only categories with a well-understood, mechanical cause are marked eligible. Anything else --
 * notably real `tsp compile` errors -- is deliberately left for a human.
 */
function classify(body, diagnostics) {
  const text = body.join("\n");

  // Infrastructure problems must be rerun, never suppressed. Checked first so a flaky run is
  // never mistaken for a suppressible diagnostic.
  if (
    /(ETIMEDOUT|ECONNRESET|ENOTFOUND|socket hang up|npm ERR!|The runner has received a shutdown signal)/i.test(
      text,
    )
  ) {
    return { rule: "Infrastructure", subRule: null, eligible: false, infrastructure: true };
  }

  // Inline-suppressible diagnostics: every diagnostic must be individually suppressible, otherwise
  // suppressing only some of them would leave the folder failing anyway.
  if (diagnostics.length > 0 && diagnostics.every((d) => d.inlineSuppressible)) {
    const rules = [...new Set(diagnostics.map((d) => d.rule))];
    return {
      rule: "InlineSuppressible",
      subRule: rules.join(", "),
      eligible: true,
      suppressionStyle: "inline",
    };
  }

  if (/FolderStructure/i.test(text) && /MustUseV2/i.test(text)) {
    return {
      rule: "FolderStructure",
      subRule: "MustUseV2",
      eligible: true,
      suppressionStyle: "file",
    };
  }
  if (/ExtraSwagger/i.test(text)) {
    return { rule: "Compile", subRule: "ExtraSwagger", eligible: true, suppressionStyle: "file" };
  }
  if (/SdkTspConfigValidation/i.test(text)) {
    return {
      rule: "SdkTspConfigValidation",
      subRule: null,
      eligible: true,
      suppressionStyle: "file",
    };
  }
  return { rule: "Unclassified", subRule: null, eligible: false };
}

/** Parse one job log into its per-folder validation results. */
function parseLog(content) {
  const results = [];
  let current = null;

  for (const raw of content.split(/\r?\n/)) {
    const line = stripAnsi(stripTimestamp(raw));

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
  // GitHub serves job logs as UTF-8 with a BOM; strip it so the first line parses normally.
  const content = readFileSync(join(LOG_DIR, file), "utf8").replace(/^\uFEFF/, "");

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

    const diagnostics = extractDiagnostics(body);

    failures.push({
      folder,
      ...classify(body, diagnostics),
      diagnostics,
      excerpt,
      sourceLog: file,
    });
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
        .map((f) => {
          const locations = f.diagnostics?.length
            ? `\n- Suppress at (descending line order — apply bottom-up so earlier edits do not shift later line numbers):\n${f.diagnostics
                .map((d) => `  - \`${d.file}:${d.line}\` — \`${d.rule}\``)
                .join("\n")}`
            : "";
          return `### \`${f.folder}\`\n\n- Rule: \`${f.rule}\`${f.subRule ? ` / \`${f.subRule}\`` : ""}\n- Style: **${f.suppressionStyle === "inline" ? "inline `#suppress` in the .tsp source" : "entry in specification/suppressions.yaml"}**${locations}\n\n\`\`\`\n${f.excerpt}\n\`\`\``;
        })
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
