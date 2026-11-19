import { describe, expect, it } from "vitest";
import {
  latestNativeCheck,
  nativeLabelAction,
  reconcileNativeSdkChecks,
  type NativeSdkDefinition,
  type NativeSdkLanguage,
} from "../src/native-sdk-checks.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const sha = "a".repeat(40);
const projectId = "11111111-2222-3333-4444-555555555555";
const definition: NativeSdkDefinition = {
  name: "SDK Validation - JS - PR",
  definitionId: 123,
  projectId,
};
type Check = NonNullable<ReturnType<typeof latestNativeCheck>>;
function check(overrides: Partial<Check> = {}): Check {
  return {
    id: 1,
    head_sha: sha,
    name: definition.name,
    external_id: `123|100|${projectId}`,
    app: { id: 9426, slug: "azure-pipelines" },
    status: "completed",
    conclusion: "success",
    ...overrides,
  };
}
const config: NativeSdkLanguage[] = [
  {
    language: "azure-sdk-for-js",
    required: true,
    validation: definition,
    breakingChange: {
      label: "BreakingChange-JavaScript-Sdk",
      present: { ...definition, name: "SDK Breaking Present - JS - PR", definitionId: 124 },
      absent: { ...definition, name: "SDK Breaking Absent - JS - PR", definitionId: 125 },
    },
  },
];

function setup() {
  const github = createMockGithub();
  const core = createMockCore();
  const context = createMockContext();
  context.repo = { owner: "Azure", repo: "azure-rest-api-specs-pr" };
  context.eventName = "pull_request_target";
  context.payload = { pull_request: { number: 42, head: { sha } } };
  github.rest.pulls.get.mockResolvedValue({
    data: {
      state: "open",
      head: { sha },
      base: { ref: "main" },
      labels: [{ name: "BreakingChange-JavaScript-Sdk" }],
    },
  });
  return { github, core, context };
}

describe("native SDK evidence", () => {
  it("authenticates exact app, definition, project, name and current head", () => {
    expect(latestNativeCheck([check()], definition, sha)).toEqual(check());
    for (const invalid of [
      check({ app: { id: 1, slug: "azure-pipelines" } }),
      check({ external_id: `999|100|${projectId}` }),
      check({ external_id: "123|100|wrong-project" }),
      check({ name: "SDK Validation - JS" }),
      check({ head_sha: "b".repeat(40) }),
    ]) {
      expect(latestNativeCheck([invalid], definition, sha)).toBeUndefined();
    }
  });

  it("never falls back to an older success on reruns, including delayed older-build checks", () => {
    const pending = check({
      id: 2,
      external_id: `123|101|${projectId}`,
      status: "queued",
      conclusion: null,
    });
    expect(latestNativeCheck([check(), pending], definition, sha)).toEqual(pending);
    expect(latestNativeCheck([check({ id: 3 }), pending], definition, sha)).toEqual(pending);
    expect(
      latestNativeCheck([check(), check({ id: 2, external_id: "" })], definition, sha),
    ).toBeUndefined();
    expect(latestNativeCheck([check(), check()], definition, sha)).toBeUndefined();
  });

  it("uses only one positive independent assertion; unknowns or contradictions preserve labels", () => {
    const success = check();
    const failure = check({ conclusion: "failure" });
    expect(nativeLabelAction(success, failure)).toBe("add");
    expect(nativeLabelAction(failure, success)).toBe("remove");
    expect(nativeLabelAction(success, success)).toBeUndefined();
    expect(nativeLabelAction(failure, failure)).toBeUndefined();
    for (const unknown of [
      undefined,
      check({ status: "queued", conclusion: null }),
      check({ conclusion: "cancelled" }),
      check({ conclusion: "neutral" }),
      check({ conclusion: "skipped" }),
    ]) {
      expect(nativeLabelAction(success, unknown)).toBeUndefined();
      expect(nativeLabelAction(unknown, success)).toBeUndefined();
    }
  });

  it("aggregates native status and removes a label only on a complete clean assertion, without ADO", async () => {
    const args = setup();
    const breaking = config[0].breakingChange!;
    args.github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          check(),
          check({
            name: breaking.present.name,
            external_id: `124|102|${projectId}`,
            conclusion: "failure",
          }),
          check({ name: breaking.absent.name, external_id: `125|103|${projectId}` }),
        ],
      },
    });
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success", sha }),
    );
    expect(args.github.rest.issues.removeLabel).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs-pr",
      issue_number: 42,
      name: "BreakingChange-JavaScript-Sdk",
    });
    expect(args.github.rest.checks.listForRef).toHaveBeenCalledWith(
      expect.objectContaining({ filter: "all", ref: sha }),
    );
  });

  it("keeps status pending and labels untouched for missing configured checks", async () => {
    const args = setup();
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "pending" }),
    );
    expect(args.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(args.github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it.each(["main", "release"])(
    "applies a positive assertion only on a supported addition target (%s)",
    async (target) => {
      const args = setup();
      const breaking = config[0].breakingChange!;
      args.github.rest.pulls.get.mockResolvedValue({
        data: { state: "open", head: { sha }, base: { ref: target }, labels: [] },
      });
      args.github.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            check(),
            check({ name: breaking.present.name, external_id: `124|102|${projectId}` }),
            check({
              name: breaking.absent.name,
              external_id: `125|103|${projectId}`,
              conclusion: "failure",
            }),
          ],
        },
      });
      await reconcileNativeSdkChecks(args, config);
      if (target === "main") {
        expect(args.github.rest.issues.addLabels).toHaveBeenCalledWith(
          expect.objectContaining({ issue_number: 42, labels: [breaking.label] }),
        );
      } else {
        expect(args.github.rest.issues.addLabels).not.toHaveBeenCalled();
      }
    },
  );

  it("supersedes a prior successful validation with a queued or failed rerun", async () => {
    const args = setup();
    const rerun = check({
      id: 2,
      external_id: `123|101|${projectId}`,
      status: "queued",
      conclusion: null,
    });
    args.github.rest.checks.listForRef.mockResolvedValue({
      data: { check_runs: [check(), rerun] },
    });
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "pending" }),
    );
    args.github.rest.checks.listForRef.mockResolvedValue({
      data: { check_runs: [check(), { ...rerun, status: "completed", conclusion: "failure" }] },
    });
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it("ignores stale head events", async () => {
    const args = setup();
    args.github.rest.pulls.get.mockResolvedValue({ data: { state: "open", head: { sha: "new" } } });
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    expect(args.github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("rechecks the live PR head before applying a previously computed clean assertion", async () => {
    const args = setup();
    const breaking = config[0].breakingChange!;
    args.github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          check(),
          check({
            name: breaking.present.name,
            external_id: `124|102|${projectId}`,
            conclusion: "failure",
          }),
          check({ name: breaking.absent.name, external_id: `125|103|${projectId}` }),
        ],
      },
    });
    args.github.rest.pulls.get
      .mockResolvedValueOnce({ data: { state: "open", head: { sha } } })
      .mockResolvedValueOnce({ data: { state: "open", head: { sha: "new" } } });
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.createCommitStatus).toHaveBeenCalled();
    expect(args.github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("resolves native check events to live PRs through GitHub alone", async () => {
    const args = setup();
    args.context.eventName = "check_run";
    args.context.payload = { check_run: check() };
    args.github.rest.repos.listPullRequestsAssociatedWithCommit.mockResolvedValue({
      data: [{ number: 42, base: { repo: { full_name: "Azure/azure-rest-api-specs-pr" } } }],
    });
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.repos.listPullRequestsAssociatedWithCommit).toHaveBeenCalledWith(
      expect.objectContaining({ commit_sha: sha }),
    );
    expect(args.github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "pending" }),
    );
  });

  it("leaves public repositories entirely on the existing path", async () => {
    const args = setup();
    args.context.repo.repo = "azure-rest-api-specs";
    await reconcileNativeSdkChecks(args, config);
    expect(args.github.rest.pulls.get).not.toHaveBeenCalled();
    expect(args.github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});
