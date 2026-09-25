import { describe, expect, it, vi } from "vitest";
import dumpTriggerMetadata from "../../src/summarize-checks/dump-trigger-metadata.ts";
import { createMockContext, createMockCore } from "../mocks.ts";

describe("dumpTriggerMetadata", () => {
  it.each([
    { pullRequests: [null, { number: 42 }, null], expectedNumbers: [42] },
    { pullRequests: [null], expectedNumbers: [] },
  ])("ignores null PR entries in $pullRequests", ({ pullRequests, expectedNumbers }) => {
    const context = createMockContext();
    const info = vi.fn<(message: string) => void>();
    const core = { ...createMockCore(), info };
    context.eventName = "workflow_run";
    context.payload = {
      action: "completed",
      workflow_run: {
        id: 123,
        pull_requests: pullRequests,
      },
    };

    dumpTriggerMetadata({ context, core });

    const pullRequestLogs = info.mock.calls
      .map(([message]) => message)
      .filter((message) => message.includes("/pull/"));
    expect(pullRequestLogs).toHaveLength(expectedNumbers.length);
    for (const number of expectedNumbers) {
      expect(pullRequestLogs).toContainEqual(
        expect.stringContaining(
          `https://github.com/${context.repo.owner}/${context.repo.repo}/pull/${number}`,
        ),
      );
    }
  });
});
