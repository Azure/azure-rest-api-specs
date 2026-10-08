import ignore from "ignore";
import { parse } from "yaml";
import { z } from "zod";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { inlineCode, table } from "../../shared/src/markdown.ts";
import type { Core, GitHub, GitHubScriptArgs, RestEndpointMethodTypes } from "./github.ts";

const CHECK_NAME = "Ownership approval";
const POLICY_PATH = ".github/ownership-approval.yml";
const teamName = z.string().regex(/^@[\w-]+\/[\w.-]+$/);
const policySchema = z
  .object({
    maintainers: teamName,
    "client-team": teamName.nullable(),
  })
  .strict();

export type OwnershipPolicy = z.infer<typeof policySchema>;
type Reviews = RestEndpointMethodTypes["pulls"]["listReviews"]["response"]["data"];
type MissingApproval = { path: string; owners: string[] };
export type OwnershipResult = { missing: MissingApproval[] };
type TeamMembership = (team: string, username: string) => Promise<boolean>;

export function parseOwnershipPolicy(contents: string): OwnershipPolicy {
  return policySchema.parse(parse(contents));
}

function codeownerRules(contents: string) {
  return contents
    .split(/\r?\n/)
    .flatMap((line, index) => {
      const text = line.trim();
      if (!text || text.startsWith("#")) return [];
      const pattern = text.match(/^(?:\\.|[^\s])+/)?.[0];
      if (!pattern) throw new Error(`Missing CODEOWNERS pattern on line ${index + 1}`);
      const owners = text
        .slice(pattern.length)
        .split("#", 1)[0]
        .trim()
        .split(/\s+/)
        .filter(Boolean);
      if (
        pattern.startsWith("!") ||
        pattern.startsWith("\\#") ||
        pattern.includes("[") ||
        pattern.includes("]") ||
        owners.some((owner) => !/^@[\w-]+(?:\/[\w.-]+)?$/.test(owner))
      ) {
        throw new Error(`Unsupported CODEOWNERS entry on line ${index + 1}`);
      }
      return [{ owners, matches: ignore({ ignorecase: false }).add(pattern) }];
    })
    .reverse();
}

function engineeringFile(path: string): boolean {
  return path.startsWith("eng/") || path.startsWith(".github/");
}

export async function evaluateOwnershipApproval(
  files: string[],
  codeowners: string,
  policy: OwnershipPolicy,
  approvers: string[],
  isTeamMember: TeamMembership,
): Promise<OwnershipResult> {
  const rules = codeownerRules(codeowners);
  const membership = new Map<string, Promise<boolean>>();
  function member(team: string, username: string): Promise<boolean> {
    const key = `${team}:${username}`.toLowerCase();
    let result = membership.get(key);
    if (!result) {
      result = isTeamMember(team, username);
      membership.set(key, result);
    }
    return result;
  }
  async function approvedBy(owners: string[]): Promise<boolean> {
    for (const username of approvers) {
      for (const owner of owners) {
        if (
          owner.toLowerCase() === `@${username}`.toLowerCase() ||
          (owner.includes("/") && (await member(owner, username)))
        ) {
          return true;
        }
      }
    }
    return false;
  }
  const maintainerApproved = await approvedBy([policy.maintainers]);
  const missing: MissingApproval[] = [];
  for (const path of new Set(files)) {
    const owners = engineeringFile(path)
      ? [policy.maintainers]
      : (rules.find((rule) => rule.matches.ignores(path))?.owners ?? []);
    if (maintainerApproved) continue;
    if (engineeringFile(path)) {
      missing.push({ path, owners });
      continue;
    }
    if (await approvedBy(owners)) continue;
    if (
      policy["client-team"] &&
      /^specification\/[^/]+\/(?:.*\/)?client\.tsp$/.test(path) &&
      (await approvedBy([policy["client-team"]]))
    ) {
      continue;
    }
    missing.push({ path, owners });
  }
  return { missing };
}

function latestDecisions(reviews: Reviews): Reviews {
  const decisions = new Map<string, Reviews[number]>();
  for (const review of reviews) {
    if (!["APPROVED", "CHANGES_REQUESTED", "DISMISSED"].includes(review.state)) continue;
    if (!review.user) throw new Error("Cannot resolve an ownership review's author");
    const identity = String(review.user.id);
    if ((decisions.get(identity)?.id ?? -1) < review.id) {
      decisions.set(identity, review);
    }
  }
  return [...decisions.values()].sort((a, b) => (a.id < b.id ? -1 : a.id > b.id ? 1 : 0));
}

function decisionSnapshot(reviews: Reviews): string {
  return JSON.stringify(
    latestDecisions(reviews).map((review) => [
      String(review.id),
      String(review.user?.id),
      review.state,
      review.commit_id,
    ]),
  );
}

export function renderOwnershipApproval({ missing }: OwnershipResult): string {
  if (!missing.length) {
    return "All changed files have an authorized approval for the current PR head.";
  }
  const rows = missing
    .slice(0, 100)
    .map(({ path, owners }) => [
      inlineCode(path),
      owners.length
        ? owners.map(inlineCode).join(", ")
        : "No primary owner configured; update CODEOWNERS.",
    ]);
  return [
    "Request approval from the primary owners below. Approvals must cover the current PR head.",
    "",
    table([["File awaiting approval", "Primary owners"], ...rows]),
    ...(missing.length > rows.length
      ? ["", `${missing.length - rows.length} additional files await approval.`]
      : []),
  ].join("\n");
}

async function repositoryFile(
  github: GitHub,
  owner: string,
  repo: string,
  ref: string,
  path: string,
): Promise<string> {
  const { data } = await github.rest.repos.getContent({ owner, repo, ref, path });
  if (Array.isArray(data) || data.type !== "file" || data.encoding !== "base64") {
    throw new Error(`Cannot read trusted ${path}`);
  }
  return Buffer.from(data.content, "base64").toString("utf8");
}

function httpStatus(error: unknown): number | undefined {
  return error instanceof Error && "status" in error && typeof error.status === "number"
    ? error.status
    : undefined;
}

function liveTeamMembership(github: GitHub, core: Core): TeamMembership {
  const teams = new Map<string, Promise<unknown>>();
  return async (team, username) => {
    const [org, team_slug] = team.slice(1).split("/");
    let exists = teams.get(team.toLowerCase());
    if (!exists) {
      // A missing/inaccessible team is an evaluation error, not "not a member".
      exists = github.rest.teams.getByName({ org, team_slug });
      teams.set(team.toLowerCase(), exists);
    }
    await exists;
    try {
      const { data } = await github.rest.teams.getMembershipForUserInOrg({
        org,
        team_slug,
        username,
      });
      return data.state === "active";
    } catch (error) {
      if (httpStatus(error) !== 404) throw error;
      core.debug(`Review author is not a member of ${team}.`);
      return false;
    }
  };
}

export async function checkOwnershipApproval(
  { github, context, core }: GitHubScriptArgs,
  number: number,
): Promise<void> {
  if (!Number.isSafeInteger(number) || number <= 0) throw new Error("Invalid PR number");
  const { owner, repo } = context.repo;
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: number });
  if (pr.state !== "open") {
    core.info("Skipping ownership approval for a closed PR.");
    return;
  }
  const { data: check } = await github.rest.checks.create({
    owner,
    repo,
    name: CHECK_NAME,
    head_sha: pr.head.sha,
    external_id: `ownership-approval:${number}`,
    status: "in_progress",
    output: { title: "Evaluating ownership approvals", summary: "Reading current PR reviews." },
  });
  try {
    const [files, reviews, codeowners, policyContents, associated] = await Promise.all([
      github.paginate(github.rest.pulls.listFiles, {
        owner,
        repo,
        pull_number: number,
        per_page: PER_PAGE_MAX,
      }),
      github.paginate(github.rest.pulls.listReviews, {
        owner,
        repo,
        pull_number: number,
        per_page: PER_PAGE_MAX,
      }),
      repositoryFile(github, owner, repo, pr.base.sha, ".github/CODEOWNERS"),
      repositoryFile(github, owner, repo, pr.base.sha, POLICY_PATH),
      github.paginate(github.rest.repos.listPullRequestsAssociatedWithCommit, {
        owner,
        repo,
        commit_sha: pr.head.sha,
        per_page: PER_PAGE_MAX,
      }),
    ]);
    if (files.length !== pr.changed_files) {
      throw new Error("Cannot authorize an incomplete changed-file list");
    }
    if (
      associated.some(
        (other) =>
          other.state === "open" &&
          other.number !== number &&
          other.head.sha === pr.head.sha &&
          other.base.ref === pr.base.ref,
      )
    ) {
      throw new Error("Multiple open PRs share this head and base; use distinct head commits");
    }
    const policy = parseOwnershipPolicy(policyContents);
    if (!policy["client-team"]) {
      core.info("Client-team exception is not configured; primary-owner approval still applies.");
    }
    const approvers: string[] = [];
    for (const review of latestDecisions(reviews)) {
      if (
        review.state !== "APPROVED" ||
        review.commit_id !== pr.head.sha ||
        !review.user ||
        String(review.user.id) === String(pr.user.id) ||
        review.user.type !== "User"
      ) {
        continue;
      }
      const { data } = await github.rest.repos.getCollaboratorPermissionLevel({
        owner,
        repo,
        username: review.user.login,
      });
      if (["write", "maintain", "admin"].includes(data.permission)) {
        approvers.push(review.user.login);
      } else {
        core.info("Ignoring an approval without repository write access.");
      }
    }
    const result = await evaluateOwnershipApproval(
      files.flatMap((file) =>
        file.previous_filename ? [file.previous_filename, file.filename] : [file.filename],
      ),
      codeowners,
      policy,
      approvers,
      liveTeamMembership(github, core),
    );
    // Recheck mutable approval evidence before publishing success on the reviewed SHA.
    const [{ data: latest }, latestReviews] = await Promise.all([
      github.rest.pulls.get({ owner, repo, pull_number: number }),
      github.paginate(github.rest.pulls.listReviews, {
        owner,
        repo,
        pull_number: number,
        per_page: PER_PAGE_MAX,
      }),
    ]);
    if (
      latest.state !== "open" ||
      latest.head.sha !== pr.head.sha ||
      latest.base.sha !== pr.base.sha ||
      latest.base.ref !== pr.base.ref ||
      decisionSnapshot(latestReviews) !== decisionSnapshot(reviews)
    ) {
      throw new Error("PR or reviews changed during authorization; refresh ownership approval");
    }
    const summary = renderOwnershipApproval(result);
    await github.rest.checks.update({
      owner,
      repo,
      check_run_id: check.id,
      status: "completed",
      conclusion: result.missing.length ? "failure" : "success",
      output: {
        title: result.missing.length ? "Awaiting primary-owner approval" : "Ownership approved",
        summary,
      },
    });
    await core.summary.addRaw(`## ${CHECK_NAME}\n\n${summary}`).write();
    if (result.missing.length) core.setFailed("Awaiting primary-owner approval.");
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    core.error(message);
    await github.rest.checks.update({
      owner,
      repo,
      check_run_id: check.id,
      status: "completed",
      conclusion: "failure",
      output: {
        title: "Unable to evaluate ownership approval",
        summary: `Authorization could not be verified: ${inlineCode(message)}. Rerun the check.`,
      },
    });
    throw error;
  }
}
