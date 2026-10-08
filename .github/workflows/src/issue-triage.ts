import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { parseDocument } from "yaml";
import { z } from "zod";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { escapeMarkdown } from "../../shared/src/markdown.ts";
import type { GitHubScriptArgs } from "./github.ts";
import { loadLabelCatalog } from "./label-catalog-loader.ts";

const COMMENT_MARKER = "<!-- issue-triage -->";
const KIND_LABELS = {
  bug: "bug",
  feature: "feature-request",
  question: "question",
  documentation: "documentation",
} as const;
const decisionSchema = z.strictObject({
  number: z.number().int().positive().safe(),
  updatedAt: z.iso.datetime({ offset: true }),
  routing: z.enum(["engsys", "service", "uncertain"]),
  confidence: z.enum(["high", "medium", "low"]),
  kind: z.enum(["bug", "feature", "question", "documentation"]).nullable(),
  serviceLabel: z.string().min(1).max(50).nullable(),
  plane: z.enum(["management", "data"]).nullable(),
  summary: z.string().trim().min(1).max(400),
  rationale: z.string().trim().min(1).max(400),
  duplicateOf: z.number().int().positive().safe().optional(),
  question: z.string().trim().min(1).max(300).optional(),
});
const outputSchema = z.object({
  items: z.array(z.object({ type: z.string(), decision: z.string().optional() })).min(1),
  errors: z.array(z.unknown()).optional(),
});
type Issue = Awaited<ReturnType<GitHubScriptArgs["github"]["rest"]["issues"]["get"]>>["data"];

function eligible(issue: Issue): boolean {
  return (
    issue.state === "open" && !issue.locked && !issue.pull_request && issue.user?.type !== "Bot"
  );
}

function labelNames(issue: Issue): Set<string> {
  return new Set(
    issue.labels.map((label) => (typeof label === "string" ? label : (label.name ?? ""))),
  );
}

export async function applyIssueTriage(
  { github, context, core }: GitHubScriptArgs,
  output: unknown,
  options: { issueNumber: string; catalogPath: string; dryRun: boolean },
): Promise<void> {
  if (
    context.repo.owner !== "Azure" ||
    context.repo.repo !== "azure-rest-api-specs" ||
    context.ref !== "refs/heads/main" ||
    !["issues", "workflow_dispatch"].includes(context.eventName) ||
    (context.eventName === "issues" && context.payload.action !== "opened")
  ) {
    throw new Error("Issue triage may only run on the upstream default branch");
  }
  if (
    !/^[1-9]\d*$/.test(options.issueNumber) ||
    !Number.isSafeInteger(Number(options.issueNumber))
  ) {
    throw new Error("Issue number must be a positive safe integer");
  }
  const number = Number(options.issueNumber);
  if (context.eventName === "issues" && context.payload.issue?.number !== number) {
    throw new Error("Triage target must match the triggering issue");
  }
  const parsedOutput = outputSchema.parse(output);
  if (parsedOutput.errors?.length) {
    throw new Error("Safe-output validation rejected issue triage output");
  }
  if (parsedOutput.items.length !== 1 || parsedOutput.items[0].type !== "apply_issue_triage") {
    throw new Error("Expected exactly one issue triage decision");
  }
  const decision = decisionSchema.parse(JSON.parse(parsedOutput.items[0].decision ?? ""));
  if (decision.number !== number || decision.duplicateOf === number) {
    throw new Error("Invalid issue triage target or self-duplicate");
  }
  if (decision.routing !== "service" && (decision.serviceLabel || decision.plane)) {
    throw new Error("Service labels and API planes require service routing");
  }

  const params = { ...context.repo, issue_number: number };
  const { data: issue } = await github.rest.issues.get(params);
  if (!eligible(issue)) {
    core.notice(`Skipping ineligible issue ${number}; no changes made.`);
    return;
  }
  if (issue.updated_at !== decision.updatedAt) {
    throw new Error(
      `Issue ${number} changed during triage; dispatch again to review the current issue.`,
    );
  }
  const sourceTitle = issue.title;
  const sourceBody = issue.body;

  const { catalog } = await loadLabelCatalog(options.catalogPath);
  const configured = new Set(catalog.labels.map((label) => label.name));
  const canonicalNames = new Map(
    catalog.labels.map((label) => [label.name.toLowerCase(), label.name]),
  );
  const serviceDocument = parseDocument(
    await readFile(join(dirname(options.catalogPath), "labels", "services.yaml"), "utf8"),
  );
  if (serviceDocument.errors.length) {
    throw new Error("Invalid service label catalog");
  }
  const serviceDefinitions = z
    .object({ labels: z.array(z.object({ name: z.string().min(1) })) })
    .parse(serviceDocument.toJS());
  const services = new Set(
    serviceDefinitions.labels
      .map((label) => canonicalNames.get(label.name.toLowerCase()))
      .filter((name): name is string => name !== undefined && name !== "EngSys"),
  );
  if (decision.serviceLabel && !services.has(decision.serviceLabel)) {
    throw new Error(`Invalid service label: ${decision.serviceLabel}`);
  }
  const current = labelNames(issue);
  let routing = decision.confidence === "high" ? decision.routing : "uncertain";
  const conflicting =
    (routing === "engsys" && current.has("Service Attention")) ||
    (routing === "service" && current.has("EngSys")) ||
    (routing === "service" &&
      decision.serviceLabel !== null &&
      [...current].some((label) => services.has(label) && label !== decision.serviceLabel)) ||
    (routing === "service" &&
      ((decision.plane === "management" && current.has("data-plane")) ||
        (decision.plane === "data" && current.has("Mgmt"))));
  if (conflicting) {
    core.warning(
      `Issue ${number} has conflicting routing labels; preserving them for manual review.`,
    );
    routing = "uncertain";
  }

  const labels = [
    routing === "engsys"
      ? "EngSys"
      : routing === "service"
        ? "Service Attention"
        : "needs-team-triage",
  ];
  if (routing === "service") {
    if (decision.serviceLabel) labels.push(decision.serviceLabel);
    if (decision.plane) labels.push(decision.plane === "management" ? "Mgmt" : "data-plane");
  }
  if (decision.kind && routing !== "uncertain") {
    const kindLabel = KIND_LABELS[decision.kind];
    const specificKinds = ["bug", "feature-request", "documentation"];
    if (!specificKinds.some((label) => current.has(label) && label !== kindLabel)) {
      labels.push(kindLabel);
    } else {
      core.warning(`Preserving the existing issue kind on ${number}.`);
    }
  }
  const toAdd = labels.filter((label) => !current.has(label));
  for (const label of toAdd) {
    if (!configured.has(label)) throw new Error(`Unconfigured triage label: ${label}`);
    const { data } = await github.rest.issues.getLabel({ ...context.repo, name: label });
    if ("archived_at" in data && data.archived_at) {
      throw new Error(`Cannot apply archived triage label: ${label}`);
    }
  }

  let duplicate: string | undefined;
  if (decision.duplicateOf) {
    const { data: candidate } = await github.rest.issues.get({
      ...context.repo,
      issue_number: decision.duplicateOf,
    });
    if (candidate.state !== "open" || candidate.pull_request) {
      throw new Error("A possible duplicate must reference another open issue in this repository");
    }
    duplicate = `Possible duplicate: https://github.com/Azure/azure-rest-api-specs/issues/${decision.duplicateOf}. Maintainers should confirm the match.`;
  }
  const routingText =
    routing === "engsys"
      ? "EngSys"
      : routing === "service"
        ? `Service Attention${decision.serviceLabel ? ` (${decision.serviceLabel})` : ""}`
        : "Needs manual triage";
  const body = [
    COMMENT_MARKER,
    "**Issue triage**",
    escapeMarkdown(decision.summary),
    `**Routing:** ${escapeMarkdown(routingText)}. ${conflicting ? "Existing labels conflict with the prediction; no routing labels were replaced. " : ""}${escapeMarkdown(decision.rationale)}`,
    duplicate,
    decision.question ? `**Missing information:** ${escapeMarkdown(decision.question)}` : undefined,
    `> Automated initial triage, not a resolution or relevance assessment. [Workflow run](https://github.com/Azure/azure-rest-api-specs/actions/runs/${context.runId}).`,
  ]
    .filter((line) => line !== undefined)
    .join("\n\n");
  if (options.dryRun) {
    core.info(`Dry run for issue ${number}: add labels ${JSON.stringify(toAdd)}\n${body}`);
    return;
  }
  const comments = await github.paginate(github.rest.issues.listComments, {
    ...params,
    per_page: PER_PAGE_MAX,
  });
  const existing = comments.find(
    (comment) =>
      comment.user?.login === "github-actions[bot]" &&
      comment.user.type === "Bot" &&
      comment.body?.startsWith(COMMENT_MARKER),
  );
  if (!toAdd.length && existing?.body === body) return;
  const { data: fresh } = await github.rest.issues.get(params);
  const freshLabels = labelNames(fresh);
  if (
    !eligible(fresh) ||
    fresh.updated_at !== decision.updatedAt ||
    fresh.title !== sourceTitle ||
    fresh.body !== sourceBody ||
    freshLabels.size !== current.size ||
    [...current].some((label) => !freshLabels.has(label))
  ) {
    throw new Error(
      `Issue ${number} changed during triage; dispatch again to review the current issue.`,
    );
  }
  if (toAdd.length) await github.rest.issues.addLabels({ ...params, labels: toAdd });
  if (existing) {
    if (existing.body !== body) {
      await github.rest.issues.updateComment({
        ...context.repo,
        comment_id: existing.id,
        body,
      });
    }
  } else {
    await github.rest.issues.createComment({ ...params, body });
  }
}
