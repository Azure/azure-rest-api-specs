import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

import assignReviewers, {
  REVIEWER_TEAM,
  SIGNOFF_LABEL,
  TRIGGER_LABEL,
} from "../../src/data-plane-review/assign-reviewers.ts";

/** A durable `review_requested` timeline event for our team, as GitHub records it. */
const teamRequestedEvent = {
  event: "review_requested",
  requested_team: { slug: REVIEWER_TEAM },
};

/**
 * Set the issue events returned by the durable `listEvents` read used to dedupe the team
 * request. GitHub records a `review_requested` event when the team is requested, and it
 * survives delegation swapping the team for an individual.
 */
function setTimelineEvents(github: ReturnType<typeof createMockGithub>, events: object[]) {
  (github.rest.issues as Record<string, unknown>).listEvents = vi
    .fn()
    .mockResolvedValue({ data: events });
}

function createPayload({
  action,
  labelName,
  author = "some-author",
  requestedTeams = [],
  labels = [],
  sender = "some-actor",
}: {
  action: string;
  labelName: string;
  author?: string;
  requestedTeams?: { slug: string }[];
  labels?: { name: string }[];
  sender?: string;
}) {
  return {
    action,
    label: { name: labelName },
    sender: { login: sender, type: "User" },
    repository: { owner: { login: "owner" }, name: "repo" },
    pull_request: {
      number: 42,
      head: { sha: "abc123" },
      user: { login: author },
      requested_teams: requestedTeams,
      labels,
    },
  };
}

/**
 * Build a `workflow_run: completed` payload for the "Summarize Checks" handoff. The
 * `workflow_run.event` is `pull_request_target`, so extractInputs resolves the PR number
 * directly from `pull_requests` without any API call.
 */
function createWorkflowRunPayload({ prNumber = 42 }: { prNumber?: number } = {}) {
  return {
    action: "completed",
    workflow_run: {
      event: "pull_request_target",
      head_sha: "abc123",
      id: 999,
      repository: { owner: { login: "owner" }, name: "repo", id: 1 },
      head_repository: { owner: { login: "owner" }, name: "repo", id: 1 },
      pull_requests: [{ number: prNumber, base: { repo: { id: 1 } } }],
    },
  };
}

/**
 * Set the PR returned by the live `pulls.get` read used by the workflow_run handoff.
 */
function setPullRequest(
  github: ReturnType<typeof createMockGithub>,
  {
    state = "open",
    draft = false,
    labels = [],
    requestedTeams = [],
  }: { state?: string; draft?: boolean; labels?: string[]; requestedTeams?: { slug: string }[] },
) {
  (github.rest.pulls as Record<string, unknown>).get = vi.fn().mockResolvedValue({
    data: {
      state,
      draft,
      labels: labels.map((name) => ({ name })),
      requested_teams: requestedTeams,
    },
  });
}

describe("assign-reviewers", () => {
  let github: ReturnType<typeof createMockGithub>;

  let context: ReturnType<typeof createMockContext>;

  let core: ReturnType<typeof createMockCore>;

  function args(): import("../../src/github.ts").WorkflowArguments {
    return {
      github,
      context,
      core,
    };
  }

  beforeEach(() => {
    vi.clearAllMocks();
    github = createMockGithub();
    context = createMockContext();
    context.eventName = "pull_request_target";
    core = createMockCore();

    // Method not present on the shared mock.
    (github.rest.pulls as Record<string, unknown>).requestReviewers = vi.fn().mockResolvedValue({});
  });

  it("ignores labels other than the trigger label", async () => {
    context.payload = createPayload({ action: "labeled", labelName: "some-other-label" });
    await assignReviewers(args());

    expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
  });

  it("requests the reviewer team on labeled", async () => {
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    await assignReviewers(args());

    expect(github.rest.pulls.requestReviewers).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "owner",
        repo: "repo",
        pull_number: 42,
        team_reviewers: [REVIEWER_TEAM],
      }),
    );
    // The team request is the notification; no bot comment is posted.
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("does not re-request the team when it was already requested (timeline event present)", async () => {
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    setTimelineEvents(github, [teamRequestedEvent]);
    await assignReviewers(args());

    expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
  });

  it("does not re-request after delegation swapped the team for an individual", async () => {
    // The team is no longer in requested_teams (delegation removed it), but the durable
    // review_requested timeline event remains, so we must not re-request.
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    setTimelineEvents(github, [
      teamRequestedEvent,
      { event: "review_request_removed", requested_team: { slug: REVIEWER_TEAM } },
    ]);
    await assignReviewers(args());

    expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
  });

  it("requests the team when only unrelated reviewers are on the PR", async () => {
    // A review_requested event for a different team/user must not be mistaken for our handoff.
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    setTimelineEvents(github, [
      { event: "review_requested", requested_team: { slug: "some-other-team" } },
      { event: "review_requested", requested_reviewer: { login: "someone" } },
    ]);
    await assignReviewers(args());

    expect(github.rest.pulls.requestReviewers).toHaveBeenCalledWith(
      expect.objectContaining({ team_reviewers: [REVIEWER_TEAM] }),
    );
  });

  describe("workflow_run handoff", () => {
    beforeEach(() => {
      context.eventName = "workflow_run";
    });

    it("requests the reviewer team when the request label is present and not signed off", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { labels: [TRIGGER_LABEL, "data-plane"] });

      await assignReviewers(args());

      expect(github.rest.pulls.requestReviewers).toHaveBeenCalledWith(
        expect.objectContaining({
          owner: "owner",
          repo: "repo",
          pull_number: 42,
          team_reviewers: [REVIEWER_TEAM],
        }),
      );
    });

    it("does not request the team when the request label is absent", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { labels: ["data-plane"] });

      await assignReviewers(args());

      expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
    });

    it("does not request the team when the PR is already signed off", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { labels: [TRIGGER_LABEL, SIGNOFF_LABEL] });

      await assignReviewers(args());

      expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
    });

    it("does not re-request the team when it was already requested (timeline event present)", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { labels: [TRIGGER_LABEL] });
      setTimelineEvents(github, [teamRequestedEvent]);

      await assignReviewers(args());

      expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
    });

    it("does not request the team on a draft PR", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { draft: true, labels: [TRIGGER_LABEL] });

      await assignReviewers(args());

      expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
    });

    it("does not request the team on a closed PR", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { state: "closed", labels: [TRIGGER_LABEL] });

      await assignReviewers(args());

      expect(github.rest.pulls.requestReviewers).not.toHaveBeenCalled();
    });
  });
});
