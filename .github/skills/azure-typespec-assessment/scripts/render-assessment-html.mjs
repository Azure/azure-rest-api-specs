import fs from "node:fs";
import path from "node:path";
import { extractApiVersions, selectApiVersionPair } from "./api-version-selection.mjs";
import { documentQualitySummary, renderReportSections } from "./assessment-report-ui.mjs";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.mjs";
import { validateAssessment } from "./validate-assessment.mjs";

/** @typedef {import("./runtime-types.js").ArtifactSelection} ArtifactSelection */
/** @typedef {import("./runtime-types.js").ArtifactComparison} ArtifactComparison */
/** @typedef {import("./runtime-types.js").AssessmentFact} AssessmentFact */
/** @typedef {import("./runtime-types.js").AssessmentFinding} AssessmentFinding */
/** @typedef {import("./runtime-types.js").AssessmentMethodGroup} AssessmentMethodGroup */
/** @typedef {import("./runtime-types.js").AssessmentOperation} AssessmentOperation */
/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").AssessmentParameter} AssessmentParameter */
/** @typedef {import("./runtime-types.js").AssessmentRequest} AssessmentRequest */
/** @typedef {import("./runtime-types.js").AssessmentResponse} AssessmentResponse */
/** @typedef {import("./runtime-types.js").AssessmentResponseHeader} AssessmentResponseHeader */
/** @typedef {import("./runtime-types.js").AssessmentSemanticItem} AssessmentSemanticItem */
/** @typedef {import("./runtime-types.js").AssessmentTypeImpact} AssessmentTypeImpact */
/** @typedef {import("./runtime-types.js").ComplianceDocument} ComplianceDocument */
/** @typedef {import("./runtime-types.js").ComplianceGuidance} ComplianceGuidance */
/** @typedef {import("./runtime-types.js").ComplianceIntentAssessment} ComplianceFinding */
/** @typedef {import("./runtime-types.js").FinalComplianceAssessment} FinalComplianceAssessment */
/** @typedef {import("./runtime-types.js").InternalSemanticOperation} InternalSemanticOperation */
/** @typedef {import("./runtime-types.js").LegacyAssessmentFinding} LegacyAssessmentFinding */
/** @typedef {import("./runtime-types.js").LegacyAssessmentFindingInput} LegacyAssessmentFindingInput */
/** @typedef {import("./runtime-types.js").LegacyAssessmentInput} LegacyAssessmentInput */
/** @typedef {import("./runtime-types.js").LegacyAssessmentSourceReference} LegacyAssessmentSourceReference */
/** @typedef {import("./runtime-types.js").LegacyAssessmentDiff} LegacyAssessmentDiff */
/** @typedef {import("./runtime-types.js").ContractChangeRow} ContractChangeRow */
/** @typedef {import("./runtime-types.js").DownstreamTypeCard} DownstreamTypeCard */
/** @typedef {import("./runtime-types.js").DownstreamAnalysis} DownstreamAnalysis */
/** @typedef {import("./runtime-types.js").DiffHunk} DiffHunk */
/** @typedef {import("./runtime-types.js").NormalizedAutorestHeader} NormalizedAutorestHeader */
/** @typedef {import("./runtime-types.js").NormalizedAutorestOperation} NormalizedAutorestOperation */
/** @typedef {import("./runtime-types.js").NormalizedAutorestParameter} NormalizedAutorestParameter */
/** @typedef {import("./runtime-types.js").NormalizedAutorestResponse} NormalizedAutorestResponse */
/** @typedef {import("./runtime-types.js").NormalizedSchema} NormalizedSchema */
/** @typedef {import("./runtime-types.js").RestContractCard} RestContractCard */
/** @typedef {import("./runtime-types.js").SemanticFindingReference} SemanticFindingReference */
/** @typedef {import("./runtime-types.js").SdkType} SdkType */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {AssessmentMethodGroup["deltas"][number]} AssessmentMethodDelta */
/** @typedef {NonNullable<AssessmentMethodDelta["changes"]>} AssessmentMethodParameterChanges */
/** @typedef {NonNullable<AssessmentFact["properties"]>[number]} AssessmentProperty */
/**
 * @typedef {{path: string, startLine?: number, endLine?: number, link?: string}} ComplianceSourceLink
 * @typedef {{
 *   caption?: string,
 *   path?: string,
 *   startLine?: number,
 *   endLine?: number,
 *   url?: string,
 *   link?: string,
 *   lines?: unknown[]
 * }} ComplianceSnippet
 * @typedef {{icon: string, className: string, label: string}} StatusPresentation
 * @typedef {{
 *   area?: string,
 *   areaKind?: string,
 *   label?: string,
 *   member?: string,
 *   before: string,
 *   after: string,
 *   detail?: string,
 *   beforeDetail?: string,
 *   afterDetail?: string,
 *   kind?: string,
 *   identity?: string,
 *   model?: string
 * }} ContractRow
 * @typedef {{schema?: NormalizedSchema, identity?: string, display?: string}} ContractValue
 * @typedef {{area?: string, areaKind?: string, member?: string}} ContractAreaInput
 * @typedef {{canonicalUrl?: string, url?: string, title?: string}} ComplianceDocumentReference
 * @typedef {ContractChangeRow & {identity: string}} RestContractDelta
 * @typedef {{downstreamAssessment?: AssessmentOutput, downstreamInput?: DownstreamAnalysis}} RenderOptions
 */

const reportStyles = fs.readFileSync(
  new URL("./assessment-report-ui.css", import.meta.url),
  "utf8",
);

/** @param {unknown} value @returns {value is Record<string, unknown>} */
function isRecord(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

/**
 * @param {unknown} value
 * @param {string} key
 * @returns {unknown}
 */
function recordValue(value, key) {
  return isRecord(value) ? value[key] : undefined;
}

/**
 * @param {AssessmentOutput | LegacyAssessmentInput} assessment
 * @returns {assessment is AssessmentOutput}
 */
function isCurrentAssessment(assessment) {
  return assessment.schemaVersion === 1 && "semantic" in assessment.dimensions;
}

/**
 * @param {unknown} value
 * @returns {value is AssessmentOutput | LegacyAssessmentInput}
 */
function isAssessmentInput(value) {
  if (!isRecord(value) || !isRecord(value.dimensions)) return false;
  if (value.schemaVersion === 1) {
    return (
      isRecord(value.comparison) &&
      isRecord(value.safety) &&
      Array.isArray(value.blockers) &&
      isRecord(value.dimensions.semantic) &&
      isRecord(value.dimensions.rest) &&
      isRecord(value.dimensions.downstream) &&
      isRecord(value.dimensions.compliance) &&
      isRecord(value.dimensions.documentQuality)
    );
  }
  return (
    typeof value.pr === "number" &&
    isRecord(value.baseline) &&
    typeof value.baseline.commit === "string" &&
    isRecord(value.head) &&
    typeof value.head.commit === "string" &&
    isRecord(value.dimensions.semanticUnderstanding) &&
    isRecord(value.dimensions.restBreakingChanges) &&
    isRecord(value.dimensions.restCompatibleDownstreamBreakingChanges) &&
    isRecord(value.dimensions.azureCompliance)
  );
}

/** @param {unknown} value @returns {value is DownstreamAnalysis} */
function isDownstreamAnalysis(value) {
  return (
    isRecord(value) &&
    typeof value.schemaVersion === "number" &&
    (value.status === "ready" || value.status === "blocked") &&
    isRecord(value.facts) &&
    Array.isArray(value.rootCauses) &&
    Array.isArray(value.candidates) &&
    Array.isArray(value.blockers)
  );
}

/**
 * @param {string | boolean | string[] | undefined} value
 * @param {string} flag
 * @returns {string | undefined}
 */
function optionalCliPath(value, flag) {
  if (value === undefined) return undefined;
  if (typeof value !== "string") {
    throw new Error(`${flag} requires exactly one path.`);
  }
  return value;
}

/** @param {unknown} value @returns {value is ComplianceSnippet} */
function isComplianceSnippet(value) {
  return isRecord(value);
}

/** @param {unknown} value */
function displayValue(value) {
  if (value === null || value === undefined) return "";
  if (
    typeof value === "string" ||
    typeof value === "number" ||
    typeof value === "boolean" ||
    typeof value === "bigint"
  ) {
    return String(value);
  }
  return JSON.stringify(value) ?? "";
}

/** @param {unknown} value */
export function escapeHtml(value) {
  return displayValue(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

/** @param {SourceChange[]} [sources] */
function sourceLinks(sources = []) {
  return sources
    .map((source) => {
      const current =
        source.declarations?.find((item) => item.source?.revision === "current") ??
        source.declarations?.find((item) => item.source?.link);
      const label = `${source.path}${current ? `:${current.source.startLine}` : ""}`;
      return current?.source?.link
        ? `<a href="${escapeHtml(current.source.link)}">${escapeHtml(label)}</a>`
        : `<code>${escapeHtml(label)}</code>`;
    })
    .join(", ");
}

/** @param {unknown} value */
function anchor(value) {
  return displayValue(value).replaceAll(/[^A-Za-z0-9_-]/g, "-");
}

/** @param {Partial<ArtifactSelection>} [selection] */
function artifactLabel(selection = {}) {
  const commit = selection.commit ?? "unknown commit";
  return `${commit}@${selection.apiVersion ?? "unversioned"}`;
}

/** @param {AssessmentOutput} assessment */
function headerTitle(assessment) {
  if (assessment.displayTitle) return assessment.displayTitle;
  const intents = assessment.dimensions.semantic.items ?? [];
  if (intents.length === 1) return intents[0].title;
  const services = [
    ...new Set(
      (assessment.projects ?? [])
        .map((project) => project.path?.split(/[\\/]/).filter(Boolean).at(-1))
        .filter(Boolean),
    ),
  ];
  if (intents.length && services.length) {
    return `${intents.length} TypeSpec changes for ${services.join(" and ")}`;
  }
  return assessment.title ?? "Current TypeSpec changes";
}

/** @param {AssessmentOutput} assessment */
function headerSummary(assessment) {
  const semanticItems = assessment.dimensions.semantic.items ?? [];
  const actionCounts = { add: 0, modify: 0, remove: 0 };
  for (const item of semanticItems) {
    if (item.action === "add" || item.action === "modify" || item.action === "remove") {
      actionCounts[item.action] += 1;
    }
  }
  const operationCount = new Set(
    semanticItems.flatMap((item) =>
      (item.operations ?? []).map(
        (operation) => `${operation.projectId ?? ""}:${operation.operationId}`,
      ),
    ),
  ).size;
  const restCount =
    restContractCards(assessment.dimensions.rest.findings).length +
    (assessment.dimensions.rest.legacyFindings?.length ?? 0);
  const directDownstreamCount =
    (assessment.dimensions.downstream.methodGroups?.length ??
      assessment.dimensions.downstream.operationGroups?.length ??
      0) +
    downstreamTypeCards(assessment.dimensions.downstream).length +
    directLegacyDownstreamFindings(assessment.dimensions.downstream.legacyFindings).length;
  const downstreamCount = directDownstreamCount;
  const compliance = assessment.dimensions.compliance;
  const complianceFindingCount =
    (compliance.legacyFindings?.length ?? 0) + (compliance.findings?.length ?? 0);
  const complianceIssueCount = compliance.legacyFindings
    ? compliance.legacyFindings.length
    : complianceFindingGroups(compliance.findings).length;
  const complianceCoveredCount = compliance.coverage?.assessedIntentCount ?? 0;
  const complianceMaterialCount = compliance.coverage?.semanticIntentCount ?? 0;
  return {
    semanticItems,
    actionCounts,
    operationCount,
    restCount,
    restFindingCount:
      (assessment.dimensions.rest.findings?.length ?? 0) +
      (assessment.dimensions.rest.legacyFindings?.length ?? 0),
    directDownstreamCount,
    downstreamCount,
    downstreamFindingCount:
      (assessment.dimensions.downstream.findings?.length ?? 0) +
      directLegacyDownstreamFindings(assessment.dimensions.downstream.legacyFindings).length,
    complianceStatus: compliance.status,
    complianceFindingCount,
    complianceIssueCount,
    complianceCoveredCount,
    complianceMaterialCount,
    complianceCoverageDetail: compliance.legacyDocuments
      ? `${compliance.legacyDocuments.length} documents assessed`
      : `${complianceCoveredCount}/${complianceMaterialCount} intents assessed`,
  };
}

/** @param {string | undefined} status */
function complianceStatus(status) {
  if (status === "passed" || status === "assessed")
    return { icon: "✓", className: "pass", label: "Pass" };
  if (status === "failed") return { icon: "×", className: "fail", label: "Fail" };
  return { icon: "i", className: "", label: "N/A" };
}

/**
 * @param {string} title
 * @param {StatusPresentation} status
 */
function summaryHeading(title, status) {
  const label =
    status.label === "Pass"
      ? "Passed"
      : status.label === "Fail"
        ? "Failed"
        : status.label === "N/A"
          ? "Not assessed"
          : status.label;
  return `<div class="summary-heading"><div class="summary-value"><span class="${escapeHtml(status.className)}" aria-label="${escapeHtml(label)}">${escapeHtml(status.icon)}</span></div><div class="summary-label">${escapeHtml(title)}</div></div>`;
}

/** @param {unknown} remoteUrl */
function githubRepositoryUrl(remoteUrl) {
  if (typeof remoteUrl !== "string") return undefined;
  const normalized = remoteUrl
    .trim()
    .replace(/\/+$/, "")
    .replace(/\.git$/i, "");
  if (/^https?:\/\/github\.com\//i.test(normalized)) return normalized;
  const sshPath = normalized.match(/^git@github\.com:(.+)$/i)?.[1];
  if (sshPath) return `https://github.com/${sshPath}`;
  const sshUrlPath = normalized.match(/^ssh:\/\/git@github\.com\/(.+)$/i)?.[1];
  return sshUrlPath ? `https://github.com/${sshUrlPath}` : undefined;
}

/** @param {AssessmentOutput} assessment */
function pullRequestLink(assessment) {
  const number = assessment.pullRequest?.number ?? assessment.pr;
  const repositoryUrl = githubRepositoryUrl(assessment.repository?.remoteUrl);
  const url =
    assessment.pullRequest?.url ??
    (number && repositoryUrl ? `${repositoryUrl}/pull/${number}` : undefined);
  return url
    ? `<a href="${escapeHtml(url)}">#${escapeHtml(number)}</a>`
    : "Not available for this local pre-PR assessment.";
}

/** @param {unknown[]} [snippets] */
function complianceCode(snippets = []) {
  return snippets
    .map((snippet) => {
      const details = isComplianceSnippet(snippet) ? snippet : undefined;
      const lines = Array.isArray(snippet) ? snippet : (details?.lines ?? []);
      const startLine = Number.isFinite(details?.startLine) ? details?.startLine : undefined;
      const label =
        details?.caption ??
        (details?.path
          ? `${details.path}${startLine ? `:${startLine}-${details.endLine ?? startLine}` : ""}`
          : "Changed TypeSpec");
      const heading =
        (details?.url ?? details?.link)
          ? `<a href="${escapeHtml(details.url ?? details.link)}">${escapeHtml(label)}</a>`
          : escapeHtml(label);
      return `<div class="diff"><div class="diff-path">${heading}</div><pre>${lines
        .map((line, index) => {
          const kind = displayValue(line).startsWith("+")
            ? "add"
            : displayValue(line).startsWith("-")
              ? "remove"
              : "";
          const lineNumber = startLine
            ? `<span class="line-number">${startLine + index}</span>`
            : "";
          return `<span class="${kind}">${lineNumber}${escapeHtml(line)}</span>`;
        })
        .join("\n")}</pre></div>`;
    })
    .join("");
}

/** @param {unknown} value */
function normalizedComplianceGroupText(value) {
  return displayValue(value).trim().replaceAll(/\s+/g, " ").toLowerCase();
}

/** @param {ComplianceFinding[]} [findings] */
export function complianceFindingGroups(findings = []) {
  /** @type {{key: string, findings: ComplianceFinding[]}[]} */
  const groups = [];
  /** @type {Map<string, {key: string, findings: ComplianceFinding[]}>} */
  const groupsByKey = new Map();
  for (const finding of findings) {
    const guidanceIdentity = (finding.applicableGuidance ?? [])
      .map(
        (item) =>
          `${String(item.canonicalDocumentUrl ?? "").trim()}\u0000${normalizedComplianceGroupText(item.guidanceSection)}`,
      )
      .sort()
      .join("\u0001");
    const expected = normalizedComplianceGroupText(finding.expected);
    const key =
      guidanceIdentity && expected
        ? `${guidanceIdentity}\u0002${expected}`
        : `finding:${finding.id}`;
    let group = groupsByKey.get(key);
    if (!group) {
      group = { key, findings: [] };
      groupsByKey.set(key, group);
      groups.push(group);
    }
    group.findings.push(finding);
  }
  return groups;
}

/** @param {ComplianceDocumentReference} document */
function fetchedComplianceDocument(document) {
  const url = document.canonicalUrl ?? document.url;
  return `<li><a href="${escapeHtml(url)}">${escapeHtml(document.title ?? url)}</a></li>`;
}

/** @param {FinalComplianceAssessment} dimension */
function complianceEvidenceAppendix(dimension) {
  /** @type {ComplianceDocumentReference[]} */
  const documents = [
    ...(dimension.sharedSearch?.documents ?? []),
    ...(dimension.intentAssessments ?? []).flatMap((item) => item.documents ?? []),
    ...(dimension.legacyDocuments ?? []),
  ];
  /** @type {Set<string>} */
  const seenUrls = new Set();
  const uniqueDocuments = documents.filter((document) => {
    const url = document.canonicalUrl ?? document.url;
    if (!url || seenUrls.has(url)) return false;
    seenUrls.add(url);
    return true;
  });
  const documentList = uniqueDocuments.length
    ? `<ul class="guidance-document-list">${uniqueDocuments.map(fetchedComplianceDocument).join("")}</ul>`
    : '<div class="panel">No guidance fetched.</div>';
  const evidence = {
    status: dimension.status,
    coverage: dimension.coverage,
    sharedSearch: dimension.sharedSearch,
    intentAssessments: (dimension.intentAssessments ?? []).map((item) => ({
      semanticIntentId: item.semanticIntentId,
      decision: item.decision,
      catalogRanking: item.catalogRanking,
      documents: item.documents,
      blockers: item.blockers,
    })),
    retrievalFailures: dimension.retrievalFailures,
    blockers: dimension.blockers,
  };
  return `${documentList}<details class="guidance-coverage"><summary>Guidance coverage and retrieval evidence</summary><pre>${escapeHtml(JSON.stringify(evidence, null, 2))}</pre></details>`;
}

/**
 * @param {string[]} ids
 * @param {AssessmentSemanticItem[]} semanticItems
 */
function intentTitleLinks(ids, semanticItems) {
  const titles = new Map(semanticItems.map((item) => [item.id, item.title]));
  return ids
    .map(
      (id) =>
        `<a href="#intent-${anchor(id)}">${escapeHtml(titles.get(id) ?? "Semantic intent")}</a>`,
    )
    .join(", ");
}

/** @param {AssessmentOutput} assessment */
function headerComparison(assessment) {
  return `<code>${escapeHtml(assessment.comparison.baseCommit)}</code> → <code>${escapeHtml(assessment.comparison.headCommit)}</code>`;
}

/** @param {string[]} [ids] */
function semanticLinks(ids = []) {
  return ids.length
    ? ids
        .map((id) => `<a href="#intent-${anchor(id)}"><code>${escapeHtml(id)}</code></a>`)
        .join(", ")
    : "None";
}

/** @param {NormalizedSchema | undefined} schema @returns {string | undefined} */
function schemaIdentity(schema) {
  const reference = schema?.reference?.split("/").at(-1);
  return schema?.enumMetadata?.name ?? reference;
}

/** @param {NormalizedSchema | undefined} schema @returns {string} */
function schemaDisplay(schema) {
  if (!schema) return "removed";
  const identity = schemaIdentity(schema);
  if (schema.kind === "array") return `${schemaDisplay(schema.items)}[]`;
  if (schema.kind === "enum") {
    const values = Array.isArray(schema.values) ? schema.values.join(" | ") : schema.values;
    return `${identity ?? schema.type ?? "enum"}${values ? ` { ${values} }` : ""}`;
  }
  if (identity) return identity;
  return [schema.type ?? schema.kind, schema.format].filter(Boolean).join(" ");
}

/**
 * @param {NormalizedSchema | undefined} schema
 * @param {string[]} pathSegments
 * @returns {ContractValue}
 */
function schemaPath(schema, pathSegments) {
  let current = schema;
  let identity = schemaIdentity(current);
  for (const rawSegment of pathSegments) {
    const isArray = rawSegment.endsWith("[]");
    const name = rawSegment.replace(/\[\]$/, "");
    const property = (current?.properties ?? []).find((item) => item.name === name);
    if (!property) return { schema: undefined, identity };
    current = property.schema;
    identity = schemaIdentity(current) ?? identity;
    if (isArray) {
      current = current?.items;
      identity = schemaIdentity(current) ?? identity;
    }
  }
  return { schema: current, identity };
}

/** @param {AssessmentFinding} finding */
function operationFacts(finding) {
  const facts = finding.evidence ?? [];
  return {
    before: facts.find((fact) => fact.comparisonRole === "baseline") ?? facts[0],
    after: facts.find((fact) => fact.comparisonRole === "target") ?? facts[1],
  };
}

/**
 * @param {AssessmentFact | undefined} operation
 * @param {string} name
 * @returns {ContractValue}
 */
function parameterValue(operation, name) {
  const parameter = (operation?.parameters ?? []).find((item) => item.name === name);
  return {
    schema: parameter?.schema,
    identity: schemaIdentity(parameter?.schema),
    display: parameter
      ? `${parameter.in}:${parameter.name}${parameter.required ? " (required)" : ""} · ${schemaDisplay(parameter.schema)}`
      : "removed",
  };
}

/**
 * @param {AssessmentFact | undefined} operation
 * @param {string} name
 * @returns {ContractValue}
 */
function responseHeaderValue(operation, name) {
  for (const response of operation?.responses ?? []) {
    const header = (response.headers ?? []).find(
      (item) => item.name?.toLowerCase() === name.toLowerCase(),
    );
    if (header) {
      return {
        schema: header.schema,
        identity: schemaIdentity(header.schema),
        display: `${response.status} · ${schemaDisplay(header.schema)}`,
      };
    }
  }
  return { display: "removed" };
}

/**
 * @param {AssessmentFact | undefined} operation
 * @param {string} location
 * @returns {ContractValue}
 */
function responseSchemaValue(operation, location) {
  const match = location?.match(/^response ([^.]+)(?:\.(.*))?$/);
  if (!match) return { display: "unavailable" };
  const response = (operation?.responses ?? []).find((item) => item.status === match[1]);
  if (!response) return { display: "removed" };
  const result = schemaPath(response.schema, match[2]?.split(".") ?? []);
  return {
    ...result,
    display: schemaDisplay(result.schema),
  };
}

/** @param {AssessmentFinding} finding @returns {RestContractDelta} */
function restContractDelta(finding) {
  const change = finding.contractChange ?? {};
  const { before, after } = operationFacts(finding);
  const rule = finding.rule ?? "";
  const location = change.location ?? rule;
  /** @type {ContractValue} */
  let beforeValue;
  /** @type {ContractValue} */
  let afterValue;
  if (rule.startsWith("parameter-") || rule === "required-parameter-added") {
    beforeValue = parameterValue(before, location);
    afterValue = parameterValue(after, location);
  } else if (rule.startsWith("response-header-")) {
    beforeValue = responseHeaderValue(before, location);
    afterValue = responseHeaderValue(after, location);
  } else if (location.startsWith("response ")) {
    beforeValue = responseSchemaValue(before, location);
    afterValue = responseSchemaValue(after, location);
  } else if (rule === "method-changed") {
    beforeValue = { display: before?.method?.toUpperCase() };
    afterValue = { display: after?.method?.toUpperCase() };
  } else if (rule === "path-changed") {
    beforeValue = { display: before?.path };
    afterValue = { display: after?.path };
  } else if (rule === "operation-removed") {
    beforeValue = {
      display: `${before?.method?.toUpperCase()} ${before?.path}`,
    };
    afterValue = { display: "removed" };
  } else {
    beforeValue = { display: finding.expected };
    afterValue = { display: finding.actual };
  }
  const identity =
    beforeValue.identity ??
    afterValue.identity ??
    finding.operationIds?.[0] ??
    "Unmapped REST contract change";
  /** @type {string | undefined} */
  let areaKind;
  let member = location;
  if (rule.startsWith("parameter-") || rule === "required-parameter-added") {
    const wireLocation = [beforeValue.display, afterValue.display]
      .map((display) => display?.match(/^(query|path|header):/i)?.[1])
      .find(Boolean);
    /** @type {Record<string, string>} */
    const labels = {
      query: "Query parameter",
      path: "Path parameter",
      header: "Request header",
    };
    areaKind = wireLocation ? labels[wireLocation.toLowerCase()] : undefined;
    for (const value of [beforeValue, afterValue]) {
      if (value.display?.includes(" · ")) {
        value.display = value.display.split(" · ").slice(1).join(" · ");
      }
    }
  } else if (rule.startsWith("response-header-")) {
    const status = [beforeValue.display, afterValue.display]
      .map((display) => display?.match(/^(\S+)\s+·/)?.[1])
      .find(Boolean);
    areaKind = "Response header";
    member = status ? `${status} · ${location}` : location;
    for (const value of [beforeValue, afterValue]) {
      if (value.display?.includes(" · ")) {
        value.display = value.display.split(" · ").slice(1).join(" · ");
      }
    }
  }
  return {
    identity,
    area: location,
    areaKind,
    member,
    before: beforeValue.display ?? "unavailable",
    after: afterValue.display ?? "unavailable",
  };
}

/**
 * @param {AssessmentFinding} finding
 * @param {AssessmentOperation} operation
 * @param {string | undefined} semanticIntentId
 */
function findingMatchesOperation(finding, operation, semanticIntentId) {
  if (!(finding.operationIds ?? []).includes(operation.operationId)) {
    return false;
  }
  if (semanticIntentId && !(finding.relatedSemanticIntents ?? []).includes(semanticIntentId)) {
    return false;
  }
  const operationFacts = (finding.evidence ?? []).filter(
    (fact) => fact.operationId === operation.operationId,
  );
  return (
    !operation.apiVersion ||
    operationFacts.length === 0 ||
    operationFacts.some((fact) => fact.apiVersion === operation.apiVersion)
  );
}

/** @param {unknown} left @param {unknown} right */
function contractValueEqual(left, right) {
  return JSON.stringify(left) === JSON.stringify(right);
}

/** @param {NormalizedSchema | undefined} schema */
function schemaShape(schema) {
  if (!schema) return undefined;
  return {
    kind: schema.kind,
    type: schema.type,
    format: schema.format,
    identity: schemaIdentity(schema),
    values: schema.kind === "enum" ? schema.values : undefined,
  };
}

/** @param {NormalizedSchema | undefined} schema @returns {string} */
function structuralSchemaDisplay(schema) {
  if (schema?.kind === "array" && !schema.items) return "array";
  return schemaDisplay(schema);
}

/**
 * @param {NonNullable<NormalizedSchema["properties"]>[number] | undefined} property
 * @param {string} missing
 */
function propertyDisplay(property, missing) {
  if (!property) return missing;
  return `${structuralSchemaDisplay(property.schema)}${property.required ? " (required)" : " (optional)"}`;
}

/**
 * @param {NormalizedSchema | undefined} before
 * @param {NormalizedSchema | undefined} after
 * @param {string} area
 * @returns {ContractChangeRow[]}
 */
function schemaContractRows(before, after, area) {
  if (contractValueEqual(before, after)) return [];
  if (!before || !after) {
    return [
      {
        area,
        before: before ? structuralSchemaDisplay(before) : "not present",
        after: after ? structuralSchemaDisplay(after) : "removed",
      },
    ];
  }
  if (!contractValueEqual(schemaShape(before), schemaShape(after))) {
    return [
      {
        area,
        before: structuralSchemaDisplay(before),
        after: structuralSchemaDisplay(after),
      },
    ];
  }

  /** @type {ContractChangeRow[]} */
  const rows = [];
  if (before.kind === "array" || after.kind === "array") {
    rows.push(...schemaContractRows(before.items, after.items, `${area}[]`));
  }
  const beforeProperties = new Map(
    (before.properties ?? []).map((property) => [property.name, property]),
  );
  const afterProperties = new Map(
    (after.properties ?? []).map((property) => [property.name, property]),
  );
  for (const name of [...new Set([...beforeProperties.keys(), ...afterProperties.keys()])].sort()) {
    const previous = beforeProperties.get(name);
    const current = afterProperties.get(name);
    const propertyArea = `${area}.${name}`;
    if (!previous || !current || previous.required !== current.required) {
      rows.push({
        area: propertyArea,
        before: propertyDisplay(previous, "not present"),
        after: propertyDisplay(current, "removed"),
      });
      continue;
    }
    rows.push(...schemaContractRows(previous.schema, current.schema, propertyArea));
  }
  return rows;
}

/**
 * @param {AssessmentParameter | undefined} parameter
 * @param {string} [missing]
 */
function parameterDisplay(parameter, missing = "not present") {
  if (!parameter) return missing;
  const details = [
    structuralSchemaDisplay(parameter.schema),
    parameter.required ? "required" : "optional",
    parameter.collectionFormat ? `collection: ${parameter.collectionFormat}` : undefined,
  ].filter(Boolean);
  return details.join(" · ");
}

/**
 * @param {AssessmentParameter[]} [before]
 * @param {AssessmentParameter[]} [after]
 * @returns {ContractChangeRow[]}
 */
function parameterContractRows(before = [], after = []) {
  /** @param {AssessmentParameter} parameter */
  const key = (parameter) => `${parameter.in ?? "body"}:${parameter.name}`;
  const beforeParameters = new Map(before.map((item) => [key(item), item]));
  const afterParameters = new Map(after.map((item) => [key(item), item]));
  /** @type {ContractChangeRow[]} */
  const rows = [];
  for (const area of [...new Set([...beforeParameters.keys(), ...afterParameters.keys()])].sort()) {
    const previous = beforeParameters.get(area);
    const current = afterParameters.get(area);
    if (!previous || !current) {
      rows.push({
        area,
        before: parameterDisplay(previous, "not present"),
        after: parameterDisplay(current, "removed"),
      });
      continue;
    }
    const schemaRows = schemaContractRows(previous.schema, current.schema, area);
    if (
      previous.required !== current.required ||
      previous.collectionFormat !== current.collectionFormat
    ) {
      rows.push({
        area,
        before: parameterDisplay(previous),
        after: parameterDisplay(current),
      });
    } else {
      rows.push(...schemaRows);
    }
  }
  return rows;
}

/**
 * @param {AssessmentRequest | undefined} before
 * @param {AssessmentRequest | undefined} after
 * @returns {ContractChangeRow[]}
 */
function requestContractRows(before, after) {
  if (!before || !after) {
    return [
      {
        area: "request body",
        before: before?.kind ?? "unknown",
        after: after?.kind ?? "removed",
      },
    ];
  }
  const beforeName = recordValue(before, "name");
  const afterName = recordValue(after, "name");
  if (
    before.kind !== after.kind ||
    beforeName !== afterName ||
    before.required !== after.required
  ) {
    return [
      {
        area: "request body",
        before: `${before.kind}${before.required ? " · required" : ""}`,
        after: `${after.kind}${after.required ? " · required" : ""}`,
      },
    ];
  }
  if (before.kind === "multipart" || after.kind === "multipart") {
    return parameterContractRows(before.members, after.members).map((row) => ({
      ...row,
      area: `request multipart:${row.area}`,
    }));
  }
  return schemaContractRows(before.schema, after.schema, "request body");
}

/**
 * @param {AssessmentResponseHeader | undefined} header
 * @param {string} missing
 */
function responseHeaderDisplay(header, missing) {
  if (!header) return missing;
  return [
    structuralSchemaDisplay(header.schema),
    header.collectionFormat ? `collection: ${header.collectionFormat}` : undefined,
  ]
    .filter(Boolean)
    .join(" · ");
}

/**
 * @param {AssessmentResponse | undefined} response
 * @param {string} missing
 */
function responseDisplay(response, missing) {
  if (!response) return missing;
  return (
    [response.statusKind, response.schema ? structuralSchemaDisplay(response.schema) : undefined]
      .filter(Boolean)
      .join(" · ") || "present"
  );
}

/**
 * @param {AssessmentResponse[]} [before]
 * @param {AssessmentResponse[]} [after]
 * @returns {ContractChangeRow[]}
 */
function responseContractRows(before = [], after = []) {
  const beforeResponses = new Map(before.map((response) => [response.status, response]));
  const afterResponses = new Map(after.map((response) => [response.status, response]));
  /** @type {ContractChangeRow[]} */
  const rows = [];
  for (const status of [...new Set([...beforeResponses.keys(), ...afterResponses.keys()])].sort()) {
    const previous = beforeResponses.get(status);
    const current = afterResponses.get(status);
    const responseArea = `response ${status}`;
    if (!previous || !current) {
      rows.push({
        area: responseArea,
        before: responseDisplay(previous, "not present"),
        after: responseDisplay(current, "removed"),
      });
      continue;
    }
    if (previous.statusKind !== current.statusKind) {
      rows.push({
        area: `${responseArea}.kind`,
        before: previous.statusKind ?? "unknown",
        after: current.statusKind ?? "unknown",
      });
    }
    rows.push(...schemaContractRows(previous.schema, current.schema, `${responseArea}.body`));
    const beforeHeaders = new Map(
      (previous.headers ?? []).map((header) => [header.name?.toLowerCase() ?? "", header]),
    );
    const afterHeaders = new Map(
      (current.headers ?? []).map((header) => [header.name?.toLowerCase() ?? "", header]),
    );
    for (const headerName of [
      ...new Set([...beforeHeaders.keys(), ...afterHeaders.keys()]),
    ].sort()) {
      const previousHeader = beforeHeaders.get(headerName);
      const currentHeader = afterHeaders.get(headerName);
      if (contractValueEqual(previousHeader, currentHeader)) continue;
      const headerArea = `${responseArea}.header:${currentHeader?.name ?? previousHeader?.name ?? headerName}`;
      const schemaRows = schemaContractRows(
        previousHeader?.schema,
        currentHeader?.schema,
        headerArea,
      );
      if (
        previousHeader &&
        currentHeader &&
        previousHeader.collectionFormat === currentHeader.collectionFormat &&
        schemaRows.length
      ) {
        rows.push(...schemaRows);
      } else {
        rows.push({
          area: headerArea,
          before: responseHeaderDisplay(previousHeader, "not present"),
          after: responseHeaderDisplay(currentHeader, "removed"),
        });
      }
    }
  }
  return rows;
}

/**
 * @param {unknown} before
 * @param {unknown} after
 * @param {string} area
 * @returns {ContractChangeRow[]}
 */
function simpleContractRows(before, after, area) {
  if (contractValueEqual(before, after)) return [];
  const beforeObject = isRecord(before) ? before : undefined;
  const afterObject = isRecord(after) ? after : undefined;
  if (beforeObject || afterObject) {
    /** @type {ContractChangeRow[]} */
    const rows = [];
    for (const key of [
      ...new Set([...Object.keys(beforeObject ?? {}), ...Object.keys(afterObject ?? {})]),
    ].sort()) {
      rows.push(...simpleContractRows(beforeObject?.[key], afterObject?.[key], `${area}.${key}`));
    }
    if (rows.length) return rows;
  }
  /** @param {unknown} value @param {string} missing */
  const display = (value, missing) => {
    if (value === undefined) return missing;
    if (typeof value === "string") return value;
    return JSON.stringify(value);
  };
  return [
    {
      area,
      before: display(before, "not present"),
      after: display(after, "removed"),
    },
  ];
}

/**
 * @param {AssessmentOperation} operation
 * @returns {ContractChangeRow[]}
 */
function structuralOperationRows(operation) {
  /** @param {AssessmentFact | undefined} value */
  const operationExists = (value) =>
    Boolean(
      value &&
      (value.method ||
        value.path ||
        value.request ||
        value.parameters?.length ||
        value.responses?.length),
    );
  const beforeExists = operationExists(operation.before);
  const afterExists = operationExists(operation.after);
  if (beforeExists !== afterExists) {
    /** @param {AssessmentFact | undefined} value @param {string} missing */
    const display = (value, missing) =>
      [value?.method?.toUpperCase(), value?.path].filter(Boolean).join(" ") || missing;
    return [
      {
        area: "operation",
        before: display(operation.before, "not present"),
        after: display(operation.after, "removed"),
      },
    ];
  }

  /** @type {ContractChangeRow[]} */
  const rows = [];
  for (const field of operation.changedAspects ?? []) {
    const before = operation.before?.[field];
    const after = operation.after?.[field];
    if (field === "parameters") {
      rows.push(
        ...parameterContractRows(operation.before?.parameters, operation.after?.parameters),
      );
    } else if (field === "request") {
      rows.push(...requestContractRows(operation.before?.request, operation.after?.request));
    } else if (field === "responses") {
      rows.push(...responseContractRows(operation.before?.responses, operation.after?.responses));
    } else if (field === "paging" || field === "lro") {
      rows.push(...simpleContractRows(before, after, field));
    } else if (field === "operation") {
      rows.push({
        area: field,
        before: operation.before
          ? `${operation.before.method?.toUpperCase()} ${operation.before.path}`
          : "not present",
        after: operation.after
          ? `${operation.after.method?.toUpperCase()} ${operation.after.path}`
          : "removed",
      });
    } else {
      rows.push({
        area: field,
        before: contractSummary(before, field),
        after: contractSummary(after, field),
      });
    }
  }
  return rows.filter((row) => row.before !== row.after);
}

/**
 * @param {AssessmentOperation} operation
 * @param {AssessmentFinding[]} [restFindings]
 * @param {string} [semanticIntentId]
 * @returns {ContractChangeRow[]}
 */
export function operationContractRows(operation, restFindings = [], semanticIntentId) {
  const detailedRows = restFindings
    .filter((finding) => findingMatchesOperation(finding, operation, semanticIntentId))
    .map(restContractDelta);
  const rows = detailedRows.length ? detailedRows : structuralOperationRows(operation);
  return [
    ...new Map(
      rows
        .filter((row) => row.before !== row.after)
        .sort(
          (left, right) =>
            left.area.localeCompare(right.area) ||
            left.before.localeCompare(right.before) ||
            left.after.localeCompare(right.after),
        )
        .map((row) => [`${row.area}\u0000${row.before}\u0000${row.after}`, row]),
    ).values(),
  ];
}

/** @param {ContractChangeRow[]} rows */
function renderContractChangeRows(rows) {
  return rows
    .map((row) => {
      const { before, after } = row;
      const afterValue = after === "removed" ? "removed" : after;
      return `<tr>${renderContractAreaCell(row)}<td class="contract-before"><code class="contract-value before">${escapeHtml(before)}</code></td><td class="contract-after"><code class="contract-value after">${escapeHtml(afterValue)}</code></td></tr>`;
    })
    .join("");
}

/** @param {ContractAreaInput} row */
function contractAreaParts(row) {
  if (row.areaKind) {
    return {
      areaKind: row.areaKind,
      member: row.member ?? row.area ?? "contract",
    };
  }
  const area = row.area ?? row.member ?? "contract";
  let match = area.match(/^response\s+([^.\s]+)\.header:(.+)$/i);
  if (match) {
    return {
      areaKind: "Response header",
      member: `${match[1]} · ${match[2]}`,
    };
  }
  match = area.match(/^response\s+([^.\s]+)\.body(?:\.(.+))?$/i);
  if (match) {
    return {
      areaKind: match[2] ? "Response body property" : "Response body",
      member: match[2] ? `${match[1]} · ${match[2]}` : match[1],
    };
  }
  match = area.match(/^response\s+([^.\s]+)\.(.+)$/i);
  if (match) {
    return {
      areaKind: "Response body property",
      member: `${match[1]} · ${match[2]}`,
    };
  }
  match = area.match(/^response\s+(\S+)$/i);
  if (match) return { areaKind: "Response status", member: match[1] };
  match = area.match(/^request body(?:\.(.+))?$/i);
  if (match) {
    return {
      areaKind: match[1] ? "Request body property" : "Request body",
      member: match[1] ?? "body",
    };
  }
  match = area.match(/^(query|path|header):(.+)$/i);
  if (match) {
    /** @type {Record<string, string>} */
    const kinds = {
      query: "Query parameter",
      path: "Path parameter",
      header: "Request header",
    };
    return {
      areaKind: kinds[match[1].toLowerCase()],
      member: match[2],
    };
  }
  match = area.match(/^lro(?:\.(.+))?$/i);
  if (match) return { areaKind: "LRO", member: match[1] ?? "behavior" };
  match = area.match(/^paging(?:\.(.+))?$/i);
  if (match) return { areaKind: "Paging", member: match[1] ?? "behavior" };
  if (area === "method") return { areaKind: "Method", member: "HTTP method" };
  if (area === "path") return { areaKind: "Path", member: "request path" };
  if (area === "operation") return { areaKind: "Operation", member: "operation" };
  return { areaKind: "Contract area", member: area };
}

/** @param {ContractAreaInput} row */
function renderContractAreaCell(row) {
  const { areaKind, member } = contractAreaParts(row);
  return `<td class="contract-member"><span class="contract-area-kind">${escapeHtml(areaKind)}</span><code>${escapeHtml(member)}</code></td>`;
}

/** @param {AssessmentFinding[]} [findings] @returns {RestContractCard[]} */
export function restContractCards(findings = []) {
  /** @type {Map<string, RestContractCard>} */
  const cards = new Map();
  /** @type {Record<string, number>} */
  const severityOrder = { critical: 4, high: 3, medium: 2, low: 1 };
  for (const finding of findings) {
    const delta = restContractDelta(finding);
    let card = cards.get(delta.identity);
    if (!card) {
      card = {
        identity: delta.identity,
        severity: finding.severity,
        findings: [],
        operations: [],
        relatedSemanticIntents: [],
        sources: [],
      };
      cards.set(delta.identity, card);
    }
    card.findings.push({ ...finding, contractDelta: delta });
    card.relatedSemanticIntents.push(...(finding.relatedSemanticIntents ?? []));
    card.sources.push(...(finding.sources ?? []));
    const { before, after } = operationFacts(finding);
    for (const operationId of finding.operationIds ?? []) {
      const fact = [after, before].find((item) => item?.operationId === operationId);
      card.operations.push({
        operationId,
        apiVersion: fact?.apiVersion,
        method: fact?.method,
        path: fact?.path,
      });
    }
    if ((severityOrder[finding.severity] ?? 0) > (severityOrder[card.severity] ?? 0)) {
      card.severity = finding.severity;
    }
  }
  return [...cards.values()]
    .map((card) => {
      card.operations = [
        ...new Map(
          card.operations.map((operation) => [
            `${operation.operationId}:${operation.apiVersion ?? ""}`,
            operation,
          ]),
        ).values(),
      ];
      card.relatedSemanticIntents = [...new Set(card.relatedSemanticIntents)];
      card.sources = [
        ...new Map(card.sources.map((source) => [source.id ?? source.path, source])).values(),
      ];
      return card;
    })
    .sort((left, right) => left.identity.localeCompare(right.identity));
}

/** @param {unknown[]} evidence */
function legacyEvidence(evidence) {
  /** @type {{operation?: string, impact?: string, apiVersion?: string, method?: string, path?: string}} */
  const details = {};
  /** @type {string[]} */
  const remaining = [];
  for (const rawItem of evidence) {
    const item = displayValue(rawItem);
    const parameter = item.match(/^(.+) changed (\d+) parameter contract\(s\)\.$/);
    if (parameter) {
      details.operation = parameter[1];
      const count = Number(parameter[2]);
      details.impact = `${count} parameter contract${count === 1 ? "" : "s"} changed`;
      continue;
    }
    const response = item.match(/^(.+) changed an existing response contract\.$/);
    if (response) {
      details.operation = response[1];
      details.impact = "Existing response contract changed";
      continue;
    }
    const request = item.match(/^Compared REST operation:\s*([^:]+):([A-Z]+):(.*)\.$/i);
    if (request) {
      details.apiVersion = request[1];
      details.method = request[2].toUpperCase();
      details.path = request[3].startsWith("?") ? `/${request[3]}` : request[3];
      continue;
    }
    remaining.push(item);
  }
  const operationDetails = Object.keys(details).length
    ? `<dl class="legacy-operation-evidence">
${details.operation ? `<dt>Affected operation</dt><dd><code>${escapeHtml(details.operation)}</code></dd>` : ""}
${details.apiVersion ? `<dt>API version</dt><dd><code>${escapeHtml(details.apiVersion)}</code></dd>` : ""}
${details.method ? `<dt>HTTP request</dt><dd><code>${escapeHtml(details.method)} ${escapeHtml(details.path)}</code></dd>` : ""}
${details.impact ? `<dt>Contract impact</dt><dd>${escapeHtml(details.impact)}</dd>` : ""}
</dl>`
    : "";
  const otherEvidence = remaining.length
    ? `<p><strong>Evidence:</strong></p><ul>${remaining.map((item) => `<li>${escapeHtml(item)}</li>`).join("")}</ul>`
    : "";
  return `${operationDetails}${otherEvidence}`;
}

/**
 * @param {LegacyAssessmentFinding[]} [findings]
 * @param {boolean} [downstream]
 */
function legacyFindingCards(findings = [], downstream = false) {
  return findings
    .map((finding) => {
      const omittedRestEvidence =
        downstream && finding.evidence?.some((item) => /^Approved REST finding:/i.test(item));
      const evidence = (finding.evidence ?? []).filter(
        (item) => !downstream || !/^Approved REST finding:/i.test(item),
      );
      const summary = downstream
        ? (finding.summary ?? "").replace(
            /^The approved REST contract changes/i,
            "The REST breaking changes",
          )
        : (finding.summary ?? "");
      return `<details class="finding" id="${downstream ? "downstream" : "finding"}-${anchor(finding.id)}">
<summary><strong>${escapeHtml(finding.title)}</strong></summary>
<div class="finding-body">
<p>${escapeHtml(summary)}</p>
${legacyEvidence(evidence)}
${omittedRestEvidence ? '<p class="sources">REST finding details are omitted here; see <a href="#rest-breaking">REST breaking changes</a>.</p>' : ""}
<p><strong>Related semantic intents:</strong> ${semanticLinks(finding.relatedSemanticIntents)}</p>
${downstream ? "" : `<p class="sources"><strong>Changed TypeSpec:</strong> ${sourceLinks(finding.sources)}</p>`}
</div></details>`;
    })
    .join("\n");
}

/**
 * @template {AssessmentFinding | LegacyAssessmentFinding} T
 * @param {T[]} [findings]
 * @returns {T[]}
 */
function directLegacyDownstreamFindings(findings = []) {
  return findings.filter(
    (finding) =>
      !finding.evidence?.some((item) => /^Approved REST finding:/i.test(displayValue(item))),
  );
}

/** @param {AssessmentTypeImpact[]} [impacts] */
export function visibleSharedTypeImpacts(impacts = []) {
  return impacts.filter(
    (impact) => (impact.findingIds?.length ?? 0) > 0 || (impact.affectedMethodCount ?? 0) > 0,
  );
}

/** @param {AssessmentOutput["dimensions"]["downstream"]} dimension */
export function downstreamTypeCards(dimension) {
  const findingsById = new Map((dimension.findings ?? []).map((finding) => [finding.id, finding]));
  /** @type {Map<string, DownstreamTypeCard>} */
  const cards = new Map();
  const impacts = dimension.typeImpacts ?? dimension.sharedTypeImpacts ?? [];
  for (const impact of visibleSharedTypeImpacts(impacts)) {
    const types = impact.type ? [impact.type] : [...new Set(impact.types ?? [])].sort();
    for (const [index, type] of types.entries()) {
      let card = cards.get(type);
      if (!card) {
        card = {
          type,
          findings: [],
          relatedSemanticIntents: [],
          affectedMethods: [],
          locations: [],
          rootCauses: [],
          legacyImpactIds: [],
        };
        cards.set(type, card);
      }
      const matchedFindings = (impact.findingIds ?? []).flatMap((id) => {
        const finding = findingsById.get(id);
        return finding?.crossLanguageDefinitionId === type ? [finding] : [];
      });
      card.findings.push(...matchedFindings);
      card.relatedSemanticIntents.push(
        ...matchedFindings.flatMap((finding) => finding.relatedSemanticIntents ?? []),
      );
      if (types.length === 1 && !matchedFindings.length) {
        card.relatedSemanticIntents.push(...(impact.relatedSemanticIntents ?? []));
      }
      card.affectedMethods.push(...(impact.affectedMethods ?? []));
      card.locations.push(...(impact.locations ?? []));
      for (const id of impact.rootCauseIds ?? [impact.rootCauseId]) {
        if (!id) continue;
        card.rootCauses.push({
          id,
          kind: typeof impact.rootCause === "string" ? impact.rootCause : undefined,
          summary: impact.summary,
        });
      }
      if (index === 0) card.legacyImpactIds.push(impact.id);
    }
  }
  /** @type {Record<string, number>} */
  const severityOrder = { critical: 4, high: 3, medium: 2, low: 1 };
  return [...cards.values()]
    .map((card) => {
      card.findings = [...new Map(card.findings.map((finding) => [finding.id, finding])).values()];
      card.relatedSemanticIntents = [...new Set(card.relatedSemanticIntents)];
      card.locations = [...new Set(card.locations)].sort();
      card.affectedMethods = [
        ...new Map(card.affectedMethods.map((method) => [method.symbol, method])).values(),
      ];
      card.rootCauses = [
        ...new Map(card.rootCauses.map((rootCause) => [rootCause.id, rootCause])).values(),
      ];
      card.legacyImpactIds = [...new Set(card.legacyImpactIds)];
      card.severity = card.findings.reduce(
        (highest, finding) =>
          (severityOrder[finding.severity] ?? 0) > (severityOrder[highest] ?? 0)
            ? finding.severity
            : highest,
        "high",
      );
      return card;
    })
    .sort((left, right) => left.type.localeCompare(right.type));
}

/** @param {unknown} value @param {string} field */
function contractSummary(value, field) {
  if (value === undefined) return "—";
  if (field === "parameters") {
    if (!Array.isArray(value)) return "None";
    return (
      value
        .filter(isRecord)
        .map(
          (item) =>
            `${displayValue(item.in ?? "body")}:${displayValue(item.name)}${item.required ? " (required)" : ""}`,
        )
        .join(", ") || "None"
    );
  }
  if (field === "responses") {
    if (!Array.isArray(value)) return "None";
    return (
      value
        .filter(isRecord)
        .map((item) => item.status)
        .join(", ") || "None"
    );
  }
  if (field === "request") return isRecord(value) ? displayValue(value.kind ?? "present") : "None";
  if (field === "paging" || field === "lro") return value ? "present" : "None";
  return displayValue(value);
}

/** @param {SourceChange[]} [sources] */
function renderSourceHunks(sources = []) {
  return sources
    .flatMap((source) =>
      (source.hunks ?? []).map(
        (hunk) =>
          `<div class="diff"><div class="diff-path">${escapeHtml(source.path)}</div><pre>${(
            hunk.lines ?? []
          )
            .map((line) => {
              const kind = line.startsWith("+")
                ? "add"
                : line.startsWith("-")
                  ? "remove"
                  : "context";
              return `<span class="${kind}">${escapeHtml(line)}</span>`;
            })
            .join("\n")}</pre></div>`,
      ),
    )
    .join("");
}

/** @param {DiffHunk} hunk */
function substantiveChange(hunk) {
  return (hunk.lines ?? []).some((line) => {
    if (!line.startsWith("+") && !line.startsWith("-")) return false;
    const code = line.slice(1).trim();
    return code && !/^import\s/.test(code) && !/^using\s/.test(code);
  });
}

/** @param {SourceChange} source @param {DiffHunk} hunk */
function sourceStartLine(source, hunk) {
  const hunkStartLine = hunk.current?.startLine ?? hunk.base?.startLine;
  if (Number.isFinite(hunkStartLine)) return hunkStartLine;
  const declarationLines = (source.declarations ?? [])
    .flatMap((declaration) =>
      declaration.hunkIds?.includes(hunk.id) ? [declaration.source?.startLine] : [],
    )
    .filter(Number.isFinite);
  return Math.min(...declarationLines, Number.MAX_SAFE_INTEGER);
}

/** @param {AssessmentSemanticItem} item */
export function representativeSource(item) {
  const operationHunkIds = new Set(
    (item.operations ?? []).flatMap((operation) =>
      (operation.sources ?? []).flatMap((source) => (source.hunks ?? []).map((hunk) => hunk.id)),
    ),
  );
  const candidates = (item.sources ?? []).flatMap((source) =>
    (source.hunks ?? []).map((hunk) => {
      const declaration = (source.declarations ?? []).some((item) =>
        item.hunkIds?.includes(hunk.id),
      );
      return {
        source,
        hunk,
        score: [
          operationHunkIds.has(hunk.id) ? 1 : 0,
          declaration ? 1 : 0,
          substantiveChange(hunk) ? 1 : 0,
        ],
        startLine: sourceStartLine(source, hunk),
      };
    }),
  );
  candidates.sort((left, right) => {
    for (let index = 0; index < left.score.length; index += 1) {
      if (left.score[index] !== right.score[index]) {
        return right.score[index] - left.score[index];
      }
    }
    return (
      String(left.source.path ?? "").localeCompare(String(right.source.path ?? "")) ||
      left.startLine - right.startLine ||
      String(left.hunk.id ?? "").localeCompare(String(right.hunk.id ?? ""))
    );
  });
  if (!candidates.length) return undefined;
  const selected = candidates[0];
  return {
    ...selected.source,
    hunks: [selected.hunk],
    declarations: (selected.source.declarations ?? []).filter((declaration) =>
      declaration.hunkIds?.includes(selected.hunk.id),
    ),
  };
}

/** @param {AssessmentSemanticItem} item */
function representativeExample(item) {
  const source = representativeSource(item);
  if (!source) {
    return '<p class="sources">No representative TypeSpec example available.</p>';
  }
  return `<details class="representative-example"><summary><strong>Representative TypeSpec example</strong></summary>
${renderSourceHunks([source])}
<p class="sources"><strong>Source:</strong> ${sourceLinks([source])}.</p></details>`;
}

/**
 * @param {AssessmentOperation} operation
 * @param {AssessmentFinding[]} restFindings
 * @param {string} semanticIntentId
 */
function operationCard(operation, restFindings, semanticIntentId) {
  const unchangedOutcome = "HTTP signature and represented payload contract unchanged.";
  const rows = operationContractRows(operation, restFindings, semanticIntentId);
  const changes = rows.length
    ? `<table class="contract-change-table"><thead><tr><th>Contract area</th><th>Before</th><th>After</th></tr></thead><tbody>${renderContractChangeRows(rows)}</tbody></table>`
    : `<p class="good"><strong>${unchangedOutcome}</strong></p>`;
  const outcome = rows.length ? operation.outcome : unchangedOutcome;
  return `<details class="operation"><summary><strong>${escapeHtml(operation.operationId)}</strong> <code>${escapeHtml((operation.method ?? "").toUpperCase())} ${escapeHtml(operation.path)}</code> <span>${escapeHtml(operation.apiVersion)}</span></summary>
<div class="operation-body">${changes}
<p><strong>Change outcome:</strong> ${escapeHtml(outcome)}</p></div></details>`;
}

/**
 * @param {AssessmentSemanticItem} item
 * @param {FinalComplianceAssessment} compliance
 * @param {AssessmentOutput["dimensions"]["downstream"]} downstream
 * @returns {SemanticFindingReference[]}
 */
function semanticFindingReferences(item, compliance, downstream) {
  const complianceIds = new Set([
    ...(item.relatedFindings?.compliance ?? []),
    ...(compliance.findings ?? [])
      .filter(
        (finding) =>
          finding.semanticIntentId === item.id || finding.relatedSemanticIntents?.includes(item.id),
      )
      .map((finding) => finding.id),
  ]);
  const downstreamIds = new Set([
    ...(item.relatedFindings?.downstream ?? []),
    ...(item.relatedFindings?.typeImpact ?? []),
    ...(item.relatedFindings?.sharedTypeImpact ?? []),
  ]);
  const methodGroups = downstream.methodGroups ?? downstream.operationGroups ?? [];
  const typeImpacts = downstream.typeImpacts ?? downstream.sharedTypeImpacts ?? [];
  /** @type {Map<string, {title: string, detail: string}>} */
  const downstreamItems = new Map();
  for (const group of methodGroups) {
    downstreamItems.set(group.id, {
      title: group.symbol?.split(".").at(-1) ?? group.symbol ?? group.id,
      detail: "SDK method",
    });
  }
  for (const impact of typeImpacts) {
    const type = impact.type ?? impact.types?.[0] ?? impact.id;
    const findings = impact.findingIds?.length ?? 0;
    downstreamItems.set(impact.id, {
      title: type.split(".").at(-1) ?? type,
      detail: `${findings} ${findings === 1 ? "change" : "changes"}`,
    });
  }
  /** @type {SemanticFindingReference[]} */
  const references = [];
  for (const id of item.relatedFindings?.rest ?? []) {
    references.push({
      id,
      kind: "rest",
      href: `#finding-${anchor(id)}`,
    });
  }
  for (const id of downstreamIds) {
    references.push({
      id,
      kind: "downstream",
      href: `#downstream-${anchor(id)}`,
      ...(downstreamItems.get(id) ?? { title: id, detail: "SDK contract" }),
    });
  }
  for (const id of complianceIds) {
    references.push({
      id,
      kind: "compliance",
      href: `#compliance-finding-${anchor(id)}`,
    });
  }
  return references;
}

/**
 * @param {SemanticFindingReference[]} references
 * @param {string} intentId
 */
function semanticFindingBadge(references, intentId) {
  /** @type {Record<SemanticFindingReference["kind"], string>} */
  const labels = {
    rest: "REST breaking changes",
    downstream: "Downstream breaking changes",
    compliance: "Azure Guidelines",
  };
  /** @type {Map<SemanticFindingReference["kind"], SemanticFindingReference[]>} */
  const grouped = new Map();
  for (const reference of references) {
    const values = grouped.get(reference.kind) ?? [];
    values.push(reference);
    grouped.set(reference.kind, values);
  }
  return grouped.size
    ? `<span class="intent-finding-badges">${[...grouped]
        .map(([kind, values]) => {
          if (kind !== "downstream") {
            return `<a class="intent-finding-badge ${kind}" href="${values[0].href}">${labels[kind]}${kind === "rest" ? ` (${values.length})` : ""}</a>`;
          }
          const popoverId = `downstream-impact-popover-${anchor(intentId)}`;
          return `<span class="intent-impact-trigger"><button class="intent-finding-badge downstream" type="button" aria-expanded="false" aria-controls="${popoverId}">Downstream breaking changes (${values.length})</button><span class="intent-impact-popover" id="${popoverId}">${values
            .map(
              (reference) =>
                `<a href="${reference.href}"><strong>${escapeHtml(reference.title)}</strong><span>${escapeHtml(reference.detail)}</span></a>`,
            )
            .join("")}</span></span>`;
        })
        .join("")}</span>`
    : "";
}

/**
 * @param {AssessmentSemanticItem} item
 * @param {FinalComplianceAssessment} compliance
 * @param {AssessmentFinding[]} restFindings
 * @param {AssessmentOutput["dimensions"]["downstream"]} downstream
 */
function semanticCard(item, compliance, restFindings, downstream) {
  const all = item.operations ?? [];
  const shown = all.slice(0, 3);
  const operationContent = all.length
    ? shown.map((operation) => operationCard(operation, restFindings, item.id)).join("\n")
    : '<p class="empty">No directly affected REST operation.</p>';
  const findingReferences = semanticFindingReferences(item, compliance, downstream);
  return `<details class="intent" id="intent-${anchor(item.id)}"><summary><strong><span class="action">${escapeHtml(item.action)}</span> ${escapeHtml(item.title)}</strong>${semanticFindingBadge(findingReferences, item.id)}</summary><div class="intent-body">
<p>${escapeHtml(item.summary)}</p>
${representativeExample(item)}
<h3>Affected REST operations (${all.length})</h3>
${operationContent}
</div></details>`;
}

/**
 * @param {AssessmentOutput["dimensions"]["downstream"]} dimension
 */
function downstreamOperationGroups(dimension) {
  /** @type {Record<string, string>} */
  const labels = {
    kind: "Method kind",
    parameters: "Parameters",
    responseType: "Response type",
    access: "Access",
    paging: "Paging",
    lro: "Long-running behavior",
    client: "Client",
  };
  /** @param {unknown} item */
  const value = (item) => (typeof item === "string" ? item : (JSON.stringify(item) ?? ""));
  /** @param {AssessmentMethodParameterChanges} changes */
  const parameterSummary = (changes) => {
    const parts = [
      ["added", changes.added?.length],
      ["removed", changes.removed?.length],
      ["modified", changes.modified?.length],
      ["reordered", changes.reordered?.length],
      ["unchanged", changes.unchangedCount],
    ].filter(([, count]) => count);
    return parts.map(([label, count]) => `${count} ${label}`).join(", ") || "unchanged";
  };
  /**
   * @param {string} cellValue
   * @param {string | undefined} detail
   * @param {string} kind
   */
  const contractCell = (cellValue, detail, kind) =>
    `<code class="contract-value ${kind}">${escapeHtml(cellValue)}</code>${detail ? `<span class="contract-detail">${escapeHtml(detail)}</span>` : ""}`;
  /** @param {SdkType | string | undefined} type */
  const sdkTypeName = (type) => {
    if (!type) return "unknown";
    if (typeof type === "string") return type;
    return type.name ?? type.id ?? type.kind ?? "unknown";
  };
  /** @param {AssessmentParameter} parameter */
  const parameterType = (parameter) =>
    `${sdkTypeName(parameter.type)}${parameter.optional ? "?" : ""}`;
  /** @param {AssessmentParameter} parameter */
  const parameterName = (parameter) => parameter.name ?? "parameter";
  /**
   * @param {string} parameterName
   * @param {AssessmentMethodGroup} group
   */
  const methodParameterAreaKind = (parameterName, group) => {
    /** @type {Set<string>} */
    const locations = new Set();
    for (const method of [group.before, group.after]) {
      const protocolParameters = [
        ...(method?.operation?.parameters ?? []),
        ...(method?.operation?.bodyParam ? [method.operation.bodyParam] : []),
      ];
      for (const parameter of protocolParameters) {
        const segments = (parameter.methodParameterSegments ?? []).flat(Infinity).map(displayValue);
        if (parameter.name === parameterName || segments.includes(parameterName)) {
          if (parameter.kind) locations.add(parameter.kind);
        }
      }
    }
    if (locations.size !== 1) return "Method parameter";
    const location = [...locations][0];
    /** @type {Record<string, string>} */
    const labels = {
      query: "query",
      path: "path",
      header: "header",
      body: "body",
    };
    return labels[location] ? `Request ${labels[location]}` : "Method parameter";
  };
  /**
   * @param {AssessmentMethodGroup} group
   * @returns {ContractRow[]}
   */
  const methodContractRows = (group) =>
    group.deltas.flatMap((delta) => {
      const field = delta.field ?? "";
      if (delta.field !== "parameters") {
        return [
          {
            areaKind: labels[field] ?? "SDK method",
            member: labels[field] ?? delta.rule ?? "SDK method",
            before: value(delta.before),
            after: value(delta.after),
          },
        ];
      }
      const changes = delta.changes ?? {};
      return [
        ...(changes.removed ?? []).map((item) => ({
          areaKind: methodParameterAreaKind(parameterName(item.parameter), group),
          member: parameterName(item.parameter),
          before: parameterType(item.parameter),
          beforeDetail: "Existing method parameter",
          after: "not present",
        })),
        ...(changes.added ?? []).map((item) => ({
          areaKind: methodParameterAreaKind(parameterName(item.parameter), group),
          member: parameterName(item.parameter),
          before: "not present",
          beforeDetail: "Existing generated method signature",
          after: parameterType(item.parameter),
          afterDetail: item.parameter.optional
            ? "Optional method parameter"
            : "Required method parameter",
        })),
        ...(changes.modified ?? []).map((item) => ({
          areaKind: methodParameterAreaKind(item.name, group),
          member: item.name,
          before: parameterType(item.before),
          beforeDetail: `Changed: ${item.changedFields.join(", ")}`,
          after: parameterType(item.after),
          afterDetail: `Changed: ${item.changedFields.join(", ")}`,
        })),
        ...(changes.reordered ?? []).map((item) => ({
          areaKind: methodParameterAreaKind(item.name, group),
          member: item.name,
          before: `position ${item.beforeIndex + 1}`,
          after: `position ${item.afterIndex + 1}`,
        })),
      ];
    });
  const methodGroups = dimension.methodGroups ?? dimension.operationGroups ?? [];
  const groups = methodGroups
    .map((group) => {
      const rows = methodContractRows(group);
      const parameterDelta = group.deltas.find((delta) => delta.field === "parameters");
      const addedParameters = parameterDelta?.changes?.added ?? [];
      const changeSummary =
        group.deltas.length === 1 && addedParameters.length === 1 && rows.length === 1
          ? `An ${addedParameters[0].parameter.optional ? "optional" : "required"} parameter was added to the generated public method signature`
          : `${rows.length} generated SDK method contract ${rows.length === 1 ? "member changed" : "members changed"}`;
      const rationale = [
        ...new Set(group.deltas.map((delta) => delta.rationale).filter(Boolean)),
      ].join(" ");
      const parameterDetail = parameterDelta
        ? parameterSummary(parameterDelta.changes ?? {})
        : group.parametersUnchanged
          ? "unchanged"
          : "changed";
      return `<details class="finding sdk-method-card" id="downstream-${anchor(group.id)}"><summary><strong>${escapeHtml(group.symbol.split(".").at(-1) ?? group.symbol)}</strong><span class="contract-tag">SDK method</span></summary>
<div class="finding-body">
<dl class="contract-metadata"><dt>SDK method:</dt><dd><code>${escapeHtml(group.symbol)}</code></dd><dt>Change:</dt><dd>${escapeHtml(changeSummary)}</dd></dl>
<h4>Breaking changes</h4>
<table class="contract-change-table"><thead><tr><th>Contract area</th><th>Before</th><th>After</th></tr></thead><tbody>${rows
        .map(
          (row) =>
            `<tr>${renderContractAreaCell(row)}<td class="contract-before">${contractCell(row.before, row.beforeDetail, "before")}</td><td class="contract-after">${contractCell(row.after, row.afterDetail, "after")}</td></tr>`,
        )
        .join("")}</tbody></table>
${rationale ? `<div class="breaking-rationale"><strong>Why this is breaking:</strong> ${escapeHtml(rationale)}</div>` : ""}
<div class="contract-footer"><span><strong>Parameters:</strong> ${escapeHtml(parameterDetail)}</span><span><strong>Related semantic intents:</strong> ${semanticLinks(group.relatedSemanticIntents)}</span></div>
</div></details>`;
    })
    .join("\n");
  const groupedFindingIds = new Set(
    methodGroups.flatMap((group) => group.deltas.map((delta) => delta.findingId)),
  );
  /** @param {string} type */
  const shortTypeName = (type) => type.split(".").at(-1) ?? type;
  /** @param {AssessmentFact | undefined} fact */
  const enumShape = (fact) => {
    if (!fact) return "unknown";
    if (fact.isFixed) return "fixed enum";
    if (fact.isUnionAsEnum) return "extensible enum";
    return "enum";
  };
  /** @param {DownstreamTypeCard} card @returns {ContractRow[]} */
  const enumContractRows = (card) => {
    const enumFinding = card.findings.find((finding) =>
      finding.evidence?.some((fact) => fact.factKind === "enum"),
    );
    if (!enumFinding) return [];
    const before = enumFinding.evidence.find(
      (fact) => fact.factKind === "enum" && fact.comparisonRole === "baseline",
    );
    const after = enumFinding.evidence.find(
      (fact) => fact.factKind === "enum" && fact.comparisonRole === "target",
    );
    if (!before || !after) return [];

    /** @type {ContractRow[]} */
    const rows = [];
    if (enumShape(before) !== enumShape(after)) {
      rows.push({
        kind: "shape",
        areaKind: "Enum shape",
        member: shortTypeName(card.type),
        before: enumShape(before),
        beforeDetail: before.isFixed ? "Only declared values are represented." : undefined,
        after: enumShape(after),
        afterDetail: after.isUnionAsEnum ? "Unknown service values are accepted." : undefined,
      });
    }
    const beforeByValue = new Map((before.values ?? []).map((item) => [String(item.value), item]));
    const afterByValue = new Map((after.values ?? []).map((item) => [String(item.value), item]));
    for (const [wireValue, previous] of beforeByValue) {
      const current = afterByValue.get(wireValue);
      if (current && current.name !== previous.name) {
        const previousName = previous.name ?? wireValue;
        const currentName = current.name ?? wireValue;
        rows.push({
          kind: "member",
          areaKind: "Enum member",
          member: `${shortTypeName(card.type)}.${previousName}`,
          before: previousName,
          beforeDetail: "Generated public member identity",
          after: currentName,
          afterDetail: `Wire value remains ${JSON.stringify(wireValue)}.`,
        });
      } else if (!current) {
        const previousName = previous.name ?? wireValue;
        rows.push({
          kind: "member",
          areaKind: "Enum member",
          member: `${shortTypeName(card.type)}.${previousName}`,
          before: previousName,
          beforeDetail: `Wire value ${JSON.stringify(wireValue)}.`,
          after: "removed",
        });
      }
    }
    return rows;
  };
  /** @param {SdkType | string | undefined} type @returns {string} */
  const typeDisplay = (type) => {
    if (!type) return "unknown";
    if (typeof type === "string") return type;
    if (type.kind === "array") return `${typeDisplay(type.valueType ?? type.items)}[]`;
    if (type.kind === "dictionary") {
      return `Record<string, ${typeDisplay(type.valueType)}>`;
    }
    if (type.kind === "nullable") return `${typeDisplay(type.type)}?`;
    return (
      type.name ??
      (type.id ? shortTypeName(type.id) : undefined) ??
      (type.type ? typeDisplay(type.type) : undefined) ??
      type.kind ??
      "unknown"
    );
  };
  /** @param {AssessmentProperty | undefined} property */
  const propertyDisplay = (property) =>
    property
      ? `${typeDisplay(property.type ?? property.schema)}${property.optional ? "?" : ""}`
      : undefined;
  /** @param {AssessmentFinding} finding */
  const typeFacts = (finding) => ({
    before: finding.evidence?.find(
      (fact) => fact.factKind === "model" && fact.comparisonRole === "baseline",
    ),
    after: finding.evidence?.find(
      (fact) => fact.factKind === "model" && fact.comparisonRole === "target",
    ),
  });
  /** @param {AssessmentFinding} finding */
  const propertyName = (finding) =>
    finding.actual?.match(/\bproperty\s+([A-Za-z_$][\w$]*)\b/)?.[1] ??
    finding.expected?.match(/\bproperty\s+([A-Za-z_$][\w$]*)\b/)?.[1];
  /** @param {DownstreamTypeCard} card */
  const typePropertyAreaKind = (card) => {
    if (card.locations.length !== 1) return "Model property";
    /** @type {Record<string, string>} */
    const labels = {
      "request-path": "Request path",
      "request-query": "Request query",
      "request-header": "Request header",
      "request-body": "Request body",
      "response-header": "Response header",
      "response-body": "Response body",
    };
    return labels[card.locations[0]] ?? "Model property";
  };
  /**
   * @param {DownstreamTypeCard} card
   * @param {AssessmentFinding[]} findings
   * @returns {ContractRow[]}
   */
  const modelContractRows = (card, findings) =>
    findings.flatMap((finding) => {
      const name = propertyName(finding);
      const { before, after } = typeFacts(finding);
      if (!name || (!before && !after)) return [];
      const beforeProperty = before?.properties?.find((property) => property.name === name);
      const afterProperty = after?.properties?.find((property) => property.name === name);
      return [
        {
          areaKind: typePropertyAreaKind(card),
          member: name,
          before: propertyDisplay(beforeProperty) ?? "not present",
          after: propertyDisplay(afterProperty) ?? "removed",
        },
      ];
    });
  /**
   * @param {DownstreamTypeCard} card
   * @param {AssessmentFinding[]} findings
   * @returns {ContractRow[]}
   */
  const publicSurfaceRows = (card, findings) =>
    findings.flatMap((finding) => {
      if (finding.rule !== "public-surface-changed") return [];
      const before = finding.evidence?.find((fact) => fact.comparisonRole === "baseline");
      const after = finding.evidence?.find((fact) => fact.comparisonRole === "target");
      /** @param {AssessmentFact | undefined} fact */
      const display = (fact) =>
        fact
          ? [
              fact.access,
              fact.reachable === true ? "reachable" : undefined,
              fact.reachable === false ? "not reachable" : undefined,
              fact.usage !== undefined ? `usage ${fact.usage.join(", ")}` : undefined,
            ]
              .filter(Boolean)
              .join(" · ")
          : "removed";
      return [
        {
          areaKind: "SDK type availability",
          member: shortTypeName(card.type),
          before: display(before),
          after: display(after),
        },
      ];
    });
  /**
   * @param {DownstreamTypeCard} card
   * @param {AssessmentFinding[]} findings
   * @returns {ContractRow[]}
   */
  const clientLocationRows = (card, findings) =>
    findings.flatMap((finding) => {
      if (finding.rule !== "client-location-changed") return [];
      const target =
        finding.actual?.match(/\bunder\s+([A-Za-z0-9_.]+)\b/)?.[1] ??
        finding.actual?.match(/\bto\s+([A-Za-z0-9_.]+)\b/)?.[1] ??
        "changed client";
      const language = finding.actual?.match(/\bgenerated\s+([A-Za-z0-9+#.]+)\s+client/i)?.[1];
      return [
        {
          areaKind: "Client location",
          member: shortTypeName(card.type),
          before: language ? `previous ${language} client` : "previous client",
          after: target,
        },
      ];
    });
  /**
   * @param {DownstreamTypeCard} card
   * @param {AssessmentFinding[]} findings
   * @returns {ContractRow[]}
   */
  const genericContractRows = (card, findings) =>
    findings.map((finding) => ({
      areaKind: "SDK contract",
      member: shortTypeName(card.type),
      before: finding.expected,
      after: finding.actual,
    }));
  /** @param {DownstreamTypeCard["affectedMethods"]} methods */
  const affectedMethods = (methods) =>
    methods.length
      ? `<details class="affected-methods"><summary><strong>Affected SDK methods (${methods.length})</strong></summary>
<div class="affected-method-list">${methods
          .map(
            (method) =>
              `<div class="affected-method"><strong>${escapeHtml(method.symbol.split(".").at(-1) ?? method.symbol)}</strong><code>${escapeHtml(method.symbol)}</code></div>`,
          )
          .join("")}</div></details>`
      : '<p class="mapping-unavailable"><strong>Affected SDK methods:</strong> mapping unavailable</p>';
  const typeCards = downstreamTypeCards(dimension)
    .map((card) => {
      const directFindings = card.findings.filter((finding) => !groupedFindingIds.has(finding.id));
      const enumRows = enumContractRows(card);
      const modelRows = modelContractRows(card, directFindings);
      const structuredRows = [
        ...enumRows,
        ...modelRows,
        ...publicSurfaceRows(card, directFindings),
        ...clientLocationRows(card, directFindings),
      ].filter((row) => row.before !== row.after);
      const contractRows = structuredRows.length
        ? [
            ...new Map(
              structuredRows.map((row) => [
                `${row.areaKind}\u0000${row.member}\u0000${row.before}\u0000${row.after}`,
                row,
              ]),
            ).values(),
          ]
        : genericContractRows(card, directFindings);
      const shapeRow = enumRows.find((row) => row.kind === "shape");
      const memberChangeCount = enumRows.filter((row) => row.kind === "member").length;
      const propertyChangeCount = modelRows.length;
      const changeSummary = shapeRow
        ? `${shapeRow.before} changed to ${/^[aeiou]/i.test(shapeRow.after) ? "an" : "a"} ${shapeRow.after}${memberChangeCount ? `, with ${memberChangeCount} generated member ${memberChangeCount === 1 ? "renamed" : "changes"}` : ""}`
        : memberChangeCount
          ? `${memberChangeCount} generated member ${memberChangeCount === 1 ? "changed" : "changes"}`
          : propertyChangeCount
            ? `${propertyChangeCount} SDK type ${propertyChangeCount === 1 ? "property changed" : "properties changed"}`
            : `${contractRows.length} SDK type contract ${contractRows.length === 1 ? "change" : "changes"}`;
      const rationale = [
        ...new Set(directFindings.map((finding) => finding.rationale).filter(Boolean)),
      ].join(" ");
      const legacyAnchors = card.legacyImpactIds
        .map((id) => `<span id="downstream-${anchor(id)}"></span>`)
        .join("");
      return `<details class="finding sdk-contract-card" id="downstream-type-${anchor(card.type)}"><summary><strong>${escapeHtml(shortTypeName(card.type))}</strong><span class="contract-tag">SDK type</span></summary>
<div class="finding-body">${legacyAnchors}
<dl class="contract-metadata"><dt>SDK contract:</dt><dd><code>${escapeHtml(card.type)}</code></dd><dt>Change:</dt><dd>${escapeHtml(changeSummary)}</dd></dl>
<h4>Breaking changes</h4>
<table class="contract-change-table"><thead><tr><th>Contract area</th><th>Before</th><th>After</th></tr></thead><tbody>${contractRows
        .map(
          (row) =>
            `<tr>${renderContractAreaCell(row)}<td class="contract-before">${contractCell(row.before, row.beforeDetail, "before")}</td><td class="contract-after">${contractCell(row.after, row.afterDetail, "after")}</td></tr>`,
        )
        .join("")}</tbody></table>
${rationale ? `<div class="breaking-rationale"><strong>Why this is breaking:</strong> ${escapeHtml(rationale)}</div>` : ""}
${affectedMethods(card.affectedMethods)}
<div class="contract-footer"><span><strong>Related semantic intents:</strong> ${semanticLinks(card.relatedSemanticIntents)}</span></div>
</div></details>`;
    })
    .join("\n");
  const legacy = legacyFindingCards(directLegacyDownstreamFindings(dimension.legacyFindings), true);
  return `${groups}${typeCards}${legacy}`;
}

/**
 * @param {AssessmentOutput} assessment
 * @param {RenderOptions} [options]
 */
function renderCurrent(assessment, options = {}) {
  const { dimensions } = assessment;
  const summary = headerSummary(assessment);
  const reportHelpers = {
    escapeHtml,
    operationContractRows,
    restContractDelta,
    findingMatchesOperation,
    complianceFindingGroups,
    complianceCode,
    renderSourceHunks,
    sourceLinks,
    legacyEvidence,
    contractAreaParts,
    directLegacyDownstreamFindings,
    intentTitleLinks,
    semanticCard,
    downstreamOperationGroups,
  };
  const report = renderReportSections(assessment, reportHelpers, options);
  summary.restCount = report.restCount;
  summary.downstreamCount = report.downstreamCount;
  const restStatus = complianceStatus(
    dimensions.rest.status ?? (summary.restCount ? "failed" : "not-assessed"),
  );
  const downstreamStatus = complianceStatus(
    dimensions.downstream.status ?? (summary.downstreamCount ? "failed" : "not-assessed"),
  );
  const documentQuality = documentQualitySummary(dimensions.documentQuality);
  const documentStatus = complianceStatus(documentQuality.findingStatus);
  /** @type {Map<string, Partial<ArtifactComparison>>} */
  const comparisons = new Map(
    (assessment.artifactComparisons ?? []).map((item) => [item.projectId, item]),
  );
  const comparisonHeader = headerComparison(assessment);
  const projects = (assessment.projects ?? [])
    .map((project) => {
      /** @type {Partial<ArtifactComparison>} */
      const comparison = comparisons.get(project.id) ?? project.artifactComparison ?? {};
      const baselineArtifact = project.artifacts?.baseline ?? project.artifacts?.base;
      const targetArtifact = project.artifacts?.target ?? project.artifacts?.current;
      return `<tr><td><code>${escapeHtml(project.path)}</code></td><td>${escapeHtml(comparison.mode ?? "legacy")}</td><td><code>${escapeHtml(artifactLabel(comparison.baseline))}</code><br><small>${escapeHtml(comparison.baseline?.sourceRevision ?? "base")} · ${escapeHtml(comparison.baseline?.reason ?? "")}</small></td><td><code>${escapeHtml(artifactLabel(comparison.target))}</code><br><small>${escapeHtml(comparison.target?.sourceRevision ?? "current")} · ${escapeHtml(comparison.target?.reason ?? "")}</small></td><td>${escapeHtml(baselineArtifact?.autorest?.status ?? "n/a")} / ${escapeHtml(baselineArtifact?.tcgc?.status ?? "n/a")}</td><td>${escapeHtml(targetArtifact?.autorest?.status ?? "n/a")} / ${escapeHtml(targetArtifact?.tcgc?.status ?? "n/a")}</td></tr>`;
    })
    .join("");
  return `<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>TypeSpec Assessment</title>
<style>
:root{color-scheme:light dark;--bg:#f5f7fb;--panel:#fff;--text:#172033;--muted:#64748b;--line:#dbe3ef;--accent:#2563eb;--good:#047857;--warn:#b45309;--danger:#b91c1c;--add-bg:#dcfce7;--add-text:#166534;--remove-bg:#fee2e2;--remove-text:#991b1b}*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--text);font:15px/1.55 system-ui,sans-serif}.container{width:min(1100px,calc(100% - 32px));margin:auto}.hero{padding:38px 0 42px;background:linear-gradient(120deg,#172554,#2554d8);color:white}.hero .eyebrow{text-transform:uppercase;letter-spacing:.12em;font-size:13px;font-weight:800;color:#dbeafe}.hero h1{margin:.35em 0 .55em;font-size:clamp(34px,4.2vw,58px);line-height:1.08;letter-spacing:-.025em}.hero-meta{font-size:16px;color:#e0e7ff}.hero-meta strong{color:#86efac;text-transform:capitalize}.hero a{color:#dbeafe}.summary-grid{display:grid;grid-template-columns:repeat(6,minmax(0,1fr));gap:12px;margin-top:28px}.summary-card{display:block;min-height:150px;padding:18px;border:1px solid rgba(255,255,255,.2);border-radius:12px;background:rgba(255,255,255,.09);color:white!important;text-decoration:none;transition:background .15s,border-color .15s,transform .15s}.summary-card:hover,.summary-card:focus-visible{background:rgba(255,255,255,.16);border-color:rgba(255,255,255,.5);transform:translateY(-2px);outline:none}.summary-card:focus-visible{box-shadow:0 0 0 3px #93c5fd}.summary-value{display:flex;gap:10px;align-items:center;font-size:25px;font-weight:800}.summary-value .pass{color:#86efac}.summary-value .fail{color:#fecaca}.summary-label{margin-top:8px;font-size:16px;font-weight:750}.summary-detail{margin-top:7px;color:#dbeafe;font-size:13px}.notice{padding:16px 0;background:#fffbeb;color:#713f12;border-bottom:1px solid #fde68a}main{padding:28px 0}section{margin:0 0 30px}.dimension-details>summary{cursor:pointer;list-style-position:outside}.dimension-details>summary h2{display:inline-block;margin:0 0 12px}.panel,.finding,.intent,.operation,.compliance-intent,.compliance-comparison{background:var(--panel);border:1px solid var(--line);border-radius:12px;padding:18px;margin:10px 0}.finding{border-left:4px solid var(--warn)}.finding.high,.compliance-comparison.applicable-fail{border-left:4px solid var(--danger)}.finding.low{border-left-color:var(--muted)}.intent>summary{display:flex;align-items:center;gap:10px;flex-wrap:wrap}.intent>summary .action{margin-left:0}.intent-finding-badges{display:inline-flex;gap:7px;flex-wrap:wrap;margin-left:auto}.intent-finding-badge{border:1px solid #991b1b;border-radius:999px;padding:3px 10px;background:#b91c1c;color:#fff!important;font-size:13px;font-weight:800;text-decoration:none}.intent-finding-badge:hover,.intent-finding-badge:focus-visible{background:#7f1d1d;outline:2px solid #fca5a5;outline-offset:2px}.intent>summary,.representative-example>summary,.operation summary,.compliance-intent>summary,.compliance-comparison>summary,.finding>summary,.comparison-details>summary,.affected-operations>summary,.root-cause-provenance>summary{cursor:pointer}.intent>summary,.compliance-intent>summary{font-size:18px}.intent-body,.compliance-intent-body,.compliance-comparison-body{padding-top:12px}.finding>summary{display:flex;align-items:center;gap:12px;font-size:18px}.sdk-contract-card>summary,.sdk-method-card>summary{flex-wrap:wrap}.finding-summary{margin-left:auto;color:var(--muted);font-size:15px}.severity,.origin-tag,.contract-tag{border-radius:999px;padding:3px 10px;font-size:13px;font-weight:800}.contract-tag{background:#dbeafe;color:#1e40af}.severity{text-transform:lowercase}.severity.high{background:#fee2e2;color:#991b1b}.severity.medium{background:#fef3c7;color:#92400e}.severity.low{background:#dbeafe;color:#1e40af}.origin-tag.rest-breaking-tag{background:#fee2e2;color:#991b1b}.downstream-rest-link{display:flex;align-items:center;gap:12px;color:inherit;text-decoration:none}.downstream-rest-link:hover strong,.downstream-rest-link:focus-visible strong{text-decoration:underline}.finding-body{padding-top:12px}.comparison-details{margin:14px 0;padding:12px 14px;border:1px solid var(--line);border-radius:10px;background:color-mix(in srgb,var(--panel) 94%,var(--accent))}.comparison-details>summary{font-size:16px}.comparison-body{padding-top:12px}.contract-metadata{grid-template-columns:max-content minmax(0,1fr);margin:4px 0 22px}.http-contract{display:inline-flex;align-items:baseline;gap:8px;flex-wrap:wrap}.contract-change-table{border:1px solid var(--line);border-radius:10px;border-collapse:separate;border-spacing:0;overflow:hidden}.contract-change-table th{background:#eaf0f9}.contract-change-table th,.contract-change-table td{padding:13px 15px;border-right:1px solid var(--line)}.contract-change-table th:last-child,.contract-change-table td:last-child{border-right:0}.contract-member{width:31%;background:color-mix(in srgb,#eaf0f9 70%,var(--panel))}.contract-area-kind{display:block;margin-bottom:3px;color:var(--muted);font-size:11px;font-weight:800;letter-spacing:.08em;text-transform:uppercase}.contract-before{width:34.5%;background:#fff1f1}.contract-after{width:34.5%;background:#eefaf3}.contract-value{display:inline-block;padding:3px 7px;border-radius:5px;font-weight:700}.contract-value.before{background:var(--remove-bg);color:var(--remove-text)}.contract-value.after{background:var(--add-bg);color:var(--add-text)}.contract-detail{display:block;margin-top:4px;color:var(--muted);font-size:13px}.breaking-rationale{margin:17px 0 22px;padding:12px 14px;border-left:3px solid #e7a400;background:#fff9e8}.affected-operations{margin:20px 0}.affected-operations>summary{font-size:18px}.affected-operation-list{display:grid;gap:7px;margin-top:10px}.affected-operation{display:grid;grid-template-columns:minmax(230px,.8fr) 65px minmax(300px,1.8fr);align-items:center;gap:12px;padding:9px 12px;border:1px solid var(--line);border-radius:8px}.http-method{color:#075cab;font-family:ui-monospace,monospace;font-weight:800}.contract-footer{display:flex;flex-wrap:wrap;gap:10px 24px;margin-top:18px;color:var(--muted);font-size:13px}.root-cause-provenance{margin-top:14px}.mapping-unavailable{color:var(--muted)}.representative-example{margin:14px 0;padding:12px;border:1px solid var(--line);border-radius:9px}.operation summary{display:flex;gap:12px;align-items:center}.operation summary span,.action{margin-left:auto;border-radius:999px;padding:2px 8px;background:#dbeafe;color:#1e40af}.operation-body{padding-top:12px}.diff{background:#111827;color:#e5e7eb;border-radius:10px;overflow:auto;margin:12px 0}.diff-path{padding:7px 12px;background:#1f2937}.diff-path a{color:#93c5fd}.diff pre{padding:12px;margin:0}.diff pre span{display:block}.diff pre .line-number{display:inline-block;width:42px;color:#94a3b8;user-select:none}.diff .add{background:#123d2a;color:#bbf7d0}.diff .remove{background:#51212a;color:#fecaca}.parameter-diff{margin:12px 0}.parameter-line{display:flex;gap:8px;align-items:baseline;padding:5px 9px;margin:3px 0;border-radius:6px}.parameter-line.add,.delta-after,ins{background:var(--add-bg);color:var(--add-text)}.parameter-line.remove,.delta-before,del{background:var(--remove-bg);color:var(--remove-text)}.parameter-line.modify,.parameter-line.reorder{background:#fef3c7;color:#92400e}.parameter-line>span:first-child{font-weight:800}.parameter-attribute{white-space:nowrap}.delta-before,.delta-after,del,ins{padding:2px 5px;border-radius:4px;text-decoration:none}dl{display:grid;grid-template-columns:max-content 1fr;gap:8px 14px}dt{font-weight:700}dd{margin:0}.not-assessed{color:var(--muted);font-weight:700}.good,.compliance-summary.passed{color:var(--good)}.compliance-summary.failed{color:var(--danger)}.sources{color:var(--muted);font-size:13px}blockquote{margin:8px 0;padding:8px 12px;border-left:3px solid var(--accent);background:color-mix(in srgb,var(--panel) 90%,var(--accent))}table{width:100%;border-collapse:collapse}th,td{text-align:left;padding:8px;border-bottom:1px solid var(--line)}code{overflow-wrap:anywhere}@media(max-width:1050px){.summary-grid{grid-template-columns:repeat(3,minmax(0,1fr))}.affected-operation{grid-template-columns:1fr 65px}.affected-operation code{grid-column:1/-1}}@media(max-width:700px){.summary-grid{grid-template-columns:repeat(2,minmax(0,1fr));}.finding-summary{width:100%;margin-left:0}.contract-change-table{display:block;overflow-x:auto}.contract-change-table th,.contract-change-table td{min-width:210px}}@media(max-width:540px){.summary-grid{grid-template-columns:1fr}.hero h1{font-size:32px}}@media(prefers-color-scheme:dark){:root{--bg:#0f172a;--panel:#172033;--text:#e5e7eb;--muted:#9ca3af;--line:#334155;--add-bg:#123d2a;--add-text:#bbf7d0;--remove-bg:#51212a;--remove-text:#fecaca}.notice{background:#422006;color:#fde68a}.parameter-line.modify,.parameter-line.reorder{background:#422006;color:#fde68a}.contract-change-table th{background:#202d45}.contract-member{background:#1d293d}.contract-before{background:#431f29}.contract-after{background:#15382b}.breaking-rationale{background:#3b2f13}.http-method{color:#76b9ff}}
.tag{border-radius:999px;padding:3px 10px;background:#dbeafe;color:#1e40af;font-size:13px;font-weight:800}.finding-summary-meta{margin-left:auto;color:var(--muted);font-size:14px}.rest-operation-list{display:grid;gap:7px}.rest-operation-line{display:grid;grid-template-columns:minmax(220px,1fr) auto minmax(260px,2fr);gap:12px;padding:9px 11px;border:1px solid var(--line);border-radius:8px}.rest-operation-line>span{color:var(--muted)}@media(max-width:700px){.rest-operation-line{grid-template-columns:1fr}.finding-summary-meta{width:100%;margin-left:0}}
.finding{border-left:1px solid var(--line)}
.rest-contract-card .contract-tag{background:#fee2e2;color:#991b1b}.rest-contract-card .rest-operation-list{margin-top:10px}
.notice{padding:0}.notice>summary{display:flex;min-height:46px;align-items:center;gap:10px;padding:8px 0;cursor:pointer;list-style:none}.notice>summary::-webkit-details-marker{display:none}.notice>summary::before{content:"▸";flex:none;color:#b45309;font-size:15px;font-weight:900;transition:transform .15s ease}.notice[open]>summary::before{transform:rotate(90deg)}.notice-title{flex:none;font-size:14px;font-weight:800}.notice-summary{overflow:hidden;color:color-mix(in srgb,currentColor 78%,var(--muted));font-size:12.5px;text-overflow:ellipsis;white-space:nowrap}.notice-body{display:grid;grid-template-columns:1fr 1fr;gap:24px;padding:0 0 12px 25px;font-size:12.5px;line-height:1.4}.notice-body p{margin:0}@media(max-width:700px){.notice-summary{display:none}.notice-body{grid-template-columns:1fr;gap:6px}}@media(prefers-color-scheme:dark){.notice>summary::before{color:#fbbf24}}
.compliance-finding-group>summary{flex-wrap:wrap}.compliance-affected-intents{display:grid;gap:12px}.compliance-affected-intent{margin:0;padding:14px 16px;border:1px solid var(--line);border-radius:10px}.compliance-affected-intent h4{margin:0 0 8px}.compliance-affected-intent h5{margin:14px 0 6px}
.intent-finding-badge{font:inherit;font-size:13px;cursor:pointer}.intent-impact-trigger{position:relative}.intent-impact-popover{position:absolute;z-index:20;top:calc(100% + 8px);right:0;display:none;width:min(480px,88vw);overflow:hidden;border:1px solid var(--line);border-radius:10px;background:var(--panel);box-shadow:0 14px 34px rgb(31 42 68 / 18%)}.intent-impact-trigger.open .intent-impact-popover{display:grid}.intent-impact-popover a{display:grid;grid-template-columns:minmax(240px,1fr) auto;gap:12px;align-items:center;padding:12px 14px;border-top:1px solid var(--line);color:var(--text)!important;text-decoration:none}.intent-impact-popover a:first-child{border-top:0}.intent-impact-popover a:hover,.intent-impact-popover a:focus-visible{background:color-mix(in srgb,var(--panel) 92%,var(--accent))}.intent-impact-popover a span{color:var(--muted);font-size:13px}.intent h3,.representative-example>summary{font-size:17px;font-weight:750;line-height:1.35}.impact-highlight{outline:3px solid #ef4444;outline-offset:3px}
.affected-methods{margin:20px 0}.affected-methods>summary{font-size:18px}.affected-method-list{display:grid;gap:7px;margin-top:10px}.affected-method{display:grid;grid-template-columns:minmax(180px,.6fr) minmax(280px,1.4fr);align-items:center;gap:12px;padding:9px 12px;border:1px solid var(--line);border-radius:8px}@media(max-width:700px){.affected-method{grid-template-columns:1fr}}
${reportStyles}
</style></head><body>
<header class="hero"><div class="container"><div class="eyebrow">TypeSpec Assessment</div><h1>${escapeHtml(headerTitle(assessment))}</h1>
<p class="hero-meta">TypeSpec source diff: ${comparisonHeader}</p>
<div class="summary-grid">
<a class="summary-card" href="#semantic-intents">${summaryHeading("Semantic intents", { icon: "ⓘ", className: "info", label: "Information only" })}<div class="summary-detail">${summary.semanticItems.length} ${summary.semanticItems.length === 1 ? "intent" : "intents"}<br>${summary.operationCount} operations<br>${summary.actionCounts.add} Added, ${summary.actionCounts.modify} Modified, ${summary.actionCounts.remove} Removed</div></a>
<a class="summary-card" href="#azure-compliance">${summaryHeading("Azure Guidelines", complianceStatus(summary.complianceStatus))}<div class="summary-detail">${complianceStatus(summary.complianceStatus).label === "N/A" ? "Not assessed<br>" : ""}${summary.complianceFindingCount} ${summary.complianceFindingCount === 1 ? "finding" : "findings"}<br>${escapeHtml(summary.complianceCoverageDetail)}</div></a>
<a class="summary-card" href="#rest-breaking">${summaryHeading("REST breaking changes", restStatus)}<div class="summary-detail">${restStatus.label === "N/A" ? "Not assessed<br>" : ""}${summary.restFindingCount} ${summary.restFindingCount === 1 ? "finding" : "findings"}</div></a>
<a class="summary-card" href="#downstream-breaking">${summaryHeading("Downstream breaking changes", downstreamStatus)}<div class="summary-detail">${downstreamStatus.label === "N/A" ? "Not assessed<br>" : ""}${summary.downstreamFindingCount} ${summary.downstreamFindingCount === 1 ? "finding" : "findings"}</div></a>
<a class="summary-card" href="#document-quality">${summaryHeading("Documentation Completeness", documentStatus)}<div class="summary-detail">${documentQuality.compactDetail.map(escapeHtml).join("<br>")}</div></a>
</div></div></header>
<details class="notice"><summary class="container"><span class="notice-title">Preview Notice</span><span class="notice-summary">The TypeSpec Assessment Assistant is in preview; official validation and review remain the source of truth.</span></summary>
<div class="container notice-body"><p>The TypeSpec Assessment Assistant is currently in preview. Its goal is to help service developers build confidence earlier in the TypeSpec authoring workflow by providing contextual analysis, risk identification, and guidance on potential downstream impacts.</p>
<p>This report is intended as a review reference and learning aid only. It does not replace official ARM API, Azure API Stewardship, Azure Breaking Change reviews, and should not be treated as authoritative review feedback or approval for specification changes. Official validation tools, generated artifacts, and reviewer feedback remain the source of truth for merge and release decisions.</p></div></details>
<main class="container">
${report.html}
<section id="appendix"><details class="dimension-details"><summary><h2>Appendix</h2></summary><div class="panel">${report.appendixHtml}<h3 id="potential-limits">Potential limits</h3>${assessment.blockers.length ? `<ul>${assessment.blockers.map((blocker) => `<li>${escapeHtml(isRecord(blocker) ? blocker.message : blocker)}</li>`).join("")}</ul>` : "<p>None</p>"}
<h3 id="projects-and-compiler-status">Projects and compiler status</h3><table><thead><tr><th>Project</th><th>Mode</th><th>Baseline commit@version</th><th>Target commit@version</th><th>Baseline AutoRest / TCGC</th><th>Target AutoRest / TCGC</th></tr></thead><tbody>${projects}</tbody></table>
<p><strong>Pull request:</strong> ${pullRequestLink(assessment)}</p>
<h3 id="compliance-search-evidence">Guidance fetched</h3>
${complianceEvidenceAppendix(dimensions.compliance)}
<h3>Changed files</h3><ul>${(assessment.changedFiles ?? []).map((file) => `<li><code>${escapeHtml(file.path)}</code> (${escapeHtml(file.origins.join(", "))})</li>`).join("")}</ul>
<h3>Timing and model input</h3><pre>${escapeHtml(JSON.stringify({ timings: assessment.timings, inputAccounting: assessment.inputAccounting }, null, 2))}</pre>
<p><strong>Provenance:</strong> ${Object.values(assessment.provenance ?? {})
    .map(escapeHtml)
    .join(", ")}</p></div></details></section>
</main>
<script>
function revealHashTarget() {
  const target = document.getElementById(location.hash.slice(1));
  if (!target) return;
  for (let element = target; element; element = element.parentElement) {
    if (element.tagName === "DETAILS") element.open = true;
  }
  target.scrollIntoView({ block: "start" });
}
window.addEventListener("hashchange", revealHashTarget);
document.addEventListener("click", (event) => {
  if (event.target instanceof Element &&
      event.target.closest(".report-card > summary .report-intent-relations") &&
      !event.target.closest("a")) {
    event.preventDefault();
    return;
  }
  const link = event.target instanceof Element
    ? event.target.closest('a[href^="#"]')
    : null;
  if (link) {
    event.preventDefault();
    location.hash = link.getAttribute("href");
    window.setTimeout(revealHashTarget);
  }
});
revealHashTarget();
</script>
</body></html>\n`;
}

/** @param {LegacyAssessmentInput} assessment @returns {AssessmentOutput} */
function adaptLegacy(assessment) {
  const dimensions = assessment.dimensions;
  const source = assessment.assessmentEvidence?.changedTypeSpec ?? [];
  const semanticItems = dimensions.semanticUnderstanding.items;
  const typeSpecDiffs = semanticItems.flatMap((item) =>
    item.changes.flatMap((change) => change.typeSpecDiffs ?? []),
  );
  const legacyProjects = (assessment.projects ?? []).map((projectPath) => {
    const projectDiffs = typeSpecDiffs.filter(
      (diff) => diff.path === projectPath || diff.path.startsWith(`${projectPath}/`),
    );
    const base = extractApiVersions(
      projectDiffs.map((diff) =>
        (diff.lines ?? [])
          .filter((line) => !line.startsWith("+"))
          .map((line) => (line.startsWith("-") ? line.slice(1) : line))
          .join("\n"),
      ),
    );
    const current = extractApiVersions(
      projectDiffs.map((diff) =>
        (diff.lines ?? [])
          .filter((line) => !line.startsWith("-"))
          .map((line) => (line.startsWith("+") ? line.slice(1) : line))
          .join("\n"),
      ),
    );
    const artifactComparison =
      base.versions.length && current.versions.length
        ? selectApiVersionPair({
            base: { ...base, versioned: true },
            current: { ...current, versioned: true },
            baseCommit: assessment.baseline.commit,
            headCommit: assessment.head.commit,
          })
        : undefined;
    return {
      id: projectPath,
      path: projectPath,
      sourceChangeIds: [],
      artifacts: {},
      blockers: [],
      artifactComparison,
    };
  });
  const hasCodeSafetyFinding =
    dimensions.restBreakingChanges.findings.length > 0 ||
    dimensions.restCompatibleDownstreamBreakingChanges.findings.length > 0;
  const requestedSafetyStatus = assessment.overallCodeSafety?.toLowerCase();
  const safetyStatus =
    requestedSafetyStatus === "passed" ||
    requestedSafetyStatus === "failed" ||
    requestedSafetyStatus === "not-assessed"
      ? requestedSafetyStatus
      : (assessment.errors ?? []).length
        ? "not-assessed"
        : hasCodeSafetyFinding
          ? "failed"
          : "passed";
  const restFindingIds = new Set(dimensions.restBreakingChanges.findings.map(({ id }) => id));
  const downstreamFindingIds = new Set(
    dimensions.restCompatibleDownstreamBreakingChanges.findings.map(({ id }) => id),
  );
  /** @type {Record<"added" | "modified" | "removed", "add" | "modify" | "remove">} */
  const action = { added: "add", modified: "modify", removed: "remove" };
  /**
   * @param {number} leftStart
   * @param {number} leftEnd
   * @param {number} rightStart
   * @param {number} rightEnd
   */
  const rangesOverlap = (leftStart, leftEnd, rightStart, rightEnd) =>
    leftStart <= rightEnd && rightStart <= leftEnd;
  /** @param {LegacyAssessmentSourceReference} reference */
  const sourceLink = (reference) => {
    if (/^https?:\/\//.test(reference.link ?? "")) return reference.link;
    return (
      source.find(
        (item) =>
          item.path === reference.path &&
          item.revision === reference.revision &&
          rangesOverlap(item.startLine, item.endLine, reference.startLine, reference.endLine),
      )?.link ?? reference.link
    );
  };
  /**
   * @param {LegacyAssessmentSourceReference[]} [references]
   * @param {LegacyAssessmentDiff[]} [diffs]
   * @param {string} [prefix]
   * @returns {SourceChange[]}
   */
  const toSources = (references = [], diffs = [], prefix = "legacy") =>
    references.map((reference, index) => {
      const matchingDiff = diffs.find((diff) => {
        if (diff.path !== reference.path) return false;
        const start = reference.revision === "head" ? diff.newStart : diff.oldStart;
        const count = reference.revision === "head" ? diff.newCount : diff.oldCount;
        return (
          typeof start === "number" &&
          Number.isFinite(start) &&
          rangesOverlap(
            reference.startLine,
            reference.endLine,
            start,
            start + Math.max((count ?? 1) - 1, 0),
          )
        );
      });
      const id = `${prefix}-source-${index}`;
      const hunkId = `${prefix}-hunk-${index}`;
      const range = {
        startLine: reference.startLine,
        endLine: reference.endLine,
      };
      return {
        id,
        path: reference.path,
        status: "modified",
        origins: ["historical"],
        hunks: [
          {
            id: hunkId,
            lines: matchingDiff?.lines ?? [],
            base: range,
            current: range,
          },
        ],
        declarations: [
          {
            id: `${prefix}-declaration-${index}`,
            kind: "unknown",
            qualifiedName: reference.path,
            decorators: [],
            versionedMembers: [],
            hunkIds: [hunkId],
            source: {
              revision: reference.revision === "head" ? "current" : "base",
              startLine: reference.startLine,
              endLine: reference.endLine,
              link: sourceLink(reference),
            },
          },
        ],
      };
    });
  /** @param {string} findingId */
  const relatedSemanticIntents = (findingId) =>
    semanticItems
      .filter((item) => item.changes.some((change) => change.linkedFindingIds?.includes(findingId)))
      .map(({ id }) => id);
  /**
   * @param {LegacyAssessmentFindingInput[]} findings
   * @returns {LegacyAssessmentFinding[]}
   */
  const legacyFindings = (findings) =>
    findings.map((finding) => ({
      ...finding,
      relatedSemanticIntents: relatedSemanticIntents(finding.id),
      sources: toSources(finding.sourceReferences, [], `legacy-finding-${finding.id}`),
    }));
  /** @type {(ComplianceFinding & {id: string})[]} */
  const legacyComplianceFindings =
    dimensions.azureCompliance.findings?.map((finding) => ({
      ...finding,
      semanticIntentId: relatedSemanticIntents(finding.id)[0] ?? finding.id,
      decision: "applicable-fail",
      actual: finding.summary ?? "",
      gap: finding.summary ?? "",
      applicableGuidance: [],
      relatedSemanticIntents: relatedSemanticIntents(finding.id),
      sourceReferences: (finding.sourceReferences ?? []).map((reference) => ({
        ...reference,
        link: sourceLink(reference),
      })),
      codeSnippets: (finding.codeSnippets ?? []).map((snippet) => ({
        ...snippet,
        link: sourceLink({
          path: snippet.path,
          revision: "head",
          startLine: snippet.startLine,
          endLine: snippet.endLine,
        }),
      })),
    })) ?? [];
  return {
    schemaVersion: 1,
    title: assessment.title,
    pullRequest: assessment.url ? { number: assessment.pr, url: assessment.url } : undefined,
    comparison: {
      baseCommit: assessment.baseline.commit,
      headCommit: assessment.head.commit,
      workingTree: false,
    },
    confidence: assessment.overallConfidence ?? "medium",
    safety: { scope: "rest-and-downstream-only", status: safetyStatus },
    dimensions: {
      semantic: {
        status: "ready",
        items: semanticItems.map((item) => {
          const change = item.changes[0] ?? {};
          const linkedFindingIds = item.changes.flatMap(
            ({ linkedFindingIds = [] }) => linkedFindingIds,
          );
          const itemSources = toSources(
            item.sourceReferences,
            item.changes.flatMap(({ typeSpecDiffs = [] }) => typeSpecDiffs),
            `legacy-${item.id}`,
          );
          const projectId =
            legacyProjects.find((project) =>
              itemSources.some(
                (itemSource) =>
                  itemSource.path === project.path ||
                  itemSource.path.startsWith(`${project.path}/`),
              ),
            )?.id ??
            legacyProjects[0]?.id ??
            "legacy";
          const operationIds = (item.restRepresentation?.operations ?? []).map(
            (operation) => operation.operationId,
          );
          return {
            id: item.id,
            projectId,
            sourceChangeIds: itemSources.map((itemSource) => itemSource.id),
            hunkIds: itemSources.flatMap((itemSource) => itemSource.hunks.map((hunk) => hunk.id)),
            declarationIds: itemSources.flatMap((itemSource) =>
              itemSource.declarations.map((declaration) => declaration.id),
            ),
            declarationNames: itemSources.flatMap((itemSource) =>
              itemSource.declarations.map((declaration) => declaration.qualifiedName),
            ),
            ownedOperationIds: operationIds,
            operationIds,
            beforeFactIds: [],
            afterFactIds: [],
            changedAspects: [],
            action: change.kind ? (action[change.kind] ?? "modify") : "modify",
            title: item.intent,
            summary: item.restRepresentation?.summary ?? change.summary ?? item.intent,
            operations: (item.restRepresentation?.operations ?? []).map((operation) => ({
              ...operation,
              sourceChangeIds: [],
              hunkIds: [],
              declarationIds: [],
              matchBasis: "legacy",
              apiVersion: operation.apiVersion ?? operation.apiVersions?.join(", ") ?? "",
              changedAspects: [],
              outcome: change.effect ?? item.restRepresentation?.summary ?? change.summary,
            })),
            sources: itemSources,
            relatedFindings: {
              rest: linkedFindingIds.filter((id) => restFindingIds.has(id)),
              downstream: linkedFindingIds.filter((id) => downstreamFindingIds.has(id)),
              sharedTypeImpact: [],
              compliance: linkedFindingIds.filter((id) =>
                legacyComplianceFindings.some((finding) => finding.id === id),
              ),
            },
          };
        }),
      },
      rest: {
        status: dimensions.restBreakingChanges.findings.length > 0 ? "failed" : "passed",
        findings: [],
        legacyFindings: legacyFindings(dimensions.restBreakingChanges.findings),
      },
      downstream: {
        status:
          dimensions.restCompatibleDownstreamBreakingChanges.findings.length > 0
            ? "failed"
            : "passed",
        findings: [],
        legacyFindings: legacyFindings(dimensions.restCompatibleDownstreamBreakingChanges.findings),
        operationGroups: [],
        sharedTypeImpacts: [],
        ...{ impliedByRest: [] },
      },
      compliance: {
        status: dimensions.azureCompliance.status ?? "not-assessed",
        summary:
          dimensions.azureCompliance.reason ??
          `${dimensions.azureCompliance.findings?.length ?? 0} historical Azure Guidelines finding(s).`,
        coverage: {
          semanticIntentCount: 0,
          assessedIntentCount: 0,
          selectedDocumentCount: dimensions.azureCompliance.documents?.length ?? 0,
          unassessedIntentIds: [],
        },
        intentAssessments: [],
        findings: [],
        retrievalFailures: [],
        blockers:
          dimensions.azureCompliance.status === "not-assessed"
            ? [
                dimensions.azureCompliance.reason ??
                  "Historical Azure Guidelines were not assessed.",
              ]
            : [],
        legacyDocuments: dimensions.azureCompliance.documents ?? [],
        legacyFindings: legacyComplianceFindings,
      },
      documentQuality: {
        status: "not-assessed",
        summary: "Documentation Completeness is not assessed.",
      },
    },
    blockers: assessment.errors ?? [],
    projects: legacyProjects,
    changedFiles: source.map((item, index) => ({
      id: `legacy-changed-${index}`,
      path: item.path,
      status: "modified",
      origins: ["historical"],
      hunks: [],
      declarations: [],
    })),
    provenance: { source: "legacy assessment adapter" },
  };
}

/**
 * @param {AssessmentOutput | LegacyAssessmentInput} assessment
 * @param {RenderOptions} [options]
 */
export function renderAssessmentHtml(assessment, options = {}) {
  const current = isCurrentAssessment(assessment);
  const validationInput = current
    ? assessment
    : {
        baseline: assessment.baseline,
        head: assessment.head,
        dimensions: assessment.dimensions,
      };
  const errors = validateAssessment(validationInput);
  if (errors.length) throw new Error(errors.join("\n"));
  return renderCurrent(current ? assessment : adaptLegacy(assessment), options);
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2));
    const [input, output] = args._ ?? [];
    if (!input || !output) {
      throw new Error(
        "Usage: render-assessment-html.mjs <assessment.json> <assessment.html> [--downstream-input <downstream-breaking-input.json>] [--downstream-assessment <matching-assessment.json>]",
      );
    }
    const assessment = readJsonObject(path.resolve(input));
    if (!isAssessmentInput(assessment)) {
      throw new Error("Input is not an assessment.");
    }
    const downstreamInputPath = optionalCliPath(args.downstream_input, "--downstream-input");
    const downstreamAssessmentPath = optionalCliPath(
      args.downstream_assessment,
      "--downstream-assessment",
    );
    const downstreamInput = downstreamInputPath
      ? readJsonObject(path.resolve(downstreamInputPath))
      : undefined;
    if (downstreamInput !== undefined && !isDownstreamAnalysis(downstreamInput)) {
      throw new Error("--downstream-input is not a downstream analysis.");
    }
    const downstreamAssessment = downstreamAssessmentPath
      ? readJsonObject(path.resolve(downstreamAssessmentPath))
      : undefined;
    if (
      downstreamAssessment !== undefined &&
      (!isAssessmentInput(downstreamAssessment) || !isCurrentAssessment(downstreamAssessment))
    ) {
      throw new Error("--downstream-assessment is not a current assessment.");
    }
    const html = renderAssessmentHtml(assessment, {
      downstreamInput,
      downstreamAssessment,
    });
    fs.mkdirSync(path.dirname(path.resolve(output)), { recursive: true });
    fs.writeFileSync(path.resolve(output), html);
    console.log(path.resolve(output));
  });
}
