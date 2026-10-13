import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { afterEach, describe, it } from "node:test";

import { getPassAtKVerdict, setJunitPassAtKThreshold } from "./typespec-author-pass-at-k.ts";

const roots: string[] = [];

function newResults(lines: object[]): string {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-pass-at-k-"));
  roots.push(root);
  const run = path.join(root, "2026-08-13T00-00-00-000Z");
  fs.mkdirSync(run);
  fs.writeFileSync(
    path.join(run, "results.jsonl"),
    lines.map((line) => JSON.stringify(line)).join("\n"),
  );
  return root;
}

afterEach(() => {
  for (const root of roots.splice(0)) {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

describe("TypeSpec pass@k", () => {
  it("passes when one of three trials passes", () => {
    const root = newResults([
      {
        type: "trial-result",
        evalFilePath: "001.eval.yaml",
        stimulus: "case",
        gradeResult: { passed: false },
      },
      {
        type: "trial-result",
        evalFilePath: "001.eval.yaml",
        stimulus: "case",
        gradeResult: { passed: true },
      },
      {
        type: "trial-result",
        evalFilePath: "001.eval.yaml",
        stimulus: "case",
        gradeResult: { passed: false },
      },
      { type: "run-summary", hadExecutionErrors: false },
    ]);

    assert.equal(getPassAtKVerdict(root).passed, true);
  });

  it("fails when none of ten trials passes", () => {
    const trials = Array.from({ length: 10 }, () => ({
      type: "trial-result",
      evalFilePath: "001.eval.yaml",
      stimulus: "case",
      gradeResult: { passed: false },
    }));
    const root = newResults([...trials, { type: "run-summary", hadExecutionErrors: false }]);

    assert.equal(getPassAtKVerdict(root).passed, false);
  });

  it("sets the JUnit threshold to one required pass for any run count", () => {
    const root = newResults([{ type: "run-summary" }]);
    const junit = path.join(root, "eval-results.junit.xml");
    fs.writeFileSync(
      junit,
      '<testsuite><properties><property name="runs" value="10"/><property name="threshold" value="0.97"/></properties></testsuite>',
    );

    assert.equal(setJunitPassAtKThreshold(root, 10), 1);
    assert.match(fs.readFileSync(junit, "utf8"), /name="threshold" value="0\.1"/);
  });
});
