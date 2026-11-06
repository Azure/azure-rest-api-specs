import { readFile } from "node:fs/promises";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { checkProtectedFiles, runProtectedFiles } from "../src/protected-files.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

vi.mock("node:fs/promises", () => ({ readFile: vi.fn() }));

const LABEL = "protectedfiles-approved";
const RULESET = "eng/typespec-rulesets/index.ts";

function setup(author = "spec-author", paths = [RULESET]) {
  const context = createMockContext();
  context.eventName = "pull_request_target";
  context.repo = { owner: "Azure", repo: "azure-rest-api-specs" };
  context.payload = {
    action: "synchronize",
    pull_request: { number: 1, head: { sha: "head" } },
  };
  const pr = {
    state: "open",
    user: { login: author },
    head: { sha: "head" },
    base: { ref: "main", sha: "base" },
    changed_files: paths.length,
    labels: [] as { name: string }[],
  };
  const github = createMockGithub();
  github.rest.pulls.get.mockImplementation(() => Promise.resolve({ data: structuredClone(pr) }));
  github.rest.pulls.listFiles.mockResolvedValue({
    data: paths.map((filename) => ({ filename })),
  });
  const core = createMockCore();
  const approve = (actor = "timotheeguerin") => {
    pr.labels = [{ name: LABEL }];
    github.rest.issues.listEvents.mockResolvedValue({
      data: [{ id: 1, event: "labeled", label: { name: LABEL }, actor: { login: actor } }],
    });
  };
  return {
    context,
    github,
    core,
    pr,
    approve,
    run: () => runProtectedFiles({ github, context, core }),
  };
}

describe("Protected Files", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(readFile).mockResolvedValue(
      "global-approvers:\n  - GlobalReviewer\nprotectedfiles-approved:\n  - timotheeguerin\n",
    );
  });

  it.each([
    "azure-sdk",
    "azure-sdk-automation[bot]",
    "dependabot[bot]",
    "Azure-SDK",
    "timotheeguerin",
    "marygao",
  ])("preserves the author exemption for %s without reading files or policy", async (author) => {
    const { run, github, core } = setup(author);
    await run();
    expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
    expect(readFile).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ sha: "head", context: "Protected Files", state: "success" }),
    );
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it.each([
    ".gitignore",
    "cspell.json",
    "cspell.yaml",
    "package.json",
    "pnpm-lock.yaml",
    "pnpm-workspace.yaml",
    "README.md",
    "documentation/ci-fix.md",
    ".github/workflows/protected-files.yaml",
    ".github/azsdk-common-config.yml",
    ".vscode/settings.json",
    "eng/tools/example/package.json",
    "eng/scripts/ChangedFiles-Functions.ps1",
    ".github/CODEOWNERS.backup",
    ".github/CODEOWNERS\n",
    ".github/workflows/nested/.github/CODEOWNERS",
    "eng/nested/.github/skills/custom/SKILL.md",
    ".github/skills/azsdk-common-example/SKILL.md",
    ".github/skills/azsdk-common-example",
    "PACKAGE.JSON",
    ".GITHUB/WORKFLOWS/test.yaml",
    ".github/workflows/with spaces.yaml",
    ".github/.hidden/config.yaml",
    ".github/workflows/.hidden.yaml",
    ".vscode/.hidden",
    "eng/.hidden/nested/config.json",
    ".github/skills",
    RULESET,
  ])("blocks protected path %s for a non-allowlisted author", async (file) => {
    const { run, github, core, context } = setup("external-contributor", [file]);
    context.actor = "timotheeguerin";
    await run();
    expect(core.error).toHaveBeenCalledWith(expect.any(String), { file });
    expect(core.setFailed).toHaveBeenCalledOnce();
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it.each(
    [
      [],
      ["specification/widgets/main.tsp"],
      [".github/CODEOWNERS"],
      [".github/skills/custom/SKILL.md"],
      [".github/skills/custom/nested/file.ts"],
      [".github/skills/custom"],
      [".github/skills/.custom/.hidden"],
      [".github/skills/custom/.hidden/config.json"],
      [".github/skills/custom/azsdk-common-example/SKILL.md"],
      [".github/skills/azsdk-custom/SKILL.md"],
      [".GITHUB/codeowners", ".GITHUB/SKILLS/CUSTOM/skill.md"],
      ["specification/widgets/package.json"],
    ].map((files) => ({ files })),
  )("passes unprotected changes $files", async ({ files }) => {
    const { run, core } = setup("spec-author", files);
    await run();
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith("No changes to protected files.");
  });

  it.each(["timotheeguerin", "TimotheeGuerin", "globalreviewer"])(
    "accepts the latest label application by authorized reviewer %s",
    async (actor) => {
      const { run, approve, github, core } = setup("spec-author", [
        RULESET,
        "specification/widgets/main.tsp",
      ]);
      approve(actor);
      await run();
      expect(core.setFailed).not.toHaveBeenCalled();
      expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
        expect.objectContaining({
          state: "success",
          description: "TypeSpec ruleset change approved",
        }),
      );
      expect(github.rest.issues.listEvents).toHaveBeenCalledOnce();
      expect(github.rest.pulls.listFiles).toHaveBeenCalledOnce();
      expect(github.rest.pulls.get).toHaveBeenCalledTimes(2);
    },
  );

  it.each(["spec-author", "github-actions[bot]", "azure-sdk"])(
    "does not trust a transient label applied by %s",
    async (actor) => {
      const { run, approve, core } = setup();
      approve(actor);
      await run();
      expect(core.setFailed).toHaveBeenCalledOnce();
    },
  );

  it("does not reuse an older authorized application after removal and unauthorized reapplication", async () => {
    const { run, approve, github, core } = setup();
    approve();
    github.rest.issues.listEvents.mockResolvedValue({
      data: [
        { id: 1, event: "labeled", label: { name: LABEL }, actor: { login: "timotheeguerin" } },
        { id: 2, event: "unlabeled", label: { name: LABEL } },
        { id: 3, event: "labeled", label: { name: LABEL }, actor: { login: "spec-author" } },
      ],
    });
    await run();
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it.each(
    [
      [],
      [{ id: 2, event: "unlabeled", label: { name: LABEL } }],
      [{ id: 3, event: "labeled", label: { name: LABEL }, actor: null }],
      [
        {
          id: 4,
          event: "labeled",
          label: { name: "unrelated" },
          actor: { login: "timotheeguerin" },
        },
      ],
    ].map((events) => ({ events })),
  )("fails closed without an authorized current application: $events", async ({ events }) => {
    const { run, approve, github, core } = setup();
    approve();
    github.rest.issues.listEvents.mockResolvedValue({ data: events });
    await run();
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it.each([
    ".github/workflows/protected-files.yaml",
    "eng/typespec-rulesets/package.json",
    "eng/common/script.ps1",
    ".github/skills/azsdk-common-example/SKILL.md",
    "eng/typespec-rulesets/INDEX.ts",
  ])("does not approve an additional protected path %s", async (file) => {
    const { run, approve, core } = setup("spec-author", [RULESET, file]);
    approve();
    await run();
    expect(core.error).toHaveBeenCalledWith(expect.any(String), { file });
    expect(core.error).not.toHaveBeenCalledWith(expect.any(String), { file: RULESET });
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it.each([
    { filename: "specification/widgets/test.ts", previous_filename: RULESET },
    { filename: RULESET, previous_filename: ".github/workflows/test.yaml" },
    { filename: RULESET, previous_filename: "eng/typespec-rulesets/old.ts" },
  ])("checks both sides of a protected rename: %j", async (file) => {
    const { run, approve, github, core } = setup();
    approve();
    github.rest.pulls.listFiles.mockResolvedValue({ data: [file] });
    await run();
    // Moving the ruleset into specification is allowed by this exact-path approval;
    // moving a different protected path into the ruleset does not approve the source.
    expect(core.setFailed).toHaveBeenCalledTimes(file.previous_filename === RULESET ? 0 : 1);
  });

  it("treats a deleted protected file as a change", async () => {
    const { run, github, core } = setup();
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [{ filename: "package.json", status: "removed" }],
    });
    await run();
    expect(core.error).toHaveBeenCalledWith(expect.any(String), { file: "package.json" });
  });

  it.each(["release", "RPSaaSMaster"])("does not accept approval on base %s", async (base) => {
    const { run, approve, pr, github, core } = setup();
    approve();
    pr.base.ref = base;
    await run();
    expect(core.setFailed).toHaveBeenCalledOnce();
    expect(github.rest.issues.listEvents).not.toHaveBeenCalled();
  });

  it("does not enable approval in another repository", async () => {
    const { run, approve, context, core } = setup();
    approve();
    context.repo.repo = "azure-rest-api-specs-pr";
    await run();
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it.each(["labeled", "unlabeled"])(
    "re-evaluates relevant %s events from current state",
    async (action) => {
      const { run, approve, context, pr, core } = setup();
      approve();
      context.payload.action = action;
      context.payload.label = { name: LABEL };
      if (action === "unlabeled") pr.labels = [];
      await run();
      expect(core.setFailed).toHaveBeenCalledTimes(action === "unlabeled" ? 1 : 0);
    },
  );

  it("ignores unrelated label events before making API calls", async () => {
    const { run, context, github } = setup();
    context.payload.action = "labeled";
    context.payload.label = { name: "unrelated" };
    await run();
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("keeps the scoped approval for a new commit's own event", async () => {
    const { run, approve, pr, github, context } = setup();
    approve();
    pr.head.sha = "new-head";
    context.payload.pull_request = { number: 1, head: { sha: "new-head" } };
    await run();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledTimes(2);
    expect(github.rest.repos.createCommitStatus).toHaveBeenNthCalledWith(
      1,
      expect.objectContaining({ sha: "new-head", state: "pending" }),
    );
    expect(github.rest.repos.createCommitStatus).toHaveBeenNthCalledWith(
      2,
      expect.objectContaining({ sha: "new-head", state: "success" }),
    );
  });

  it("never applies an old event or rerun to a newer PR head", async () => {
    const { run, approve, pr, github } = setup();
    approve();
    pr.head.sha = "new-head";
    await expect(run()).rejects.toThrow("PR head changed since this event");
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalledWith(
      expect.objectContaining({ sha: "new-head" }),
    );
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ sha: "head", state: "failure" }),
    );
  });

  it.each(["head", "base", "target", "label", "closed"])(
    "fails closed when %s changes during evaluation",
    async (change) => {
      const { run, approve, pr, github } = setup();
      approve();
      const current = structuredClone(pr);
      if (change === "head") current.head.sha = "new-head";
      if (change === "base") current.base.sha = "new-base";
      if (change === "target") current.base.ref = "release";
      if (change === "label") current.labels = [];
      if (change === "closed") current.state = "closed";
      github.rest.pulls.get
        .mockResolvedValueOnce({ data: structuredClone(pr) })
        .mockResolvedValueOnce({ data: current });
      await expect(run()).rejects.toThrow("PR changed during evaluation");
      expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
        expect.objectContaining({ sha: "head", state: "failure" }),
      );
    },
  );

  it("rejects a truncated file list instead of passing", async () => {
    const { run, pr, github } = setup("spec-author", []);
    pr.changed_files = 3001;
    await expect(run()).rejects.toThrow("Incomplete PR file list");
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it.each([
    "global-approvers: []",
    "global-approvers: []\nprotectedfiles-approved:\n  team: maintainers",
  ])("rejects absent or unsupported approval policy: %s", async (policy) => {
    const { run, approve } = setup();
    approve();
    vi.mocked(readFile).mockResolvedValue(policy);
    await expect(run()).rejects.toThrow("requires explicit global and label approver lists");
  });

  it("propagates API errors and marks the head status failed", async () => {
    const { run, approve, github } = setup();
    approve();
    github.rest.issues.listEvents.mockRejectedValueOnce(new Error("API unavailable"));
    await expect(run()).rejects.toThrow("API unavailable");
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it("rejects untrusted workflow event types before making API calls", async () => {
    const { run, context, github } = setup();
    context.eventName = "pull_request";
    await expect(run()).rejects.toThrow("Unsupported event");
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("rejects a missing PR identity", async () => {
    const { run, context } = setup();
    context.payload = {};
    await expect(run()).rejects.toThrow("requires a pull request number and head SHA");
  });

  it("retains synced-file guidance", () => {
    const core = createMockCore();
    checkProtectedFiles({ author: "spec-author", changedFiles: ["eng/common/script.ps1"], core });
    expect(core.error).toHaveBeenCalledWith(
      expect.stringContaining("make the change in Azure/azure-sdk-tools instead"),
      { file: "eng/common/script.ps1" },
    );
  });
});
