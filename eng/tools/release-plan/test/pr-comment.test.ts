import { describe, expect, it, vi } from "vitest";
import {
  buildReleaseplanCommentBody,
  postMultipleProjectsComment,
  postReleasePlanComment,
  postReleasePlanErrorComment,
} from "../src/pr-comment.ts";

type CreateCommentParams = {
  owner: string;
  repo: string;
  issue_number: number;
  body: string;
};

describe("PR comment creation", () => {
  it("reports all ambiguous projects and explains manual release plan creation", async () => {
    const createComment = vi
      .fn<(params: CreateCommentParams) => Promise<unknown>>()
      .mockResolvedValue(undefined);
    const paths = ["specification/first/First", "specification/second/Second"];

    await postMultipleProjectsComment({
      octokit: { rest: { issues: { createComment } } },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 42,
      tspProjectPaths: paths,
    });

    expect(createComment).toHaveBeenCalledOnce();
    const [comment] = createComment.mock.calls[0];
    expect(comment).toMatchObject({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 42,
    });
    const body = comment.body;
    expect(body).toContain("Release Plan Creation Skipped");
    for (const project of paths) {
      expect(body).toContain(`\`${project}\``);
    }
    expect(body).toContain("No release plan was created");
    expect(body).toContain("aka.ms/azsdk/releaseplan-dashboard");
  });

  it("fails explicitly when the ambiguity comment cannot be posted", async () => {
    await expect(
      postMultipleProjectsComment({
        octokit: { rest: {} },
        owner: "Azure",
        repo: "azure-rest-api-specs",
        prNumber: 42,
        tspProjectPaths: ["specification/first/First", "specification/second/Second"],
      }),
    ).rejects.toThrow("Octokit issues.createComment is not available.");
  });

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
    expect(body).toContain("The SDK will be generated based on API version `2025-06-01-preview`");
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

  it("posts release plan error details with the optional project path", async () => {
    const createComment = vi.fn().mockResolvedValueOnce(undefined);

    await postReleasePlanErrorComment({
      octokit: { rest: { issues: { createComment } } },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 42,
      error: "azsdk failed",
      tspProjectPath: "specification/test/Test.Service",
    });

    const firstCall = createComment.mock.calls[0] as [CreateCommentParams] | undefined;
    if (!firstCall) {
      throw new Error("Expected createComment to have one call.");
    }
    const [call] = firstCall;
    expect(call.owner).toBe("Azure");
    expect(call.repo).toBe("azure-rest-api-specs");
    expect(call.issue_number).toBe(42);
    expect(call.body).toContain("### ❌ Release Plan Creation Failed");
    expect(call.body).toContain("azsdk failed");
    expect(call.body).toContain("specification/test/Test.Service");
    expect(call.body).toContain("aka.ms/azsdk/releaseplan-dashboard");
  });

  it("omits the project path when posting an error without one", async () => {
    const createComment = vi.fn().mockResolvedValueOnce(undefined);

    await postReleasePlanErrorComment({
      octokit: { rest: { issues: { createComment } } },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 42,
      error: "azsdk failed",
    });

    const firstCall = createComment.mock.calls[0] as [CreateCommentParams] | undefined;
    if (!firstCall) {
      throw new Error("Expected createComment to have one call.");
    }
    const [call] = firstCall;
    expect(call.body).not.toContain("TypeSpec Project");
  });

  it("throws when error comment creation is unavailable", async () => {
    await expect(
      postReleasePlanErrorComment({
        octokit: { rest: {} },
        owner: "Azure",
        repo: "azure-rest-api-specs",
        prNumber: 42,
        error: "azsdk failed",
      }),
    ).rejects.toThrow(
      "Failed to post error comment on PR #42: Octokit issues.createComment is not available.",
    );
  });

  it("wraps API failures while posting an error comment", async () => {
    const createComment = vi.fn().mockRejectedValueOnce(new Error("Network error"));

    await expect(
      postReleasePlanErrorComment({
        octokit: { rest: { issues: { createComment } } },
        owner: "Azure",
        repo: "azure-rest-api-specs",
        prNumber: 42,
        error: "azsdk failed",
      }),
    ).rejects.toThrow("Failed to post error comment on PR #42: Network error");
  });
});
