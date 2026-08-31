import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.js";

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
}));
vi.mock("js-yaml", () => ({
  default: { load: vi.fn() },
}));

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import assignReviewers, {
  REVIEWER_TEAM,
  SIGNOFF_LABEL,
  TRIGGER_LABEL,
} from "../../src/data-plane-review/assign-reviewers.js";

/** Mock protected-labels config (as yaml.load would return). Gates the sign-off label. */
const protectedLabelsConfig = {
  "APIStewardshipBoard-SignedOff": ["username1", "username2"],
};

function setupConfigMock() {
  /** @type {ReturnType<typeof vi.fn>} */ (readFile).mockResolvedValue("yaml-content");
  /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue(protectedLabelsConfig);
}

/**
 * Set the labels returned by the live `listLabelsOnIssue` read (paginated). The sign-off path
 * reads labels live rather than from the cached event payload.
 *
 * @param {ReturnType<typeof createMockGithub>} github
 * @param {string[]} names
 */
function setLiveLabels(github, names) {
  /** @type {any} */ (github.rest.issues).listLabelsOnIssue = vi
    .fn()
    .mockResolvedValue({ data: names.map((name) => ({ name })) });
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
    setupConfigMock();
    github = createMockGithub();
    context = createMockContext();
    context.eventName = "pull_request_target";
    core = createMockCore();

    // Method not present on the shared mock.
    /** @type {any} */ (github.rest.pulls).requestReviewers = vi.fn().mockResolvedValue({});
  });

  it("ignores labels other than the trigger or sign-off label", async () => {
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

  it("does not re-request the team when it is already a requested reviewer", async () => {
    context.payload = createPayload({
      action: "labeled",
      labelName: TRIGGER_LABEL,
      requestedTeams: [{ slug: REVIEWER_TEAM }],
    });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
  });

  describe("sign-off", () => {
    it("clears the review-request label when the sign-off label is applied", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, TRIGGER_LABEL, "data-plane"]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({
          owner: "owner",
          repo: "repo",
          issue_number: 42,
          name: TRIGGER_LABEL,
        }),
      );
      // Sign-off syncs labels silently, matching the ARM sign-off flows — no comment.
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("reads the shared config only once while authorizing a sign-off", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, TRIGGER_LABEL]);

      await assignReviewers(args());

      expect(readFile).toHaveBeenCalledTimes(1);
    });

    it("does not request the team when signing off", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, TRIGGER_LABEL]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });

    it("is a no-op on sign-off when the review-request label is absent", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, "data-plane"]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("does not clear the request label when the sign-off was retracted before this ran", async () => {
      // The event fired on sign-off, but a live read shows it is already gone.
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
      });
      setLiveLabels(github, [TRIGGER_LABEL, "data-plane"]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("does not clear the request label when an unauthorized user applies sign-off", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "random-user",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, TRIGGER_LABEL]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).not.toHaveBeenCalled();
    });

    it("clears the request label when a trusted bot applies sign-off", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "azure-sdk",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, TRIGGER_LABEL]);

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: TRIGGER_LABEL }),
      );
    });

    it("does not fail when the label was already removed (404)", async () => {
      /** @type {any} */ (github.rest.issues).removeLabel = vi
        .fn()
        .mockRejectedValue(Object.assign(new Error("Not Found"), { status: 404 }));
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
      });
      setLiveLabels(github, [SIGNOFF_LABEL, TRIGGER_LABEL]);

      await expect(assignReviewers(args())).resolves.toBeUndefined();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });
  });
});
