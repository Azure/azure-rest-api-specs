import { beforeEach, describe, expect, it, vi } from "vitest";
import type { GitHubScriptArgs } from "../../src/github.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
}));
vi.mock("js-yaml", () => ({
  default: { load: vi.fn() },
}));

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import validateApproval from "../../src/typespec-suppressions/validate-approval.ts";

const APPROVAL_LABEL = "typespec-suppressions-approved";

function createLabeledPayload(labelName: string, actor: string) {
  return {
    action: "labeled",
    label: { name: labelName },
    sender: { login: actor, type: "User" },
    repository: { owner: { login: "Azure" }, name: "azure-rest-api-specs" },
    pull_request: {
      number: 42,
      head: { sha: "abc123" },
      labels: [{ name: labelName }, { name: "typespec-suppressions-review-required" }],
    },
  };
}

describe("validate TypeSpec suppressions approval", () => {
  const github = createMockGithub();
  const context = createMockContext();
  const core = createMockCore();

  function args(): GitHubScriptArgs {
    return {
      github,
      context,
      core,
    };
  }

  beforeEach(() => {
    vi.clearAllMocks();
    context.eventName = "pull_request_target";
    (readFile as ReturnType<typeof vi.fn>).mockResolvedValue("yaml-content");
    (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue({
      "global-approvers": ["architect"],
      [APPROVAL_LABEL]: [],
    });
  });

  it("removes an approval label applied by an unauthorized user", async () => {
    context.payload = createLabeledPayload(APPROVAL_LABEL, "service-team-user");

    await validateApproval(args());

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 42,
      name: APPROVAL_LABEL,
    });
    expect(core.warning).toHaveBeenCalledWith(
      `service-team-user is not authorized to apply "${APPROVAL_LABEL}", removing.`,
    );
  });

  it("allows a global approver to apply the approval label", async () => {
    context.payload = createLabeledPayload(APPROVAL_LABEL, "architect");

    await validateApproval(args());

    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("allows a trusted bot to apply the approval label", async () => {
    context.payload = createLabeledPayload(APPROVAL_LABEL, "github-actions[bot]");

    await validateApproval(args());

    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("fails closed when the approval label is missing from protected-labels.yml", async () => {
    context.payload = createLabeledPayload(APPROVAL_LABEL, "service-team-user");
    (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue({
      "global-approvers": ["architect"],
    });

    await expect(validateApproval(args())).rejects.toThrow(
      `Cannot validate "${APPROVAL_LABEL}" authorization: policy returned unprotected.`,
    );
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("ignores unrelated label events", async () => {
    context.payload = createLabeledPayload("other-label", "service-team-user");

    await validateApproval(args());

    expect(readFile).not.toHaveBeenCalled();
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });
});
