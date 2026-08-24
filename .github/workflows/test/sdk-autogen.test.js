import { describe, expect, it, vi } from "vitest";
import {
  buildSdkAutogenIssueRequest,
  parseSdkAutogenCommand,
  runSdkAutogen,
} from "../src/sdk-autogen.js";

const HEAD_SHA = "0123456789abcdef0123456789abcdef01234567";
const PULL_REQUEST_URL = "https://github.com/Azure/azure-rest-api-specs/pull/123";

/**
 * @param {unknown} args
 */
function invokeSdkAutogen(args) {
  return runSdkAutogen(
    /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (args),
  );
}

describe("sdk-autogen", () => {
  it("defaults the target branch to main", () => {
    expect(parseSdkAutogenCommand("/sdk-autogen ai-projects javascript")).toEqual({
      library: "ai-projects",
      language: "javascript",
      branch: "main",
    });
  });

  it("accepts an explicit target branch", () => {
    expect(parseSdkAutogenCommand("/sdk-autogen AI-Projects JavaScript feature/regen-v2")).toEqual({
      library: "ai-projects",
      language: "javascript",
      branch: "feature/regen-v2",
    });
  });

  it.each([
    "/sdk-autogen",
    "/sdk-autogen ai-projects",
    "/sdk-autogen unknown javascript",
    "/sdk-autogen ai-projects python",
    "/sdk-autogen ai-projects javascript branch extra",
    "/sdk-autogen ai-projects javascript invalid branch",
  ])("rejects an unsupported command: %s", (command) => {
    expect(() => parseSdkAutogenCommand(command)).toThrow();
  });

  it("reports the supported library", () => {
    expect(() => parseSdkAutogenCommand("/sdk-autogen unknown javascript")).toThrow(
      "Unsupported SDK library: unknown. Supported libraries: ai-projects",
    );
  });

  it("reports the languages supported by the selected library", () => {
    expect(() => parseSdkAutogenCommand("/sdk-autogen ai-projects python")).toThrow(
      "Unsupported SDK language for ai-projects: python. Supported languages: javascript",
    );
  });

  it("builds the JavaScript issue and Copilot assignment payload", () => {
    const request = buildSdkAutogenIssueRequest({
      library: "ai-projects",
      language: "javascript",
      branch: "feature/regen-v2",
      headSha: HEAD_SHA,
      pullRequestUrl: PULL_REQUEST_URL,
    });

    expect(request).toMatchObject({
      owner: "Azure",
      repo: "azure-sdk-for-js",
      title: `[ai-projects] regen from ${HEAD_SHA} against feature/regen-v2`,
      assignees: ["copilot-swe-agent[bot]"],
      agent_assignment: {
        target_repo: "Azure/azure-sdk-for-js",
        base_branch: "feature/regen-v2",
        custom_instructions: "",
        custom_agent: "ai-projects-regen",
        model: "",
      },
    });
    expect(request.body).toBe(`### TypeSpec commit
${HEAD_SHA}

### Base branch
feature/regen-v2

### Assignment check

- [x] ai-projects-typespec-regen:v1 - The title, base branch field, and Copilot starting branch all match.

### Source pull request
${PULL_REQUEST_URL}`);
  });

  it("resolves the PR head and creates the assigned issue", async () => {
    const getCollaboratorPermissionLevel = vi.fn().mockResolvedValue({
      data: { permission: "write" },
    });
    const getBranch = vi.fn().mockResolvedValue({ data: { name: "main" } });
    const getPull = vi.fn().mockResolvedValue({
      data: { state: "open", head: { sha: HEAD_SHA }, html_url: PULL_REQUEST_URL },
    });
    const request = vi.fn().mockResolvedValue({
      data: { number: 456, html_url: "https://github.com/Azure/azure-sdk-for-js/issues/456" },
    });
    const setOutput = vi.fn();
    const github = {
      rest: {
        repos: { getCollaboratorPermissionLevel, getBranch },
        pulls: { get: getPull },
      },
      request,
    };
    const context = {
      eventName: "issue_comment",
      repo: { owner: "Azure", repo: "azure-rest-api-specs" },
      payload: {
        issue: { number: 123, pull_request: {} },
        comment: {
          body: "/sdk-autogen ai-projects javascript",
          user: { login: "maintainer" },
        },
      },
    };
    const core = { info: vi.fn(), setOutput };

    await expect(invokeSdkAutogen({ github, context, core })).resolves.toEqual({
      issueNumber: 456,
      issueUrl: "https://github.com/Azure/azure-sdk-for-js/issues/456",
    });
    expect(getBranch).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-sdk-for-js",
      branch: "main",
    });
    expect(request).toHaveBeenCalledWith(
      "POST /repos/{owner}/{repo}/issues",
      expect.objectContaining({
        title: `[ai-projects] regen from ${HEAD_SHA} against main`,
        body: /** @type {unknown} */ (expect.stringContaining(PULL_REQUEST_URL)),
        agent_assignment: /** @type {unknown} */ (
          expect.objectContaining({
            base_branch: "main",
            custom_agent: "ai-projects-regen",
          })
        ),
      }),
    );
    expect(setOutput).toHaveBeenCalledWith(
      "issue-url",
      "https://github.com/Azure/azure-sdk-for-js/issues/456",
    );
  });

  it("rejects command authors without write access", async () => {
    const request = vi.fn();
    const github = {
      rest: {
        repos: {
          getCollaboratorPermissionLevel: vi.fn().mockResolvedValue({
            data: { permission: "read", user: { permissions: { push: false } } },
          }),
        },
      },
      request,
    };
    const context = {
      eventName: "issue_comment",
      repo: { owner: "Azure", repo: "azure-rest-api-specs" },
      payload: {
        issue: { number: 123, pull_request: {} },
        comment: {
          body: "/sdk-autogen ai-projects javascript",
          user: { login: "reader" },
        },
      },
    };

    await expect(
      invokeSdkAutogen({ github, context, core: { info: vi.fn(), setOutput: vi.fn() } }),
    ).rejects.toThrow("reader must have write access");
    expect(request).not.toHaveBeenCalled();
  });
});
