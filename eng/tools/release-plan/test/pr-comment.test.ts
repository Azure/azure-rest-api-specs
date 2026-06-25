import { describe, expect, it, vi } from "vitest";
import { buildReleaseplanCommentBody, postReleasePlanComment } from "../src/pr-comment.js";

type CreateCommentParams = {
  owner: string;
  repo: string;
  issue_number: number;
  body: string;
};

describe("PR comment creation", () => {
  it("builds markdown comment body with all fields", () => {
    const body = buildReleaseplanCommentBody({
      planId: "123",
      planLink: "https://example.com/plan/123",
      apiVersion: "2025-06-01-preview",
      tspProjectPath: "specification/foo/Contoso.Service",
    });

    expect(body).toContain("### ✅ Release Plan Created");
    expect(body).toContain("[View Release Plan](https://example.com/plan/123)");
    expect(body).toContain("Release Plan ID");
    expect(body).toContain("123");
    expect(body).toContain("2025-06-01-preview");
    expect(body).toContain("specification/foo/Contoso.Service");
  });

  it("builds comment body without link", () => {
    const body = buildReleaseplanCommentBody({
      planId: "456",
      apiVersion: "2025-05-01",
      tspProjectPath: "specification/bar/Contoso.Bar",
    });

    expect(body).toContain("### ✅ Release Plan Created");
    expect(body).not.toContain("[View Release Plan]");
    expect(body).toContain("456");
    expect(body).toContain("2025-05-01");
  });

  it("builds comment body without plan ID", () => {
    const body = buildReleaseplanCommentBody({
      planLink: "https://example.com/plan/789",
      apiVersion: "2025-04-01-preview",
      tspProjectPath: "specification/baz/Contoso.Baz",
    });

    expect(body).toContain("### ✅ Release Plan Created");
    expect(body).toContain("[View Release Plan](https://example.com/plan/789)");
    expect(body).not.toContain("Release Plan ID");
    expect(body).toContain("2025-04-01-preview");
  });

  it("posts comment successfully on PR", async () => {
    const createComment = vi.fn().mockResolvedValueOnce(undefined);

    await postReleasePlanComment({
      octokit: {
        rest: {
          issues: {
            createComment,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 42,
      planId: "999",
      planLink: "https://example.com/plan/999",
      apiVersion: "2025-06-01",
      tspProjectPath: "specification/test/Test.Service",
    });

    expect(createComment).toHaveBeenCalledOnce();
    const firstCall = createComment.mock.calls[0] as [CreateCommentParams] | undefined;
    if (!firstCall) {
      throw new Error("Expected createComment to have one call.");
    }
    const [call] = firstCall;
    expect(call.owner).toBe("Azure");
    expect(call.repo).toBe("azure-rest-api-specs");
    expect(call.issue_number).toBe(42);
    expect(call.body).toContain("Release Plan Created");
  });

  it("throws error when posting comment fails", async () => {
    const createComment = vi.fn().mockRejectedValueOnce(new Error("Network error"));

    await expect(
      postReleasePlanComment({
        octokit: {
          rest: {
            issues: {
              createComment,
            },
          },
        },
        owner: "Azure",
        repo: "azure-rest-api-specs",
        prNumber: 42,
        apiVersion: "2025-06-01",
        tspProjectPath: "specification/test/Test.Service",
      }),
    ).rejects.toThrow("Failed to post release plan comment on PR #42");
  });

  it("posts comment without plan link or ID", async () => {
    const createComment = vi.fn().mockResolvedValueOnce(undefined);

    await postReleasePlanComment({
      octokit: {
        rest: {
          issues: {
            createComment,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 123,
      apiVersion: "2025-07-01-preview",
      tspProjectPath: "specification/minimal/Minimal.Service",
    });

    expect(createComment).toHaveBeenCalledOnce();
    const firstCall = createComment.mock.calls[0] as [CreateCommentParams] | undefined;
    if (!firstCall) {
      throw new Error("Expected createComment to have one call.");
    }
    const [call] = firstCall;
    expect(call.body).toContain("2025-07-01-preview");
    expect(call.body).toContain("specification/minimal/Minimal.Service");
  });
});
