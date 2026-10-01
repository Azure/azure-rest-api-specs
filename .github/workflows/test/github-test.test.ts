import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { simpleGit } from "simple-git";
import { describe, expect, it } from "vitest";
import { isMap, isSeq, parseDocument } from "yaml";

function getAuditSteps() {
  const workflow = parseDocument(
    readFileSync(new URL("../github-test.yaml", import.meta.url), "utf8"),
  );
  expect(workflow.errors).toEqual([]);
  const steps = workflow.getIn(["jobs", "test", "steps"]);
  if (!isSeq(steps)) throw new Error("Expected test job steps");
  const selection = steps.items.find((step) => isMap(step) && step.get("id") === "zizmor-inputs");
  const audit = steps.items.find(
    (step) => isMap(step) && String(step.get("uses")).startsWith("zizmorcore/zizmor-action@"),
  );
  if (!isMap(selection) || !isMap(audit)) throw new Error("Expected security audit steps");
  return { selection, audit };
}

describe("GitHub Actions security audits", () => {
  it("uses the selected inputs only on the Linux test job and reports failures", () => {
    const { selection, audit } = getAuditSteps();
    expect(selection.get("if")).toBe("${{ matrix.os == 'ubuntu' }}");
    expect(audit.get("if")).toBe(selection.get("if"));
    expect(audit.getIn(["with", "inputs"])).toBe("${{ steps.zizmor-inputs.outputs.paths }}");
    expect(audit.getIn(["with", "advanced-security"])).toBe(false);
    expect(audit.getIn(["with", "annotations"])).toBe(true);
    expect(audit.has("continue-on-error")).toBe(false);
  });

  it.skipIf(process.platform === "win32")(
    "includes both YAML extensions and composite actions but excludes generated lockfiles",
    async () => {
      const { selection } = getAuditSteps();
      const script = selection.get("run");
      if (typeof script !== "string") throw new Error("Expected an input-selection script");
      const directory = await mkdtemp(join(tmpdir(), "zizmor-inputs-"));
      const included = [
        ".github/workflows/build.yaml",
        ".github/workflows/build.yml",
        ".github/actions/first/action.yaml",
        ".github/actions/second/action.yml",
      ];
      const excluded = [
        ".github/workflows/generated.lock.yml",
        ".github/workflows/generated.md",
        ".github/actions/first/config.yaml",
        ".github/zizmor.yaml",
        "other.yaml",
      ];
      try {
        for (const path of [...included, ...excluded]) {
          await mkdir(dirname(join(directory, path)), { recursive: true });
          await writeFile(join(directory, path), "name: example\n");
        }
        await simpleGit(directory).init().add(".");
        const output = join(directory, "output");
        execFileSync("bash", ["-e", "-o", "pipefail", "-c", script], {
          cwd: directory,
          env: { ...process.env, GITHUB_OUTPUT: output },
        });
        const paths = readFileSync(output, "utf8")
          .trim()
          .replace(/^paths=/, "")
          .split(" ");
        expect(paths.sort()).toEqual(included.sort());
      } finally {
        await rm(directory, { recursive: true, force: true });
      }
    },
  );

  it("keeps credentials for sparse ARM analysis that lazily fetches private blobs", () => {
    const workflow = parseDocument(
      readFileSync(new URL("../arm-auto-signoff-code.yaml", import.meta.url), "utf8"),
    );
    expect(
      workflow.getIn(["jobs", "arm-auto-signoff-code", "steps", 0, "with", "persist-credentials"]),
    ).toBe(true);
  });

  it("limits the masked ADO token to the SDK status step", () => {
    const workflow = parseDocument(
      readFileSync(new URL("../spec-gen-sdk-status.yaml", import.meta.url), "utf8"),
    );
    const steps = workflow.getIn(["jobs", "sdk-validation-status", "steps"]);
    if (!isSeq(steps)) throw new Error("Expected SDK status steps");
    const token = steps.items.find((step) => isMap(step) && step.get("id") === "ado-token");
    const status = steps.items.find(
      (step) => isMap(step) && step.get("id") === "sdk-validation-status",
    );
    if (!isMap(token) || !isMap(status)) throw new Error("Expected token and status steps");
    expect(token.get("run")).toContain('echo "::add-mask::$ADO_TOKEN"');
    expect(token.get("run")).toContain('echo "token=$ADO_TOKEN" >> "$GITHUB_OUTPUT"');
    expect(token.get("run")).not.toContain("$GITHUB_ENV");
    expect(status.getIn(["env", "ADO_TOKEN"])).toBe("${{ steps.ado-token.outputs.token }}");
    for (const step of steps.items) {
      if (isMap(step) && step !== status) expect(step.hasIn(["env", "ADO_TOKEN"])).toBe(false);
    }
  });
});
