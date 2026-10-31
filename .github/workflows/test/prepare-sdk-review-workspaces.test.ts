import { execFileSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { afterEach, describe, expect, it } from "vitest";

const temporaryDirectories: string[] = [];
type ReviewContext = {
    canonicalSkill: { skillRevision: string; skillPath: string };
    workspaces: Array<{ baselineCommitSha: string; workspace: string }>;
};

function runGit(workingDirectory: string, args: string[]): string {
  return execFileSync("git", args, {
    cwd: workingDirectory,
    encoding: "utf8",
    stdio: ["ignore", "pipe", "pipe"],
  }).trim();
}

describe("prepare-sdk-review-workspaces", () => {
  afterEach(() => {
    for (const directory of temporaryDirectories.splice(0)) {
      fs.rmSync(directory, { recursive: true, force: true });
    }
  });

  it("reconstructs the declared SDK diff and records the canonical skill revision", () => {
    const testRoot = fs.mkdtempSync(path.join(os.tmpdir(), "prepare-sdk-review-test-"));
    temporaryDirectories.push(testRoot);
    const repository = path.join(testRoot, "azure-sdk-for-net");
    const packageRoot = path.join(repository, "sdk", "widget", "Azure.Widget");
    fs.mkdirSync(path.join(packageRoot, "src"), { recursive: true });
    runGit(testRoot, ["init", "--initial-branch=main", repository]);
    runGit(repository, ["config", "user.email", "test@example.com"]);
    runGit(repository, ["config", "user.name", "SDK Review Test"]);
    fs.writeFileSync(path.join(packageRoot, "src", "WidgetClient.cs"), "before\n");
    fs.writeFileSync(path.join(packageRoot, "src", "WidgetModel.cs"), "unchanged\n");
    runGit(repository, ["add", "."]);
    runGit(repository, ["commit", "-m", "SDK baseline"]);
    const baselineCommitSha = runGit(repository, ["rev-parse", "HEAD"]);

    const skillRoot = path.join(repository, ".github", "skills", "code-review");
    fs.mkdirSync(skillRoot, { recursive: true });
    fs.writeFileSync(path.join(skillRoot, "SKILL.md"), "# Canonical code review\n");
    runGit(repository, ["add", ".github"]);
    runGit(repository, ["commit", "-m", "Add canonical skill"]);
    const skillRevision = runGit(repository, ["rev-parse", "HEAD"]);

    const inputRoot = path.join(testRoot, "input");
    const snapshotRoot = path.join(inputRoot, "Azure.Widget", "review-input");
    fs.mkdirSync(path.join(snapshotRoot, "src"), { recursive: true });
    fs.writeFileSync(path.join(snapshotRoot, "src", "WidgetClient.cs"), "after\n");
    fs.writeFileSync(path.join(snapshotRoot, "src", "WidgetModel.cs"), "unchanged\n");
    fs.writeFileSync(path.join(snapshotRoot, "src", "WidgetOptions.cs"), "new\n");
    fs.writeFileSync(
      path.join(inputRoot, "spec-gen-sdk-artifact.json"),
      JSON.stringify({
        language: "azure-sdk-for-net",
        headSha: "38865cd3b650b3510e2a5b8bf9f990d0668a8810",
        prNumber: "47607",
        apiViewRequestData: [
          {
            packageName: "Azure.Widget",
            packageRootPath: "sdk/widget/Azure.Widget",
            changedFiles: [
              "sdk/widget/Azure.Widget/src/WidgetClient.cs",
              "sdk/widget/Azure.Widget/src/WidgetOptions.cs",
            ],
            sdkBaseCommitSha: baselineCommitSha,
            reviewInputPath: "Azure.Widget/review-input",
          },
        ],
      }),
    );

    const outputRoot = path.join(testRoot, "output");
    const installedSkillRoot = path.join(
        testRoot,
        "agent-workspace",
        ".github",
        "skills",
        "code-review",
    );
    const scriptPath = fileURLToPath(
      new URL("../scripts/prepare-sdk-review-workspaces.mjs", import.meta.url),
    );
    execFileSync(process.execPath, [scriptPath], {
      cwd: testRoot,
      env: {
        ...process.env,
        SDK_REVIEW_INPUT_ROOT: inputRoot,
        SDK_REVIEW_WORKSPACE_ROOT: outputRoot,
        SDK_REVIEW_REPOSITORY_URL: pathToFileURL(repository).href,
        SDK_REVIEW_SKILL_INSTALL_ROOT: installedSkillRoot,
      },
      stdio: "pipe",
    });

    const parsedContext: unknown = JSON.parse(
      fs.readFileSync(path.join(outputRoot, "sdk-review-context.json"), "utf8"),
    );
    const context = parsedContext as ReviewContext;
    expect(context.canonicalSkill.skillRevision).toBe(skillRevision);
    expect(context.canonicalSkill.skillPath).toBe(path.join(installedSkillRoot, "SKILL.md"));
    expect(
        fs
            .readFileSync(context.canonicalSkill.skillPath, "utf8")
            .replaceAll("\r\n", "\n"),
    ).toBe("# Canonical code review\n");
    expect(context.workspaces).toHaveLength(1);
    expect(context.workspaces[0].baselineCommitSha).toBe(baselineCommitSha);
    const workspace = context.workspaces[0].workspace;
    expect(
      runGit(workspace, [
        "diff",
        "--name-only",
        "HEAD",
        "--",
        "sdk/widget/Azure.Widget",
      ]).replaceAll("\r\n", "\n"),
    ).toBe("sdk/widget/Azure.Widget/src/WidgetClient.cs");
    expect(
      runGit(workspace, [
        "ls-files",
        "--others",
        "--exclude-standard",
        "--",
        "sdk/widget/Azure.Widget",
      ]),
    ).toBe("sdk/widget/Azure.Widget/src/WidgetOptions.cs");
  });
});
