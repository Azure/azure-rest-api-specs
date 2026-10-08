import { describe, expect, it, vi } from "vitest";
import type { RestEndpointMethodTypes } from "../src/github.ts";
import {
  checkOwnershipApproval,
  evaluateOwnershipApproval,
  parseOwnershipPolicy,
  renderOwnershipApproval,
  type OwnershipPolicy,
} from "../src/ownership-approval.ts";
import {
  createMockContext,
  createMockCore,
  createMockGithub,
  createMockRequestError,
} from "./mocks.ts";

const head = "a".repeat(40);
const base = "b".repeat(40);
const policy: OwnershipPolicy = {
  maintainers: "@Azure/maintainers",
  "client-team": "@Azure/clients",
};
const codeowners = `
* @Azure/maintainers
/specification/
/specification/storage/ @storage-owner
/specification/compute/ @compute-owner
`;
const storage = "specification/storage/Storage/main.tsp";
const compute = "specification/compute/Compute/main.tsp";
const storageClient = "specification/storage/Storage/client.tsp";
const computeClient = "specification/compute/client.tsp";

function membership() {
  return vi.fn((team: string, username: string) => {
    return Promise.resolve(
      (team.toLowerCase() === "@azure/maintainers" && username === "maintainer") ||
        (team === "@Azure/clients" && username === "client-owner") ||
        (team === "@Azure/storage" && username === "storage-owner"),
    );
  });
}

function review(login: string, id = 2, state = "APPROVED", commit_id = head) {
  return { id, state, commit_id, user: { id, login, type: "User" } };
}

function setup() {
  const github = createMockGithub();
  const core = createMockCore();
  const context = createMockContext();
  context.repo.owner = "Azure";
  context.repo.repo = "example";
  const pr = {
    number: 1,
    state: "open",
    changed_files: 1,
    user: { id: 1, login: "author", type: "User" },
    head: { sha: head },
    base: { sha: base, ref: "main", repo: { id: 100 } },
  };
  github.rest.pulls.get.mockResolvedValue({ data: pr });
  const listFiles = vi.fn().mockResolvedValue({
    data: [{ filename: storage, status: "modified" }],
  });
  const listReviews = vi.fn().mockResolvedValue({ data: [review("storage-owner")] });
  const getContent = vi.fn(({ path }: { path: string }) =>
    Promise.resolve({
      data: {
        type: "file",
        encoding: "base64",
        content: Buffer.from(
          path === ".github/CODEOWNERS"
            ? codeowners
            : 'maintainers: "@Azure/maintainers"\nclient-team: "@Azure/clients"',
        ).toString("base64"),
      },
    }),
  );
  const permission = vi.fn().mockResolvedValue({ data: { permission: "write" } });
  const getTeam = vi.fn().mockResolvedValue({ data: {} });
  const member = membership();
  const getMembership = vi.fn(
    async ({ org, team_slug, username }: { org: string; team_slug: string; username: string }) => {
      if (await member(`@${org}/${team_slug}`, username)) return { data: { state: "active" } };
      throw createMockRequestError(404);
    },
  );
  const associated = vi.fn().mockResolvedValue({ data: [] });
  const createCheck = vi.fn().mockResolvedValue({ data: { id: 123 } });
  const updateCheck = vi
    .fn<(params: RestEndpointMethodTypes["checks"]["update"]["parameters"]) => Promise<void>>()
    .mockResolvedValue(undefined);
  Object.assign(github.rest.pulls, { listFiles, listReviews });
  Object.assign(github.rest.repos, {
    getContent,
    getCollaboratorPermissionLevel: permission,
    listPullRequestsAssociatedWithCommit: associated,
  });
  Object.assign(github.rest, {
    teams: { getByName: getTeam, getMembershipForUserInOrg: getMembership },
  });
  Object.assign(github.rest.checks, { create: createCheck, update: updateCheck });
  return {
    github,
    core,
    context,
    pr,
    listFiles,
    listReviews,
    getContent,
    permission,
    getTeam,
    getMembership,
    associated,
    createCheck,
    updateCheck,
    run: () => checkOwnershipApproval({ github, context, core }, 1),
  };
}

describe("ownership approval policy", () => {
  it("keeps a not-yet-configured client team disabled and rejects malformed authority", () => {
    expect(parseOwnershipPolicy('maintainers: "@Azure/maintainers"\nclient-team: null')).toEqual({
      maintainers: "@Azure/maintainers",
      "client-team": null,
    });
    expect(() => parseOwnershipPolicy('maintainers: "@individual"\nclient-team: null')).toThrow();
    expect(() =>
      parseOwnershipPolicy('maintainers: "@Azure/maintainers"\nclientTeam: null'),
    ).toThrow();
  });

  it("accepts a service owner's approval only for that service, including its client file", async () => {
    const result = await evaluateOwnershipApproval(
      [storage, storageClient, compute],
      codeowners,
      policy,
      ["storage-owner"],
      membership(),
    );
    expect(result.missing).toEqual([{ path: compute, owners: ["@compute-owner"] }]);
    const report = renderOwnershipApproval(result);
    expect(report).toContain("@compute-owner");
    expect(report).not.toContain("@Azure/maintainers");
    expect(report).not.toContain("@Azure/clients");
  });

  it("allows client-team review across services without authorizing other spec or engineering files", async () => {
    const result = await evaluateOwnershipApproval(
      [storageClient, computeClient, compute, "eng/tool.ts", ".github/CODEOWNERS"],
      codeowners,
      policy,
      ["client-owner"],
      membership(),
    );
    expect(result.missing.map(({ path }) => path)).toEqual([
      compute,
      "eng/tool.ts",
      ".github/CODEOWNERS",
    ]);
  });

  it("does not extend the client exception outside a service's specification directory", async () => {
    const result = await evaluateOwnershipApproval(
      ["client.tsp", "specification/client.tsp", "dev/service/client.tsp"],
      codeowners,
      policy,
      ["client-owner"],
      membership(),
    );
    expect(result.missing).toHaveLength(3);
  });

  it("requires the primary owner when the client team has not been configured", async () => {
    const result = await evaluateOwnershipApproval(
      [storageClient],
      codeowners,
      { ...policy, "client-team": null },
      ["client-owner"],
      membership(),
    );
    expect(result.missing).toEqual([{ path: storageClient, owners: ["@storage-owner"] }]);
  });

  it("accepts maintainer approval for all areas without advertising the fallback", async () => {
    const member = membership();
    const result = await evaluateOwnershipApproval(
      [storage, computeClient, "eng/tool.ts", ".github/ownership-approval.yml"],
      codeowners,
      policy,
      ["maintainer"],
      member,
    );
    expect(result.missing).toEqual([]);
    expect(renderOwnershipApproval(result)).toBe(
      "All changed files have an authorized approval for the current PR head.",
    );
    expect(member).toHaveBeenCalledTimes(1);
  });

  it("does not let historical tooling owners approve maintainer-only engineering files", async () => {
    const result = await evaluateOwnershipApproval(
      ["eng/tool.ts", ".github/workflows/tool.yaml"],
      codeowners + "\n/eng/ @tooling-owner\n/.github/ @tooling-owner",
      policy,
      ["tooling-owner"],
      membership(),
    );
    expect(result.missing).toEqual([
      { path: "eng/tool.ts", owners: ["@Azure/maintainers"] },
      { path: ".github/workflows/tool.yaml", owners: ["@Azure/maintainers"] },
    ]);
  });

  it("combines path-scoped approvals from service owners and the client team", async () => {
    const result = await evaluateOwnershipApproval(
      [storage, computeClient],
      codeowners,
      policy,
      ["storage-owner", "client-owner"],
      membership(),
    );
    expect(result.missing).toEqual([]);
  });

  it("uses last-match ownership and matches paths case-sensitively, but usernames case-insensitively", async () => {
    const result = await evaluateOwnershipApproval(
      [storage, "specification/Storage/Storage/main.tsp"],
      codeowners + "\n/specification/storage/Storage/ @Specialist",
      policy,
      ["specialist", "storage-owner"],
      membership(),
    );
    expect(result.missing).toEqual([
      { path: "specification/Storage/Storage/main.tsp", owners: [] },
    ]);
  });

  it("resolves team-based primary owners without making them global approvers", async () => {
    const result = await evaluateOwnershipApproval(
      [storage, compute],
      codeowners + "\n/specification/storage/ @Azure/storage",
      policy,
      ["storage-owner"],
      membership(),
    );
    expect(result.missing).toEqual([{ path: compute, owners: ["@compute-owner"] }]);
  });

  it("fails closed for unowned paths and unsupported CODEOWNERS entries", async () => {
    const result = await evaluateOwnershipApproval(
      ["specification/unlisted/main.tsp"],
      codeowners,
      policy,
      ["unrelated-reviewer"],
      membership(),
    );
    expect(result.missing[0].owners).toEqual([]);
    expect(renderOwnershipApproval(result)).toContain("No primary owner configured");
    await expect(
      evaluateOwnershipApproval(
        [storage],
        "/specification/[storage]/ @storage-owner",
        policy,
        ["storage-owner"],
        membership(),
      ),
    ).rejects.toThrow("Unsupported CODEOWNERS");
  });
});

describe("trusted ownership evaluation", () => {
  it("uses base-branch policy and current reviews, publishing a check on the actual PR head", async () => {
    const f = setup();
    await f.run();
    expect(f.getContent.mock.calls).toEqual([
      [{ owner: "Azure", repo: "example", ref: base, path: ".github/CODEOWNERS" }],
      [{ owner: "Azure", repo: "example", ref: base, path: ".github/ownership-approval.yml" }],
    ]);
    expect(f.createCheck).toHaveBeenCalledWith(
      expect.objectContaining({
        name: "Ownership approval",
        head_sha: head,
        status: "in_progress",
      }),
    );
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ check_run_id: 123, conclusion: "success" }),
    );
    expect(f.core.setFailed).not.toHaveBeenCalled();
  });

  it("rejects self-approval, bot approval, and approval of an older head", async () => {
    const f = setup();
    f.listReviews.mockResolvedValue({
      data: [
        review("author", 1),
        { ...review("storage-owner", 2), user: { id: 2, login: "storage-owner", type: "Bot" } },
        review("storage-owner", 3, "APPROVED", base),
      ],
    });
    await f.run();
    expect(f.permission).not.toHaveBeenCalled();
    expect(f.getMembership).not.toHaveBeenCalled();
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "failure" }),
    );
  });

  it.each(["DISMISSED", "CHANGES_REQUESTED"])(
    "does not reuse an approval superseded by %s",
    async (state) => {
      const f = setup();
      const approved = review("storage-owner", 2);
      f.listReviews.mockResolvedValue({
        data: [approved, { ...approved, id: 3, state }],
      });
      await f.run();
      expect(f.permission).not.toHaveBeenCalled();
      expect(f.core.setFailed).toHaveBeenCalledWith("Awaiting primary-owner approval.");
    },
  );

  it("does not revoke an approval merely because its reviewer later leaves a comment", async () => {
    const f = setup();
    const approved = review("storage-owner", 2);
    f.listReviews.mockResolvedValue({
      data: [approved, { ...approved, id: 3, state: "COMMENTED" }],
    });
    await f.run();
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "success" }),
    );
  });

  it("requires repository write access even from a named service owner", async () => {
    const f = setup();
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    expect(f.getMembership).not.toHaveBeenCalled();
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "failure" }),
    );
  });

  it("requires approval for the old path when a non-client file is renamed to client.tsp", async () => {
    const f = setup();
    f.listFiles.mockResolvedValue({
      data: [{ filename: storageClient, previous_filename: storage, status: "renamed" }],
    });
    f.listReviews.mockResolvedValue({ data: [review("client-owner")] });
    await f.run();
    const output = f.updateCheck.mock.calls.at(-1)?.[0].output;
    expect(output?.summary).toContain(storage);
    expect(output?.summary).not.toContain(`\`${storageClient}\``);
    expect(output?.summary).not.toContain("@Azure/clients");
    expect(f.getTeam).toHaveBeenCalledTimes(2);
    expect(f.getMembership).toHaveBeenCalledTimes(2);
  });

  it("does not treat pending team membership as authorization", async () => {
    const f = setup();
    f.listReviews.mockResolvedValue({ data: [review("maintainer")] });
    f.getMembership.mockResolvedValue({ data: { state: "pending" } });
    await f.run();
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "failure" }),
    );
  });

  it("requires maintainer approval for an engineering deletion, including on refresh", async () => {
    const f = setup();
    f.listFiles.mockResolvedValue({ data: [{ filename: "eng/tool.ts", status: "removed" }] });
    f.listReviews.mockResolvedValue({ data: [review("client-owner")] });
    await f.run();
    expect(f.updateCheck.mock.calls.at(-1)?.[0].conclusion).toBe("failure");
    expect(f.updateCheck.mock.calls.at(-1)?.[0].output?.summary).toContain("eng/tool.ts");
    f.listReviews.mockResolvedValue({ data: [review("maintainer")] });
    await f.run();
    expect(f.updateCheck.mock.calls.at(-1)?.[0].conclusion).toBe("success");
  });

  it("fails explicitly when the app cannot resolve a configured team", async () => {
    const f = setup();
    f.getTeam.mockRejectedValue(createMockRequestError(404));
    await expect(f.run()).rejects.toThrow("404");
    expect(f.getMembership).not.toHaveBeenCalled();
    expect(f.updateCheck.mock.calls.at(-1)?.[0].conclusion).toBe("failure");
    expect(f.updateCheck.mock.calls.at(-1)?.[0].output?.title).toBe(
      "Unable to evaluate ownership approval",
    );
  });

  it("fails explicitly rather than approving when membership lookup is forbidden", async () => {
    const f = setup();
    f.getMembership.mockRejectedValue(createMockRequestError(403));
    await expect(f.run()).rejects.toThrow("403");
    expect(f.core.error).toHaveBeenCalled();
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "failure" }),
    );
  });

  it("rejects an incomplete changed-file list rather than approving the visible subset", async () => {
    const f = setup();
    f.pr.changed_files = 2;
    await expect(f.run()).rejects.toThrow("incomplete changed-file list");
    expect(f.permission).not.toHaveBeenCalled();
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "failure" }),
    );
  });

  it("does not publish stale success when a review is dismissed during evaluation", async () => {
    const f = setup();
    f.listReviews
      .mockResolvedValueOnce({ data: [review("storage-owner")] })
      .mockResolvedValueOnce({ data: [review("storage-owner", 2, "DISMISSED")] });
    await expect(f.run()).rejects.toThrow("PR or reviews changed");
    expect(f.updateCheck).toHaveBeenLastCalledWith(
      expect.objectContaining({ conclusion: "failure" }),
    );
  });

  it.each(["head", "base"] as const)(
    "does not publish success if the PR %s changes during evaluation",
    async (changed) => {
      const f = setup();
      f.github.rest.pulls.get.mockResolvedValueOnce({ data: f.pr }).mockResolvedValueOnce({
        data: { ...f.pr, [changed]: { ...f.pr[changed], sha: "c".repeat(40) } },
      });
      await expect(f.run()).rejects.toThrow("PR or reviews changed");
      expect(f.updateCheck).toHaveBeenLastCalledWith(
        expect.objectContaining({ conclusion: "failure" }),
      );
    },
  );

  it("rejects shared-head PRs whose commit-scoped check could authorize another author", async () => {
    const f = setup();
    f.associated.mockResolvedValue({ data: [{ ...f.pr, number: 2 }] });
    await expect(f.run()).rejects.toThrow("Multiple open PRs share this head and base");
  });

  it("does not write checks for closed PRs", async () => {
    const f = setup();
    f.pr.state = "closed";
    await f.run();
    expect(f.createCheck).not.toHaveBeenCalled();
  });
});
