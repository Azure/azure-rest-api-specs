import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { SdkName } from "../../shared/src/sdk-types.ts";
import type { CheckRuns, GitHubScriptArgs, WebhookEvent } from "./github.ts";
import { nativeSdkChecks } from "./native-sdk-checks-config.ts";

export interface NativeSdkDefinition {
  name: string;
  definitionId: number;
  projectId: string;
}

export interface NativeSdkLanguage {
  language: SdkName;
  required: boolean;
  validation: NativeSdkDefinition;
  breakingChange?: {
    label: string;
    present: NativeSdkDefinition;
    absent: NativeSdkDefinition;
  };
}

type Check = Pick<
  CheckRuns[number],
  "id" | "head_sha" | "name" | "external_id" | "status" | "conclusion"
> & {
  app: { id: number | bigint; slug?: string } | null;
};

function nativeBuildId(check: Check, definition: NativeSdkDefinition): number | undefined {
  const parts = check.external_id?.split("|");
  if (
    check.app?.id !== 9426 ||
    check.app.slug !== "azure-pipelines" ||
    check.name !== definition.name ||
    parts?.length !== 3 ||
    parts[0] !== String(definition.definitionId) ||
    parts[2]?.toLowerCase() !== definition.projectId.toLowerCase() ||
    !/^[1-9]\d*$/.test(parts[1] ?? "")
  ) {
    return undefined;
  }
  const id = Number(parts[1]);
  return Number.isSafeInteger(id) ? id : undefined;
}

export function latestNativeCheck(
  checks: readonly Check[],
  definition: NativeSdkDefinition,
  headSha: string,
): Check | undefined {
  const candidates = checks.filter(
    (check) =>
      check.head_sha === headSha &&
      check.name === definition.name &&
      check.app?.id === 9426 &&
      check.app.slug === "azure-pipelines",
  );
  // An unrecognized attempt must not uncover a previous success.
  if (candidates.some((check) => nativeBuildId(check, definition) === undefined)) {
    return undefined;
  }
  candidates.sort(
    (a, b) =>
      nativeBuildId(b, definition)! - nativeBuildId(a, definition)! ||
      (b.id > a.id ? 1 : b.id < a.id ? -1 : 0),
  );
  const latest = candidates[0];
  if (latest && candidates[1]?.id === latest.id) return undefined;
  return latest;
}

export function nativeLabelAction(
  present: Check | undefined,
  absent: Check | undefined,
): "add" | "remove" | undefined {
  if (
    present?.status !== "completed" ||
    absent?.status !== "completed" ||
    !["success", "failure"].includes(present.conclusion ?? "") ||
    !["success", "failure"].includes(absent.conclusion ?? "")
  ) {
    return undefined;
  }
  const found = present.conclusion === "success";
  const clean = absent.conclusion === "success";
  return found === clean ? undefined : found ? "add" : "remove";
}

export async function reconcileNativeSdkChecks(
  { github, context, core }: GitHubScriptArgs,
  config: readonly NativeSdkLanguage[] = nativeSdkChecks,
): Promise<void> {
  const { owner, repo } = context.repo;
  if (owner !== "Azure" || repo !== "azure-rest-api-specs-pr") return;
  let headSha: string;
  let numbers: number[];
  if (context.eventName === "pull_request_target") {
    const { pull_request: pr } = context.payload as WebhookEvent<"pull-request">;
    if (!pr || typeof pr.head?.sha !== "string" || typeof pr.number !== "number") {
      throw new Error("Missing pull request head or number");
    }
    headSha = pr.head.sha;
    numbers = [pr.number];
  } else if (context.eventName === "check_run") {
    const { check_run: check } = context.payload as WebhookEvent<"check-run">;
    if (!check || typeof check.head_sha !== "string") {
      throw new Error("Missing native check head");
    }
    if (check.app?.id !== 9426 || check.app?.slug !== "azure-pipelines") return;
    if (
      config.length > 0 &&
      !config.some((entry) =>
        [entry.validation, entry.breakingChange?.present, entry.breakingChange?.absent].some(
          (definition) => definition?.name === check.name,
        ),
      )
    ) {
      return;
    }
    headSha = check.head_sha;
    const prs = await github.paginate(github.rest.repos.listPullRequestsAssociatedWithCommit, {
      owner,
      repo,
      commit_sha: headSha,
      per_page: PER_PAGE_MAX,
    });
    numbers = prs
      .filter((pr) => pr.base.repo.full_name === `${owner}/${repo}`)
      .map((pr) => pr.number);
  } else {
    throw new Error(`Unsupported native SDK event: ${context.eventName}`);
  }

  for (const number of numbers) {
    const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: number });
    if (pr.state !== "open" || pr.head.sha !== headSha) {
      core.info(`Ignoring stale SDK evidence for PR ${number}`);
      continue;
    }
    const checks = await github.paginate(github.rest.checks.listForRef, {
      owner,
      repo,
      ref: headSha,
      filter: "all",
      per_page: PER_PAGE_MAX,
    });
    const results = config.map((entry) => ({
      entry,
      validation: latestNativeCheck(checks, entry.validation, headSha),
      action: entry.breakingChange
        ? nativeLabelAction(
            latestNativeCheck(checks, entry.breakingChange.present, headSha),
            latestNativeCheck(checks, entry.breakingChange.absent, headSha),
          )
        : undefined,
    }));
    const required = results.filter(({ entry }) => entry.required);
    const failed = required.some(
      ({ validation }) => validation?.status === "completed" && validation.conclusion === "failure",
    );
    const passed =
      config.length > 0 &&
      required.every(
        ({ validation }) =>
          validation?.status === "completed" && validation.conclusion === "success",
      );
    if (!config.length) core.warning("Native SDK check definitions have not been provisioned");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: headSha,
      context: "SDK Validation Status",
      state: failed ? "failure" : passed ? "success" : "pending",
      description: failed
        ? "Required native SDK validation failed"
        : passed
          ? "Required native SDK validation passed"
          : "Waiting for configured native SDK validation",
      target_url: `https://github.com/${owner}/${repo}/actions/runs/${context.runId}`,
    });

    // Revalidate the live head before mutable PR labels, not just before the status on a SHA.
    const { data: current } = await github.rest.pulls.get({ owner, repo, pull_number: number });
    if (current.state !== "open" || current.head.sha !== headSha) continue;
    const labels = new Set(
      current.labels.map((label) => (typeof label === "string" ? label : label.name)),
    );
    for (const { entry, action } of results) {
      const label = entry.breakingChange?.label;
      if (!label || !action) {
        if (entry.breakingChange)
          core.warning(`No definitive native label assertion for ${entry.language}`);
        continue;
      }
      if (
        action === "add" &&
        ["main", "RPSaaSMaster"].includes(current.base.ref) &&
        !labels.has(label)
      ) {
        await github.rest.issues.addLabels({ owner, repo, issue_number: number, labels: [label] });
      } else if (action === "remove" && labels.has(label)) {
        await github.rest.issues.removeLabel({ owner, repo, issue_number: number, name: label });
      }
    }
  }
}
