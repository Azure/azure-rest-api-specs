import { describe, expect, it } from "vitest";
import resetClientCustomizationApproval from "../src/client-customization-review.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

describe("resetClientCustomizationApproval", () => {
  it.each([
    ["keeps approval when the PR diff is unchanged", "+a", "none"],
    ["removes approval when the PR diff changes", "+b", "remove"],
  ])("%s", async (_, afterPatch, expected) => {
    const github = createMockGithub();
    github.rest.repos.compareCommitsWithBasehead.mockImplementation(
      ({ basehead }: { basehead: string }) =>
        Promise.resolve({
          data: {
            files: [
              {
                filename: "client.tsp",
                status: "modified",
                patch: basehead.endsWith("old") ? "+a" : afterPatch,
              },
            ],
          },
        }),
    );
    const context = createMockContext();
    context.payload = {
      before: "old",
      after: "new",
      pull_request: {
        number: 1,
        base: { sha: "base" },
        labels: [{ name: "client-customization-approved" }],
      },
    };

    expect(
      await resetClientCustomizationApproval({ github, context, core: createMockCore() }),
    ).toBe(expected);
  });
});
