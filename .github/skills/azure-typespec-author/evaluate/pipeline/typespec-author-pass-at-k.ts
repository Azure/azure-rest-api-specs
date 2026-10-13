import fs from "node:fs";
import path from "node:path";

type TrialResult = {
  type?: string;
  evalFilePath?: string;
  stimulus?: string;
  gradeResult?: { passed?: boolean };
};

type RunSummary = {
  type?: string;
  hadExecutionErrors?: boolean;
};

type PassAtKVerdict = {
  found: boolean;
  passed: boolean;
  hadExecutionErrors: boolean;
  lines: string[];
};

function findNewestFile(root: string, fileName: string): string | undefined {
  let newestFile: string | undefined;
  let newestMtime = -Infinity;

  // Vally creates one timestamped output directory per invocation. Ignore stale
  // local or retry output and evaluate only the most recently written run.
  const visit = (directory: string) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const fullPath = path.join(directory, entry.name);
      if (entry.isDirectory()) {
        visit(fullPath);
      } else if (entry.name === fileName) {
        const mtime = fs.statSync(fullPath).mtimeMs;
        if (mtime >= newestMtime) {
          newestMtime = mtime;
          newestFile = fullPath;
        }
      }
    }
  };

  if (fs.existsSync(root)) {
    visit(root);
  }
  return newestFile;
}

export function getPassAtKVerdict(resultsDir: string): PassAtKVerdict {
  const result: PassAtKVerdict = {
    found: false,
    passed: false,
    hadExecutionErrors: false,
    lines: [],
  };
  const resultsFile = findNewestFile(resultsDir, "results.jsonl");
  if (!resultsFile) {
    result.lines.push(`No results.jsonl found under '${resultsDir}'.`);
    return result;
  }

  // Keep stimuli from different eval files independent even when they share a
  // display name. pass@k succeeds when any trial for a stimulus succeeds.
  const trials = new Map<string, { passed: number; total: number }>();
  let runSummary: RunSummary | undefined;
  for (const line of fs.readFileSync(resultsFile, "utf8").split(/\r?\n/)) {
    if (!line.trim()) {
      continue;
    }

    let record: TrialResult | RunSummary;
    try {
      record = JSON.parse(line);
    } catch {
      continue;
    }

    if (record.type === "run-summary") {
      runSummary = record;
    } else if (record.type === "trial-result") {
      const trial = record as TrialResult;
      const key = `${trial.evalFilePath ?? "(unknown eval)"}::${trial.stimulus ?? "(unknown stimulus)"}`;
      const aggregate = trials.get(key) ?? { passed: 0, total: 0 };
      aggregate.total++;
      if (trial.gradeResult?.passed === true) {
        aggregate.passed++;
      }
      trials.set(key, aggregate);
    }
  }

  if (!runSummary || trials.size === 0) {
    result.lines.push(`No complete trial results found in '${path.resolve(resultsFile)}'.`);
    return result;
  }

  result.found = true;
  result.hadExecutionErrors = Boolean(runSummary.hadExecutionErrors);
  result.passed = true;
  for (const [key, aggregate] of trials) {
    const stimulus = key.slice(key.lastIndexOf("::") + 2);
    if (aggregate.passed > 0) {
      result.lines.push(
        `PASS  ${stimulus} - pass@${aggregate.total} (${aggregate.passed}/${aggregate.total} trials passed)`,
      );
    } else {
      result.lines.push(
        `FAIL  ${stimulus} - pass@${aggregate.total} (0/${aggregate.total} trials passed)`,
      );
      result.passed = false;
    }
  }

  return result;
}

export function setJunitPassAtKThreshold(resultsDir: string, runs: number): number {
  // The common JUnit summary compares passed/total against threshold. Requiring
  // 1 of k trials is therefore equivalent to a threshold of 1/k for any run count.
  const threshold = 1 / runs;
  let updated = 0;

  const visit = (directory: string) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const fullPath = path.join(directory, entry.name);
      if (entry.isDirectory()) {
        visit(fullPath);
      } else if (entry.name.endsWith(".junit.xml")) {
        const original = fs.readFileSync(fullPath, "utf8");
        const rewritten = original.replace(
          /(<property\s+name=["']threshold["']\s+value=["'])[^"']*(["']\s*\/?>)/g,
          `$1${threshold}$2`,
        );
        if (rewritten !== original) {
          fs.writeFileSync(fullPath, rewritten, "utf8");
          updated++;
        }
      }
    }
  };

  if (fs.existsSync(resultsDir)) {
    visit(resultsDir);
  }
  return updated;
}
