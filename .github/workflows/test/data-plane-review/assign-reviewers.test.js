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
  loadReviewerPool,
  SIGNOFF_LABEL,
  TRIGGER_LABEL,
} from "../../src/data-plane-review/assign-reviewers.js";

/** Mock protected-labels config (as yaml.load would return). The pool = sign-off list. */
const protectedLabelsConfig = {
  "APIStewardshipBoard-SignedOff": ["username1", "username2"],
};

function setupConfigMock() {
  /** @type {ReturnType<typeof vi.fn>} */ (readFile).mockResolvedValue("yaml-content");
  /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue(protectedLabelsConfig);
}

/**
 * @param {object} opts
 * @param {string} opts.action - "labeled" | "unlabeled"
 * @param {string} opts.labelName
 * @param {string} [opts.author]
 * @param {{ login: string }[]} [opts.requestedReviewers]
 * @param {{ login: string }[]} [opts.assignees]
 * @param {{ name: string }[]} [opts.labels] - labels currently on the PR
 * @param {string} [opts.sender] - login of the actor that triggered the event
 */
function createPayload({
  action,
  labelName,
  author = "some-author",
  requestedReviewers = [],
  assignees = [],
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
      requested_reviewers: requestedReviewers,
      assignees,
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

    // Methods not present on the shared mock.
    /** @type {any} */ (github.rest.pulls).requestReviewers = vi.fn().mockResolvedValue({});
    /** @type {any} */ (github.rest.pulls).removeRequestedReviewers = vi.fn().mockResolvedValue({});
    /** @type {any} */ (github.rest.issues).addAssignees = vi.fn().mockResolvedValue({});
    /** @type {any} */ (github.rest.issues).removeAssignees = vi.fn().mockResolvedValue({});
    /** @type {any} */ (github.rest.pulls).get = vi
      .fn()
      .mockResolvedValue({ data: { requested_reviewers: [], assignees: [] } });

    // The dispatcher re-reads the current labels before it assigns or removes the pool;
    // default to the trigger label being present so assign-path tests exercise assignment.
    /** @type {any} */ (github.rest.issues).listLabelsOnIssue = vi
      .fn()
      .mockResolvedValue({ data: [{ name: TRIGGER_LABEL }] });
  });

  describe("loadReviewerPool", () => {
    it("returns a deduplicated, trimmed list of logins", async () => {
      /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue({
        "APIStewardshipBoard-SignedOff": ["username1", " username1 ", "username2", "", 123],
      });
      const pool = await loadReviewerPool();
      expect(pool).toEqual(["username1", "username2"]);
    });

    it("flattens a plane-aware entry", async () => {
      /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue({
        "APIStewardshipBoard-SignedOff": {
          "management-plane": ["mgmt-reviewer"],
          "data-plane": ["username1", "username2"],
        },
      });
      const pool = await loadReviewerPool();
      expect(pool).toEqual(["mgmt-reviewer", "username1", "username2"]);
    });

    it("returns [] when the pool label is absent", async () => {
      /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue({});
      expect(await loadReviewerPool()).toEqual([]);
    });
  });

  it("ignores labels other than the trigger label", async () => {
    context.payload = createPayload({ action: "labeled", labelName: "some-other-label" });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    expect(/** @type {any} */ (github.rest.issues).addAssignees).not.toHaveBeenCalled();
  });

  it("warns and stops when the reviewer pool is empty", async () => {
    /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue({});
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });

    await assignReviewers(args());

    expect(core.warning).toHaveBeenCalledWith(
      expect.stringContaining("APIStewardshipBoard-SignedOff"),
    );
    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
  });

  it("requests and assigns the full pool on labeled", async () => {
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "owner",
        repo: "repo",
        pull_number: 42,
        reviewers: ["username1", "username2"],
      }),
    );
    expect(/** @type {any} */ (github.rest.issues).addAssignees).toHaveBeenCalledWith(
      expect.objectContaining({
        issue_number: 42,
        assignees: ["username1", "username2"],
      }),
    );
    // The assignment/review-request is the notification; no bot comment is posted.
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("excludes the PR author from reviewers and assignees", async () => {
    context.payload = createPayload({
      action: "labeled",
      labelName: TRIGGER_LABEL,
      author: "Username1", // different casing on purpose
    });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalledWith(
      expect.objectContaining({ reviewers: ["username2"] }),
    );
    expect(/** @type {any} */ (github.rest.issues).addAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["username2"] }),
    );
  });

  it("does not re-request reviewers already requested", async () => {
    context.payload = createPayload({
      action: "labeled",
      labelName: TRIGGER_LABEL,
      requestedReviewers: [{ login: "username1" }],
    });
    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalledWith(
      expect.objectContaining({ reviewers: ["username2"] }),
    );
  });

  it("does not fail the run when requestReviewers throws (falls back to assignment)", async () => {
    /** @type {any} */ (github.rest.pulls).requestReviewers = vi
      .fn()
      .mockRejectedValue(new Error("Review cannot be requested from pull request author."));
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });

    await expect(assignReviewers(args())).resolves.toBeUndefined();
    expect(/** @type {any} */ (github.rest.issues).addAssignees).toHaveBeenCalled();
    expect(core.warning).toHaveBeenCalled();
  });

  it("removes only pool members on unlabeled", async () => {
    /** @type {any} */ (github.rest.issues).listLabelsOnIssue = vi
      .fn()
      .mockResolvedValue({ data: [] });
    /** @type {any} */ (github.rest.pulls).get = vi.fn().mockResolvedValue({
      data: {
        requested_reviewers: [{ login: "username1" }, { login: "outside-reviewer" }],
        assignees: [{ login: "username2" }, { login: "manual-assignee" }],
      },
    });
    context.payload = createPayload({ action: "unlabeled", labelName: TRIGGER_LABEL });

    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).removeRequestedReviewers).toHaveBeenCalledWith(
      expect.objectContaining({ reviewers: ["username1"] }),
    );
    expect(/** @type {any} */ (github.rest.issues).removeAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["username2"] }),
    );
  });

  it("fails the run when adding assignees genuinely errors", async () => {
    /** @type {any} */ (github.rest.issues).addAssignees = vi
      .fn()
      .mockRejectedValue(new Error("API is down"));
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });

    await expect(assignReviewers(args())).rejects.toThrow("API is down");
    expect(core.error).toHaveBeenCalled();
  });

  it("fails the run when cleanup removal errors so it can be retried", async () => {
    /** @type {any} */ (github.rest.issues).listLabelsOnIssue = vi
      .fn()
      .mockResolvedValue({ data: [] });
    /** @type {any} */ (github.rest.pulls).get = vi.fn().mockResolvedValue({
      data: {
        requested_reviewers: [{ login: "username1" }],
        assignees: [{ login: "username2" }],
      },
    });
    /** @type {any} */ (github.rest.issues).removeAssignees = vi
      .fn()
      .mockRejectedValue(new Error("API is down"));
    context.payload = createPayload({ action: "unlabeled", labelName: TRIGGER_LABEL });

    await expect(assignReviewers(args())).rejects.toThrow(/clean up/i);
  });

  it("reconciles to the current label set, removing the pool when a labeled event is stale", async () => {
    // A labeled event arrives, but the trigger label has since been removed.
    /** @type {any} */ (github.rest.issues).listLabelsOnIssue = vi
      .fn()
      .mockResolvedValue({ data: [] });
    /** @type {any} */ (github.rest.pulls).get = vi.fn().mockResolvedValue({
      data: { requested_reviewers: [{ login: "username1" }], assignees: [] },
    });
    context.payload = createPayload({ action: "labeled", labelName: TRIGGER_LABEL });

    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    expect(/** @type {any} */ (github.rest.pulls).removeRequestedReviewers).toHaveBeenCalled();
  });

  it("reconciles to the current label set, assigning when an unlabeled event is stale", async () => {
    // An unlabeled event arrives, but the trigger label is present again.
    context.payload = createPayload({ action: "unlabeled", labelName: TRIGGER_LABEL });

    await assignReviewers(args());

    expect(/** @type {any} */ (github.rest.pulls).requestReviewers).toHaveBeenCalled();
    expect(/** @type {any} */ (github.rest.pulls).removeRequestedReviewers).not.toHaveBeenCalled();
  });

  describe("sign-off", () => {
    it("clears the review-request label when the sign-off label is applied", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
        labels: [{ name: TRIGGER_LABEL }, { name: "data-plane" }],
      });

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
        labels: [{ name: TRIGGER_LABEL }],
      });

      await assignReviewers(args());

      expect(readFile).toHaveBeenCalledTimes(1);
    });

    it("does not unassign reviewers when signing off (lingering reviewer is acceptable)", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
        labels: [{ name: TRIGGER_LABEL }],
      });

      await assignReviewers(args());

      expect(
        /** @type {any} */ (github.rest.pulls).removeRequestedReviewers,
      ).not.toHaveBeenCalled();
      expect(/** @type {any} */ (github.rest.issues).removeAssignees).not.toHaveBeenCalled();
    });

    it("is a no-op on sign-off when the review-request label is absent", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
        labels: [{ name: "data-plane" }],
      });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("does not clear the request label when an unauthorized user applies sign-off", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "random-user",
        labels: [{ name: TRIGGER_LABEL }],
      });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).not.toHaveBeenCalled();
    });

    it("clears the request label when a trusted bot applies sign-off", async () => {
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "azure-sdk",
        labels: [{ name: TRIGGER_LABEL }],
      });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: TRIGGER_LABEL }),
      );
    });

    it("ignores the sign-off label being removed (unlabeled)", async () => {
      context.payload = createPayload({
        action: "unlabeled",
        labelName: SIGNOFF_LABEL,
        labels: [{ name: TRIGGER_LABEL }],
      });

      await assignReviewers(args());

      expect(/** @type {any} */ (github.rest.issues).removeLabel).not.toHaveBeenCalled();
      expect(/** @type {any} */ (github.rest.pulls).requestReviewers).not.toHaveBeenCalled();
    });

    it("does not fail when the label was already removed (404)", async () => {
      /** @type {any} */ (github.rest.issues).removeLabel = vi
        .fn()
        .mockRejectedValue(Object.assign(new Error("Not Found"), { status: 404 }));
      context.payload = createPayload({
        action: "labeled",
        labelName: SIGNOFF_LABEL,
        sender: "username1",
        labels: [{ name: TRIGGER_LABEL }],
      });

      await expect(assignReviewers(args())).resolves.toBeUndefined();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });
  });
});
