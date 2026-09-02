import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.js";

import assignReviewers, {
  REVIEWER_TEAM,
  SIGNOFF_LABEL,
  TRIGGER_LABEL,
} from "../../src/data-plane-review/assign-reviewers.js";

/** A durable `review_requested` timeline event for our team, as GitHub records it. */
const teamRequestedEvent = {
  event: "review_requested",
  requested_team: { slug: REVIEWER_TEAM },
};

/**
 * Set the issue events returned by the durable `listEvents` read used to dedupe the team
 * request. GitHub records a `review_requested` event when the team is requested, and it
 * survives delegation swapping the team for an individual.
 *
 * @param {ReturnType<typeof createMockGithub>} github
 * @param {object[]} events
 */
function setTimelineEvents(github, events) {
  /** @type {any} */ (github.rest.issues).listEvents = vi.fn().mockResolvedValue({ data: events });
}

/**
 * @param {object} opts
 * @param {string} opts.action - "labeled" | "unlabeled"
 * @param {string} opts.labelName
 * @param {string} [opts.author]
 * @param {{ slug: string }[]} [opts.requestedTeams] - teams currently requested on the PR
 * @param {{ name: string }[]} [opts.labels] - labels currently on the PR
 * @param {string} [opts.sender] - login of the actor that triggered the event
 */
function createPayload({
  action,
  labelName,
  author = "some-author",
  requestedTeams = [],
  labels = [],
  sender = "some-actor",
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
 *
 * @param {object} [opts]
 * @param {number} [opts.prNumber]
 */
function createWorkflowRunPayload({ prNumber = 42 } = {}) {
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
 *
 * @param {ReturnType<typeof createMockGithub>} github
 * @param {object} pr
 * @param {string} [pr.state]
 * @param {boolean} [pr.draft]
 * @param {string[]} [pr.labels]
 * @param {{ slug: string }[]} [pr.requestedTeams]
 */
function setPullRequest(
  github,
  { state = "open", draft = false, labels = [], requestedTeams = [] },
) {
  /** @type {any} */ (github.rest.pulls).get = vi.fn().mockResolvedValue({
    data: {
      state,
      draft,
      labels: labels.map((name) => ({ name })),
      requested_teams: requestedTeams,
    },
  });
}

describe("assign-reviewers", () => {
  /** @type {ReturnType<typeof createMockGithub>} */
  let github;
  /** @type {ReturnType<typeof createMockContext>} */
  let context;
  /** @type {ReturnType<typeof createMockCore>} */
  let core;

  /** @returns {import("@actions/github-script").AsyncFunctionArguments} */
  function args() {
    return /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (
      /** @type {unknown} */ ({ github, context, core })
    );
  }

  beforeEach(() => {
    vi.clearAllMocks();
    github = createMockGithub();
    context = createMockContext();
    context.eventName = "pull_request_target";
    core = createMockCore();

    // Method not present on the shared mock.
    /** @type {any} */ (github.rest.pulls).requestReviewers = vi.fn().mockResolvedValue({});
  });

  it("ignores labels other than the trigger label", async () => {
    context.payload = createPayload({ action: "labeled", labelName: "some-other-label" });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
  });

  it("requests the reviewer team on labeled", async () => {
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalledWith(
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

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
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

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
  });

  it("requests the team when only unrelated reviewers are on the PR", async () => {
    // A review_requested event for a different team/user must not be mistaken for our handoff.
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    setTimelineEvents(github, [
      { event: "review_requested", requested_team: { slug: "some-other-team" } },
      { event: "review_requested", requested_reviewer: { login: "someone" } },
    ]);
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalledWith(
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

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalledWith(
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

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });

    it("does not request the team when the PR is already signed off", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { labels: [TRIGGER_LABEL, SIGNOFF_LABEL] });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });

    it("does not re-request the team when it was already requested (timeline event present)", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { labels: [TRIGGER_LABEL] });
      setTimelineEvents(github, [teamRequestedEvent]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });

    it("does not request the team on a draft PR", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { draft: true, labels: [TRIGGER_LABEL] });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });

    it("does not request the team on a closed PR", async () => {
      context.payload = createWorkflowRunPayload();
      setPullRequest(github, { state: "closed", labels: [TRIGGER_LABEL] });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });
  });
});
