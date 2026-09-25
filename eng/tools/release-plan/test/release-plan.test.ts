import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import {
  ensureReleasePlan,
  getApiReleaseType,
  getReleasePlanResultById,
  getSdkReleaseType,
  parseAzdskResponse,
} from "../src/release-plan.ts";
import type { AzsdkRunner, CommandResult } from "../src/types.ts";
import {
  API_VERSION,
  cleanGit,
  context,
  OLD_SHA,
  ok,
  plan,
  PR_URL,
  SPEC_PATH,
  SPEC_SHA,
  WORKSPACE,
} from "./test-helpers.ts";

describe("release type helpers", () => {
  it("sets Private Preview for private specs repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs-pr")).toBe("Private Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs-pr")).toBe("Private Preview");
  });

  it("sets Public Preview or GA for public repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs")).toBe("Public Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs")).toBe("GA");
  });

  it("sets SDK release type", () => {
    expect(getSdkReleaseType(true)).toBe("beta");
    expect(getSdkReleaseType(false)).toBe("stable");
  });
});

describe("azsdk JSON response contract", () => {
  it("accepts the exact enum and workflow status casing emitted by the CLI", () => {
    // CommandResponse.Status uses JsonStringEnumConverter; workflow status is a separate string.
    const response = { operation_status: "Succeeded", status: "Success", response_errors: [] };
    expect(parseAzdskResponse(ok(response), "release-plan update-spec-pr")).toEqual(response);
    expect(parseAzdskResponse(ok(plan()), "release-plan get")).toEqual(plan());
  });

  it.each([
    { operation_status: "Failed" },
    { operation_status: "succeeded" },
    { operation_status: 0 },
    { operation_status: null },
    { operation_status: "Succeeded", status: "Failed" },
    { operation_status: "Succeeded", status: "Confirmation required" },
    { operation_status: "Succeeded", status: "success" },
    { operation_status: "Succeeded", status: "" },
  ])("rejects unsuccessful or non-contract statuses even with exit zero: %j", (response) => {
    expect(() => parseAzdskResponse(ok(response), "release-plan update-spec-pr")).toThrow();
  });

  it("does not turn a lookup exception or additional response errors into permission to create", () => {
    for (const response of [
      {
        operation_status: "Failed",
        response_error: "Failed to get release plan details: TF215106 access denied",
      },
      {
        operation_status: "Failed",
        response_error: "Failed to get release plan details.",
        response_errors: ["permission denied"],
      },
    ]) {
      expect(() => parseAzdskResponse(ok(response), "release-plan get", true)).toThrow();
    }
  });
});

describe("ensureReleasePlan", () => {
  function scriptedRunner(...responses: CommandResult[]) {
    return vi.fn<AzsdkRunner>((args) => {
      const response = responses.shift();
      if (!response) {
        throw new Error(`Unexpected azsdk command: ${args.join(" ")}`);
      }
      return response;
    });
  }

  const previous = () =>
    plan({ SpecCommitSHA: OLD_SHA, ActiveSpecPullRequest: PR_URL.replace("123", "100") });

  it.each(["pr", "path"])("explicitly advances a same-version follow-up found by %s", (route) => {
    const existing = route === "pr" ? plan({ SpecCommitSHA: OLD_SHA }) : previous();
    const responses = [ok(existing), ok(), ok(plan())];
    if (route === "path") {
      responses.unshift(ok(null));
    }
    const runner = scriptedRunner(...responses);
    const result = ensureReleasePlan(context, runner, true, cleanGit());

    expect(result.outcome).toBe(`existing_by_${route}`);
    expect(result.releasePlan).toEqual(plan());
    expect(runner.mock.calls[0][0]).toEqual([
      "release-plan",
      "get",
      "--pull-request",
      PR_URL,
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--api-version",
      API_VERSION,
      "--api-release-type",
      "Public Preview",
      "--output",
      "json",
    ]);
    expect(runner).toHaveBeenCalledWith([
      "release-plan",
      "update-spec-pr",
      "--workitem-id",
      "9001",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--pull-request",
      PR_URL,
      "--api-version",
      API_VERSION,
      "--spec-commit-sha",
      SPEC_SHA,
      "--confirm-target",
      "--expected-spec-commit-sha",
      OLD_SHA,
      "--output",
      "json",
    ]);
    expect(runner.mock.calls.at(-1)?.[0]).toEqual([
      "release-plan",
      "get",
      "--workitem-id",
      "9001",
      "--output",
      "json",
    ]);
    expect(runner.mock.calls.some(([args]) => args[1] === "update")).toBe(false);
  });

  it("identifies a different PR returned by the combined version query as a path match", () => {
    const runner = scriptedRunner(ok(previous()), ok(), ok(plan()));
    const result = ensureReleasePlan(context, runner, true, cleanGit());
    expect(result.outcome).toBe("existing_by_path");
    expect(runner.mock.calls.map(([args]) => args[1])).toEqual(["get", "update-spec-pr", "get"]);
    expect(runner.mock.calls[1][0]).toContain("--expected-spec-commit-sha");
  });

  it.each([undefined, ""])("uses an observed empty pin precondition (%s)", (SpecCommitSHA) => {
    const runner = scriptedRunner(ok(plan({ SpecCommitSHA })), ok(), ok(plan()));
    ensureReleasePlan(context, runner, true, cleanGit());
    const updateArgs = runner.mock.calls[1][0];
    expect(updateArgs[updateArgs.indexOf("--expected-spec-commit-sha") + 1]).toBe("none");
    expect(runner.mock.calls.map(([args]) => args[1])).toEqual(["get", "update-spec-pr", "get"]);
  });

  it("does not refresh the precondition or retry when a newer pin races discovery", () => {
    const runner = scriptedRunner(
      ok(previous()),
      ok({ operation_status: "Failed", response_error: "The expected spec commit changed." }),
    );
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow(/expected spec/);
    expect(runner).toHaveBeenCalledTimes(2);
    const updateArgs = runner.mock.calls[1][0];
    expect(updateArgs[updateArgs.indexOf("--expected-spec-commit-sha") + 1]).toBe(OLD_SHA);
    expect(updateArgs[updateArgs.indexOf("--spec-commit-sha") + 1]).toBe(SPEC_SHA);
  });

  it.each([false, true])(
    "creates and reads back an explicit target (test-release=%s)",
    (testReleasePlan) => {
      const runner = scriptedRunner(ok(null), ok(null), ok(plan()), ok(plan()));
      const result = ensureReleasePlan({ ...context, testReleasePlan }, runner, true, cleanGit());
      expect(result.outcome).toBe("created");
      expect(runner).toHaveBeenCalledWith([
        "release-plan",
        "create",
        "--typespec-path",
        path.resolve(WORKSPACE, SPEC_PATH),
        "--api-release-type",
        "Public Preview",
        "--release-month",
        "July 2026",
        "--pull-request",
        PR_URL,
        "--test-release",
        String(testReleasePlan),
        "--api-version",
        API_VERSION,
        "--spec-commit-sha",
        SPEC_SHA,
        "--confirm-target",
        "--output",
        "json",
      ]);
      expect(result.details).toMatchObject({ apiVersion: API_VERSION, specCommitSha: SPEC_SHA });
    },
  );

  it("preserves the caller's target month rather than inferring it during create", () => {
    const runner = scriptedRunner(ok(null), ok(null), ok(plan()), ok(plan()));
    ensureReleasePlan({ ...context, targetMonth: "December 2025" }, runner, true, cleanGit());
    expect(runner.mock.calls[2][0]).toContain("December 2025");
  });

  it("explicitly advances a same-version plan reused concurrently by create", () => {
    const runner = scriptedRunner(ok(null), ok(null), ok(previous()), ok(), ok(plan()));
    const result = ensureReleasePlan(context, runner, true, cleanGit());
    expect(result.outcome).toBe("existing_by_path");
    expect(result.releasePlan).toEqual(plan());
    expect(runner.mock.calls.map(([args]) => args[1])).toEqual([
      "get",
      "get",
      "create",
      "update-spec-pr",
      "get",
    ]);
    const updateArgs = runner.mock.calls[3][0];
    expect(updateArgs[updateArgs.indexOf("--expected-spec-commit-sha") + 1]).toBe(OLD_SHA);
  });

  it("never rolls back a newer pin returned by a concurrent create", () => {
    const runner = scriptedRunner(ok(null), ok(null), ok(plan()));
    const result = ensureReleasePlan(
      { ...context, specCommitSha: OLD_SHA },
      runner,
      true,
      cleanGit(OLD_SHA),
    );
    expect(result.outcome).toBe("stale_event");
    expect(runner).toHaveBeenCalledTimes(3);
  });

  it("does not update a different API version reused by create", () => {
    const runner = scriptedRunner(ok(null), ok(null), ok(plan({ SpecAPIVersion: "2026-06-01" })));
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow(/does not match/);
    expect(runner).toHaveBeenCalledTimes(3);
  });

  it("recognizes the CLI's exact structured not-found result", () => {
    const missing = {
      ...ok({ response_error: "Failed to get release plan details.", operation_status: "Failed" }),
      exitCode: 1,
    };
    const runner = scriptedRunner(missing, missing, ok(plan()), ok(plan()));
    expect(ensureReleasePlan(context, runner, true, cleanGit()).outcome).toBe("created");
  });

  it("does not create a plan when creation is disabled", () => {
    const runner = scriptedRunner(ok(null), ok(null));
    const result = ensureReleasePlan(context, runner, false, cleanGit());
    expect(result.outcome).toBe("not_found");
    expect(result.releasePlan).toBeNull();
    expect(runner).toHaveBeenCalledTimes(2);
  });

  it("still explicitly updates an existing plan when creation is disabled", () => {
    const runner = scriptedRunner(ok(previous()), ok(), ok(plan()));
    expect(ensureReleasePlan(context, runner, false, cleanGit()).outcome).toBe("existing_by_path");
    expect(runner.mock.calls[1][0][1]).toBe("update-spec-pr");
  });

  it("retried events do not reset the same pin, SDK PR or pending generation state", () => {
    const existing = plan({
      SDKInfo: [
        {
          Language: "Python",
          GenerationStatus: "Pending",
          SdkPullRequestUrl: "https://github.com/Azure/azure-sdk-for-python/pull/42",
        },
      ],
    });
    const runner = scriptedRunner(ok(existing));
    const git = cleanGit();
    expect(ensureReleasePlan(context, runner, true, git).releasePlan).toEqual(existing);
    expect(runner).toHaveBeenCalledOnce();
    expect(git.mock.calls.some(([, args]) => args[0] === "merge-base")).toBe(false);
  });

  it("keeps a newer descendant pin and marks an older delayed event stale", () => {
    const runner = scriptedRunner(ok(plan()));
    const result = ensureReleasePlan(
      { ...context, specCommitSha: OLD_SHA },
      runner,
      true,
      cleanGit(OLD_SHA),
    );
    expect(result.outcome).toBe("stale_event");
    expect(result.releasePlan).toEqual(plan());
    expect(runner).toHaveBeenCalledOnce();
  });

  it.each([1, 128])("stops on divergent or unknown commit ancestry (exit %s)", (exitCode) => {
    const git = cleanGit();
    const base = git.getMockImplementation()!;
    git.mockImplementation((workspace, args) =>
      args[0] === "merge-base"
        ? { exitCode, stdout: "", stderr: "missing history" }
        : base(workspace, args),
    );
    const runner = scriptedRunner(ok(previous()));
    expect(() => ensureReleasePlan(context, runner, true, git)).toThrow(
      /ancestry|divergent|incomplete/,
    );
    expect(runner).toHaveBeenCalledOnce();
  });

  it.each([
    { SpecAPIVersion: "2026-06-01" },
    { ApiReleaseType: 3 },
    { APISpecProjectPath: "specification/other/Other.Management" },
    { WorkItemId: undefined },
    { SpecCommitSHA: "main" },
  ])("rejects an incompatible lookup instead of falling back: %j", (details) => {
    const runner = scriptedRunner(ok(plan(details)));
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow();
    expect(runner).toHaveBeenCalledOnce();
  });

  it("selects the January preview plan rather than another version associated with the same PR", () => {
    const plans = [
      plan({
        SpecAPIVersion: "2026-06-01",
        ApiReleaseType: 3,
        ReleasePlanId: "54321",
        WorkItemId: "9002",
      }),
      plan(),
    ];
    const runner = vi.fn<AzsdkRunner>((args) =>
      ok(
        plans.find(
          (candidate) =>
            candidate.release_plan_details?.SpecAPIVersion ===
            args[args.indexOf("--api-version") + 1],
        ),
      ),
    );
    const result = ensureReleasePlan(context, runner, true, cleanGit());
    expect(result.releasePlan?.release_plan_details?.WorkItemId).toBe("9001");
    expect(runner).toHaveBeenCalledOnce();
  });

  const rejectedResponses = [
    ok({ requires_confirmation: true, proposed_spec_target: {}, ...plan() }),
    ok({ response_error: "permission denied" }),
    ok({ response_errors: ["target mismatch"] }),
    ok({ status: "Failed" }),
    ok({ operation_status: "Failed" }),
    { exitCode: 0, stdout: "{invalid", stderr: "" },
    { exitCode: 1, stdout: "", stderr: "Unknown option --confirm-target" },
  ];
  it.each(rejectedResponses)("never retries an unsafe discovery response: %j", (response) => {
    const runner = scriptedRunner(response);
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow();
    expect(runner).toHaveBeenCalledOnce();
  });
  it.each(rejectedResponses)("does not accept a preview or failed create: %j", (response) => {
    const runner = scriptedRunner(ok(null), ok(null), response);
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow();
    expect(runner).toHaveBeenCalledTimes(3);
  });
  it.each(rejectedResponses)("does not accept a preview or failed spec update: %j", (response) => {
    const runner = scriptedRunner(ok(previous()), response);
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow();
    expect(runner).toHaveBeenCalledTimes(2);
  });

  it("rejects an old CLI create response without the selected commit pin", () => {
    const runner = scriptedRunner(ok(null), ok(null), ok(plan({ SpecCommitSHA: undefined })));
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow(/40-character/);
    expect(runner).toHaveBeenCalledTimes(3);
  });

  it.each([
    { SpecAPIVersion: "2026-06-01" },
    { SpecCommitSHA: OLD_SHA },
    { APISpecProjectPath: "specification/other/Other.Management" },
    { ActiveSpecPullRequest: PR_URL.replace("123", "456") },
    { WorkItemId: "9002" },
    { ReleasePlanId: "54321" },
  ])("validates the spec-update readback before returning an artifact: %j", (details) => {
    const runner = scriptedRunner(ok(previous()), ok(), ok(plan(details)));
    expect(() => ensureReleasePlan(context, runner, true, cleanGit())).toThrow();
    expect(runner).toHaveBeenCalledTimes(3);
  });

  it("requires clean HEAD to match the event before discovery", () => {
    const runner = vi.fn<AzsdkRunner>();
    expect(() => ensureReleasePlan(context, runner, true, cleanGit(OLD_SHA))).toThrow(/HEAD/);
    expect(runner).not.toHaveBeenCalled();
  });

  it("rechecks checkout before writing after discovery", () => {
    const git = cleanGit();
    const runner = scriptedRunner(ok(previous()));
    runner.mockImplementationOnce(() => {
      git.mockReturnValue({ exitCode: 0, stdout: OLD_SHA, stderr: "" });
      return ok(plan({ SpecCommitSHA: undefined }));
    });
    expect(() => ensureReleasePlan(context, runner, true, git)).toThrow(/HEAD/);
    expect(runner).toHaveBeenCalledOnce();
  });

  it("preserves private-preview plan creation without requiring a generation pin", () => {
    const prUrl = PR_URL.replace("azure-rest-api-specs/", "azure-rest-api-specs-pr/");
    const privatePlan = plan({
      ApiReleaseType: 1,
      ActiveSpecPullRequest: prUrl,
      SpecCommitSHA: undefined,
    });
    const runner = scriptedRunner(ok(null), ok(null), ok(privatePlan), ok(privatePlan));
    expect(
      ensureReleasePlan(
        { ...context, prUrl, apiReleaseType: "Private Preview" },
        runner,
        true,
        cleanGit(),
      ).outcome,
    ).toBe("created");
    expect(runner.mock.calls[2][0]).toEqual([
      "release-plan",
      "create",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--api-release-type",
      "Private Preview",
      "--release-month",
      "July 2026",
      "--pull-request",
      prUrl,
      "--test-release",
      "false",
      "--output",
      "json",
    ]);
  });

  it("relinks a private-preview tracking plan without public target arguments or ancestry", () => {
    const prUrl = PR_URL.replace("azure-rest-api-specs/", "azure-rest-api-specs-pr/");
    const privatePlan = plan({
      ApiReleaseType: 1,
      ActiveSpecPullRequest: prUrl,
      SpecCommitSHA: undefined,
    });
    const runner = scriptedRunner(
      ok(
        plan({
          ...privatePlan.release_plan_details,
          ActiveSpecPullRequest: prUrl.replace("123", "100"),
        }),
      ),
      ok(),
      ok(privatePlan),
    );
    const git = cleanGit();
    const result = ensureReleasePlan(
      { ...context, prUrl, apiReleaseType: "Private Preview" },
      runner,
      true,
      git,
    );
    expect(result.outcome).toBe("existing_by_path");
    expect(runner.mock.calls[1][0]).toEqual([
      "release-plan",
      "update-spec-pr",
      "--workitem-id",
      "9001",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--pull-request",
      prUrl,
      "--output",
      "json",
    ]);
    expect(git.mock.calls.some(([, args]) => args[0] === "merge-base")).toBe(false);
  });

  it("gets only the requested stored release plan in ID-only mode", () => {
    const runner = scriptedRunner(ok(plan({ SpecCommitSHA: OLD_SHA })));
    const result = getReleasePlanResultById(" 12345 ", runner);
    expect(runner).toHaveBeenCalledExactlyOnceWith([
      "release-plan",
      "get",
      "--release-plan-id",
      "12345",
      "--output",
      "json",
    ]);
    expect(result).toEqual({
      outcome: "existing_by_id",
      releasePlan: plan({ SpecCommitSHA: OLD_SHA }),
      details: { releasePlanId: "12345" },
    });
  });
});
